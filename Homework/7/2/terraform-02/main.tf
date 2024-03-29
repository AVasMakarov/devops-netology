resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
resource "yandex_compute_instance" "terraform1" {
  name        = local.name_web
  platform_id = var.vm_web_platform
  resources {
    cores         = local.vm_resources.vm_web_resources.cores
    memory        = local.vm_resources.vm_web_resources.memory
    core_fraction = local.vm_resources.vm_web_resources.core_fraction
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
    nat       = true
  }

  metadata = local.credential

}

data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_image
}
resource "yandex_compute_instance" "terraform2" {
  name        = local.name_db
  platform_id = var.vm_db_platform
  resources {
    cores         = local.vm_resources.vm_db_resources.cores
    memory        = local.vm_resources.vm_db_resources.memory
    core_fraction = local.vm_resources.vm_db_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = local.credential

}