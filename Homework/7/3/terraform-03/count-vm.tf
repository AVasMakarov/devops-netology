

resource "yandex_compute_instance" "count" {
  count = 2
  name        = "${local.name}-${count.index+1}"
  platform_id = var.vm_platform
  resources {
    cores         = local.vm_resources.vm_resources.cores
    memory        = local.vm_resources.vm_resources.memory
    core_fraction = local.vm_resources.vm_resources.core_fraction
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