#resource "yandex_vpc_network" "develop" {
#  name = var.vpc_name
#}
#resource "yandex_vpc_subnet" "develop" {
#  name           = var.vpc_name
#  zone           = var.default_zone
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = var.default_cidr
#}


#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key = file("~/.ssh/yc.pub")
  }
}
module "vm_netwok" {
  source       = "./.terraform/modules/vpc"
  env_name     = "develop"
  vm_zone         = "ru-central1-a"
  vm_cidr         = ["10.0.1.0/24"]
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vm_netwok.network_id
  subnet_zones    = [ module.vm_netwok.ya_zone ]
  subnet_ids      = [ module.vm_netwok.subnet_id ]
  instance_name   = "web"
  instance_count  = 2
  image_family    = "ubuntu-2004-lts"
  public_ip       = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}
