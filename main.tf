terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.83.0"
    }
  }
  //--------------------------------------config----------------------------------------------
  /*
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "b5-sa2-bucket"
    region                      = "ru-central1-a"
    key                         = "./b5-sa2.tfstate"
    access_key                  = local.sa2-bucket-access-key
    secret_key                  = local.sa2-bucket-secret_key
    skip_region_validation      = true
    skip_credentials_validation = true
  }
*/
}

provider "yandex" { //Установить провайдер YC
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}


resource "yandex_iam_service_account" "sa2" { //Создать service account
  folder_id = var.folder_id
  name      = "sa2"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" { //Выдать права
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa2.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa2-static-key" { // Создать  Static Access Keys
  service_account_id = yandex_iam_service_account.sa2.id
  description        = "static access key for object storage"
}
output "sa2-access" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
}
output "sa2-secret" {
  value = nonsensitive(yandex_iam_service_account_static_access_key.sa2-static-key.secret_key)
}
/*
locals {
  sa2-bucket-acces-key  = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
  sa2-bucket-secret-key = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
}

//-----------------------------------------Создать бакет-------------------------------------
resource "yandex_storage_bucket" "bucket2" {
  access_key = local.sa2-bucket-access-key
  secret_key = local.sa2-bucket-secret-key
  bucket     = "b5-sa2-bucket"
}
*/
//----------------------------СЕТЬ-------------------------------------
resource "yandex_vpc_network" "sfnet1" {
  name = "sfnet1"
}

resource "yandex_vpc_subnet" "sfsubnet-a" { //ПОДСЕТЬ A
  v4_cidr_blocks = ["192.168.4.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.sfnet1.id
}

resource "yandex_vpc_subnet" "sfsubnet-b" { //ПОДСЕТЬ B
  v4_cidr_blocks = ["192.168.5.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.sfnet1.id
}

//---------------------------------------ВМ----------------------------------------------
resource "yandex_compute_instance" "vm3" {
  name = "vm3"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sfsubnet-a.id
  }
  metadata = {
    user-data          = "${file("./meta.txt")}"
    serial-port-enable = 1
  }
  boot_disk {
    initialize_params {
      image_id = "fd8scqsds5me81jjilu9"
    }
  }

}

resource "yandex_compute_instance" "vm4" {
  name = "vm4"
  zone = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sfsubnet-b.id
  }
  metadata = {
    user-data          = "${file("./meta.txt")}"
    serial-port-enable = 1
  }
  boot_disk {
    initialize_params {
      image_id = "fd8ts5msch9mnp4ott9m"
    }
  }

}
