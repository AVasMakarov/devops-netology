resource "yandex_compute_instance" "vm_4_each" {
  depends_on = [yandex_compute_instance.count]

  for_each =   {
    "main" = var.each[0]
    "replica" = var.each[1]
  }
  name        = each.value.vm_name
  platform_id = var.vm_platform
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
   }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  metadata = local.credential

}