###Name for VM
locals {
  name = "web"

  ###Resources
  vm_resources = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  ###resources for_each
#  each = [
#    {
#      vm_name       = "main"
#      cpu           = 2
#      ram           = 1
#      core_fraction = 5
#    },
#    {
#      vm_name       = "replica"
#      cpu           = 2
#      ram           = 2
#      core_fraction = 5
#    }
#  ]


  ###Metadata
  credential = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file("~/.ssh/yc.pub")}"
  }
}