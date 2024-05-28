#output "internal_ip_address_nat_vm" {
#  value = yandex_compute_instance.nat-instance.network_interface.0.ip_address
#}
#
#output "external_ip_address_nat_vm" {
#  value = yandex_compute_instance.nat-instance.network_interface.0.nat_ip_address
#}
#
#output "internal_ip_address_public_vm" {
#  value = yandex_compute_instance.public-vm.network_interface.0.ip_address
#}
#
#output "external_ip_address_public_vm" {
#  value = yandex_compute_instance.public-vm.network_interface.0.nat_ip_address
#}
#
#output "internal_ip_address_private_vm" {
#  value = yandex_compute_instance.private-vm.network_interface.0.ip_address
#}
#
#output "external_ip_address_private_vm" {
#  value = yandex_compute_instance.private-vm.network_interface.0.nat_ip_address
#}

output "external_load_balancer_ip" {
  value = yandex_lb_network_load_balancer.load-balancer-1.listener.*.external_address_spec[0].*.address[0]
}

output "bucket_domain_name" {
  value = "http://${yandex_storage_bucket.netology-bucket.bucket_domain_name}/today.jpg"
}