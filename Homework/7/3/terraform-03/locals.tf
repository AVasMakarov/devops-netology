###Name for VM
locals {
  vm_name = "web"
  disk-name = "storage"
  ###Resources
  vm_resources = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  ###Metadata
  credential = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file("~/.ssh/yc.pub")}"
  }
}