//Указать версию провайдера YC
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.83.0"
    }
  }
  /* #переносим файл в созданное хранилище
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "b5-sa-1"
    region                      = "ru-central1-a"
    key                         = "./b5-sa.tfstate"
    access_key                  = "YCAJE8b-xu5_tqJu1EXiuLSLJ"
    secret_key                  = "YCNd-OD7NtBdp4r-IB31llO0gzLQGjZAOxgRI1R8"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
*/
}
//Установить провайдер YC
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}