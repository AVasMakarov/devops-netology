output "vm_ip_address" {
  value = {
    "${yandex_compute_instance.terraform1.name}" = "${yandex_compute_instance.terraform1.network_interface[0].nat_ip_address}"
    "${yandex_compute_instance.terraform2.name}" = "${yandex_compute_instance.terraform2.network_interface[0].nat_ip_address}"
  }
}