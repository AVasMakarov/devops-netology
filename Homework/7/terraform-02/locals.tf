locals {
  name_web = "${var.vm_web_name}+${var.vm_web_image}+${var.vm_web_platform}"
  name_db = "${var.vm_db_name}+${var.vm_db_image}+${var.vm_db_platform}"
}