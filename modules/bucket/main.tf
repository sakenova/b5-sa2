// Create SA
/*
resource "yandex_iam_service_account" "sa2" {
  folder_id = var.folder_id
  name      = "sa2"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa2.id}"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa2-static-key" {
  service_account_id = yandex_iam_service_account.sa2.id
  description        = "static access key for object storage"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "bucket2" {
  access_key = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
  bucket = "b5-sa2-bucket"
}

locals {
  sa2-bucket-acces-key = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
  sa2-bucket-secret-key = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
}
/* variable "sa2-bucket-access-key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
}

variable "sa2-bucket-secret-key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
}
output "sa2-bucket-access-key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
}

output "sa2-bucket-secret-key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
}

terraform { 
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
}
*/