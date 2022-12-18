/*
output "sa2-secret-key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
}
output "sa2-access-key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
}

output "internal_ip_address_vm3" {
  value = yandex_compute_instance.vm3.network_interface.0.ip_address
}

output "external_ip_address_vm3" {
  value = yandex_compute_instance.vm3.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm4" {
  value = yandex_compute_instance.vm4.network_interface.0.ip_address
}

output "external_ip_address_vm4" {
  value = yandex_compute_instance.vm4.network_interface.0.nat_ip_address
}
*/