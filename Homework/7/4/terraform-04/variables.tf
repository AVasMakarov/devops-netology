###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

#variable "ip1" {
#  type = string
#  description = "ip адрес"
#  default = "192.168.0.1/32"
#  validation {
#    condition = can(cidrhost (var.ip1, 0))
#    error_message = "Неверно указан ip адрес в переменной ip1"
#  }
#}
#
#variable "ip11" {
#  type = string
#  description = "ip адрес"
#  default = "192.168.0.1"
#  validation {
#    condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",var.ip11))
#    error_message = "Неверно указан ip адрес в переменной ip11"
#  }
#}
#
#variable "ip2" {
#  type = string
#  description = "ip адрес"
#  default = "1920.1680.0.1/32"
#  validation {
#    condition = can(cidrhost (var.ip2, 0))
#    error_message = "Неверно указан ip адрес в переменной ip2"
#  }
#}
#
#variable "ip22" {
#  type = string
#  description = "ip адрес"
#  default = "1920.1680.0.1"
#  validation {
#    condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",var.ip22))
#    error_message = "Неверно указан ip адрес в переменной ip22"
#  }
#}
#
#variable "list_ip1" {
#  type = list(string)
#  description = "список ip адрес"
#  default = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
#  validation {
#    condition = alltrue([
#    for a in var.list_ip1 : can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",a))
#    ])
#    error_message = "Неверно указан ip адрес в переменной list_ip1"
#  }
#}
#
#variable "list_ip2" {
#  type = list(string)
#  description = "список ip адрес"
#  default = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]
#  validation {
#    condition = alltrue([
#    for a in var.list_ip2 : can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",a))
#    ])
#    error_message = "Неверно указан ip адрес в переменной list_ip2"
#  }
#}

#variable "example" {
#  type = string
#  description = "любая строка"
#  default = "asfA123"
#  validation {
#    condition = (length(regex("[a-z0-9]+", var.example)) == length(var.example))
#    error_message = "Есть заглавные буквы"
#  }
#}


variable "num" {
  type = number
}

variable "in_the_end_there_can_be_only_one" {
  description="Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
    Clint  = optional(bool)
  })

  default = {
    Dunkan = false
    Connor = false
    Clint  = true
  }

  validation {
    error_message = "There can be only one MacLeod"
    condition = sum([for i in var.in_the_end_there_can_be_only_one : (i == true ? 1 : 0) ]) == 1
  }
}
#(i == true ? (k + 1) : (k + 0))
#variable "default_cidr" {
#  type        = list(string)
#  default     = ["10.0.1.0/24"]
#  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
#}
#
#variable "vpc_name" {
#  type        = string
#  default     = "develop"
#  description = "VPC network&subnet name"
#}

###common vars

#variable "vms_ssh_root_key" {
#  type        = string
#  default     = "your_ssh_ed25519_key"
#  description = "ssh-keygen -t ed25519"
#}

###example vm_web var
#variable "vm_web_name" {
#  type        = string
#  default     = "netology-develop-platform-web"
#  description = "example vm_web_ prefix"
#}

###example vm_db var
#variable "vm_db_name" {
#  type        = string
#  default     = "netology-develop-platform-db"
#  description = "example vm_db_ prefix"
#}


