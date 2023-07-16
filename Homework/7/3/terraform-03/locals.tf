###Name for VM
locals {
  name = "vm_count"



  ###Resources
  vm_resources = {
    vm_resources = {
      cores         = 2
      memory        = 1
      core_fraction = 5

    }
  }
  ###Metadata
  credential = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file("~/.ssh/yc.pub")}"
  }
}