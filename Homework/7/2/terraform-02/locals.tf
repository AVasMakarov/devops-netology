###Name for VM
locals {
  name_web = "${var.vm_web_name}-${var.vm_web_platform}"
  name_db = "${var.vm_db_name}-${var.vm_db_platform}"
###Resources
  vm_resources = {
    vm_web_resources = {
      cores         = 2
      memory        = 1
      core_fraction = 5

    }
    vm_db_resources = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
###Metadata
  credential = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUzAgWxwtumjjkoUj+aK7tAXZ/1fvnqmACzpD/+Qehc mav@mav-pc"
  }
}