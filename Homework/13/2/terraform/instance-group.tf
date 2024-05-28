data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key = file("~/.ssh/yc.pub")
    passwd = var.cloud_password
    bucket = yandex_storage_bucket.netology-bucket.bucket_domain_name
  }
}

resource "yandex_iam_service_account" "sa-ig" {
  name      = "sa-for-ig"
}

resource "yandex_resourcemanager_folder_iam_member" "ig-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-ig.id}"
}

resource "yandex_compute_instance_group" "ig-1" {
  name               = "fixed-ig-with-balancer"
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.sa-ig.id

  instance_template {
    resources {
      cores  = 2
      memory = 1
      core_fraction = 20
    }
    boot_disk {
      initialize_params {
        image_id = var.lamp-instance-image-id
      }
    }
    network_interface {
      network_id  = yandex_vpc_network.network-1.id
      subnet_ids  = [yandex_vpc_subnet.subnet-public.id]
      nat         = true
    }
    scheduling_policy {
      preemptible = true
    }
    metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = 1
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable  = 1
    max_creating     = 3
    max_expansion    = 1
    max_deleting     = 1
    startup_duration = 3
  }

  health_check {
    http_options {
      port    = 80
      path    = "/"
    }
  }

  depends_on = [
    yandex_storage_bucket.netology-bucket
  ]

  load_balancer {
    target_group_name = "target-group"
  }
}