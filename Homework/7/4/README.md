# Домашнее задание к занятию "Продвинутые методы работы с Terraform"

### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote модуля.
2. Создайте 1 ВМ, используя данный модуль. В файле cloud-init.yml необходимо использовать переменную для ssh ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
   Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание что ssh-authorized-keys принимает в себя список, а не строку!
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```.

> [Ссылка](https://github.com/AVasMakarov/devops-netology/commit/d689b89c1b6e2935c543ed79b5373d5e74c6ea47) на коммит  

   ![1](https://github.com/AVasMakarov/devops-netology/blob/terraform-04/Screenshots/HW7_4/1.png?raw=true)

------

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля. например: ```ru-central1-a```.
2. Модуль должен возвращать значения vpc.id и subnet.id
3. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet, созданным модулем.
4. Сгенерируйте документацию к модулю с помощью terraform-docs.

> [Ссылка](https://github.com/AVasMakarov/devops-netology/commit/9b6bf1112eab50cb7e38d8466650248d13de54fb) на коммит

Пример вызова:
```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```

### Задание 3
1. Выведите список ресурсов в стейте.
> ![2](https://github.com/AVasMakarov/devops-netology/blob/terraform-04/Screenshots/HW7_4/2.png?raw=true)
2. Полностью удалите из стейта модуль vpc.
> ![3](https://github.com/AVasMakarov/devops-netology/blob/terraform-04/Screenshots/HW7_4/3.png?raw=true)
3. Полностью удалите из стейта модуль vm.
> ![4](https://github.com/AVasMakarov/devops-netology/blob/terraform-04/Screenshots/HW7_4/4.png?raw=true)
4. Импортируйте все обратно. Проверьте terraform plan - изменений быть не должно.
   Приложите список выполненных команд и скриншоты процессы.
> После импорта vpc и vm `terraform plan` выдал, что обновит данные. Как импортировать без этих изменений не нашёл. Можете подсказать как решить или где взять информацию? 
> ![5](https://github.com/AVasMakarov/devops-netology/blob/terraform-04/Screenshots/HW7_4/5.png?raw=true)
## Дополнительные задания (со звездочкой*)

**Настоятельно рекомендуем выполнять все задания под звёздочкой.**   Их выполнение поможет глубже разобраться в материале.   
Задания под звёздочкой дополнительные (необязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию.


### Задание 4*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.

Пример вызова:
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Предоставьте код, план выполнения, результат из консоли YC.

`vpc/variables.tf`
```hcl
`...`
variable "vm_zone" {
  type        = list(object({
    zone = string,
    cidr = string
  })
  )
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
`...`
```

`vpc/main.tf`
```hcl
`...`
resource "yandex_vpc_subnet" "develop" {
  name           = "${var.env_name}-${count.index}"
  network_id     = yandex_vpc_network.develop.id
  count = length(var.vm_zone)
  zone = var.vm_zone[count.index].zone
  v4_cidr_blocks = [var.vm_zone[count.index].cidr]
}
`...`
```

`main.tf`
```hcl
module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vm_netwok.network_id
  subnet_zones    = [ module.vm_netwok.ya_zone[0] ]
  subnet_ids      = [ module.vm_netwok.subnet_id[0] ]
  instance_name   = "web"
  instance_count  = 2
  image_family    = "ubuntu-2004-lts"
  public_ip       = true
```

`Результат выполнения`
```bash
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

Outputs:

sub_id = [
  "e9bmlunvg7fnhkj0stsk",
  "e2lkla2f1tmade8jhrt5",
  "b0ctav968fbucksf1285",
]
vm_ip = [
  "51.250.2.138",
  "158.160.63.8",
]
vpc_id = "enphd7iod7vuhehg2tq4"

```
### Задание 5***

1. Напишите модуль для создания кластера managed БД Mysql в Yandex Cloud с 1 или 3 хостами в зависимости от переменной HA=true или HA=false. Используйте ресурс yandex_mdb_mysql_cluster (передайте имя кластера и id сети).
2. Напишите модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Используйте ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user (передайте имя базы данных, имя пользователя и id кластера при вызове модуля).
3. Используя оба модуля, создайте кластер example из одного хоста, а затем добавьте в него БД test и пользователя app. Затем измените переменную и превратите сингл хост в кластер из 2х серверов.

Предоставьте план выполнения и по-возможности результат. Сразу же удаляйте созданные ресурсы, так как кластер может стоить очень дорого! Используйте минимальную конфигурацию.

### Задание 6*

1. Разверните у себя локально vault, используя docker-compose.yml в проекте.
2. Для входа в web интерфейс и авторизации terraform в vault используйте токен "education"
3. Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create  
   Path: example  
   secret data key: test
   secret data value: congrats!
4. Считайте данный секрет с помощью terraform и выведите его в output по примеру:
```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

можно обратится не к словарю, а конкретному ключу.
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```
5. Попробуйте самостоятельно разобраться в документации и записать новый секрет в vault с помощью terraform.


### Правила приема работы

В своём git-репозитории создайте новую ветку terraform-04, закомитьте в эту ветку свой финальный код проекта. Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-04.

В качестве результата прикрепите ссылку на ветку terraform-04 в вашем репозитории.

**ВАЖНО!** Удалите все созданные ресурсы.
