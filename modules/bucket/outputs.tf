output "sa2-secret-key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
}
output "sa2-access-key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
}
