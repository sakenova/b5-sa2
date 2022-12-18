resource "yandex_vpc_network" "sfnet1" { //СЕТЬ
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

module "bucket" {
  source = "./modules/bucket"

}

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
