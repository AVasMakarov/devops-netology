resource "yandex_compute_disk" "vm_disk" {
  count      = 3
  name       = "${local.disk-name}-${count.index}"
  type       = var.disk_type
  zone       = var.default_zone
  size       = 1
}

resource "yandex_compute_instance" "storage" {
  depends_on = [yandex_compute_disk.vm_disk]
  name        = "${local.vm_name}-storage"
  platform_id = var.vm_platform
  resources {
    cores         = local.vm_resources.cores
    memory        = local.vm_resources.memory
    core_fraction = local.vm_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic secondary_disk {
      for_each = yandex_compute_disk.vm_disk[*].id
      content {
      disk_id = secondary_disk.value
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