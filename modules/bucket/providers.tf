//Указать версию провайдера YC
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.83.0"
    }
  }
}

//Установить провайдер YC
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}