# Домашнее задание к занятию "Использование Terraform в команде"

### Задание 1

1. Возьмите код:
- из [ДЗ к лекции №04](https://github.com/netology-code/ter-homeworks/tree/main/04/src)
- из [демо к лекции №04](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1).
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
3. Перечислите какие **типы** ошибок обнаружены в проекте (без дублей).


#### Tflint
>Не указал версию провайдера
```hcl
Warning: Missing version constraint for provider "template" in `required_providers` (terraform_required_providers)

on main.tf line 13:
13: data "template_file" "cloudinit" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.4.0/docs/rules/terraform_required_providers.md  
```

>Рекомендуют не использовать ветку `main`, а прикреплять конкретную версию модуля
 ```hcl
Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

on main.tf line 39:
39:   source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.4.0/docs/rules/terraform_module_pinned_source.md
```

>Переменная объявлена, но не используется
```hcl
Warning: [Fixable] variable "default_zone" is declared but not used (terraform_unused_declarations)

on variables.tf line 17:
17: variable "default_zone" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.4.0/docs/rules/terraform_unused_declarations.md
```  
  
#### Checkov

>В `source` рекомендуют использовать хэш коммита для закрепления версии модуля
```hcl
terraform scan results:

Passed checks: 0, Failed checks: 1, Skipped checks: 0

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: test-vm
        File: /main.tf:38-54

                38 | module "test-vm" {
                39 |   source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                40 |   env_name        = "develop"
                41 |   network_id      = module.vm_netwok.network_id
                42 |   subnet_zones    = [ module.vm_netwok.ya_zone[0] ]
                43 |   subnet_ids      = [ module.vm_netwok.subnet_id[0] ]
                44 |   instance_name   = "web"
                45 |   instance_count  = 2
                46 |   image_family    = "ubuntu-2004-lts"
                47 |   public_ip       = true
                48 | 
                49 |   metadata = {
                50 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                51 |     serial-port-enable = 1
                52 |   }
                53 | 
                54 | }

```

------

### Задание 2

1. Возьмите ваш GitHub репозиторий с **выполненным ДЗ №4** в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'
2. Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте State проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.

    ![1](https://github.com/AVasMakarov/devops-netology/blob/terraform-05/Screenshots/HW7_5/1.png?raw=true)
    ![2](https://github.com/AVasMakarov/devops-netology/blob/terraform-05/Screenshots/HW7_5/2.png?raw=true)

3. Закомитьте в ветку 'terraform-05' все изменения.

```bash
mav@mav-pc:~/work/devops-netology/Homework/7/4/terraform-04$ git commit -am 'HW7_5 2 do'
[terraform-05 8f6060b] HW7_5 2 do
 3 files changed, 15 insertions(+), 1 deletion(-)
```

4. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
5. Пришлите ответ об ошибке доступа к State.
```hcl
mav@mav-pc:~/work/devops-netology/Homework/7/4/terraform-04$ terraform apply
Acquiring state lock. This may take a few moments...
╷
│ Error: Error acquiring the state lock
│
│ Error message: ConditionalCheckFailedException: Condition not satisfied
│ Lock Info:
│   ID:        e631b3cc-d501-848f-4d07-a75750ac8f0e
│   Path:      tfstate-devopsnetology/terraform.tfstate
│   Operation: OperationTypeInvalid
│   Who:       mav@mav-pc
│   Version:   1.5.3
│   Created:   2023-07-20 07:36:58.910107607 +0000 UTC
│   Info:
│
│
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.

```
6. Принудительно разблокируйте State. Пришлите команду и вывод.

```hcl
mav@mav-pc:~/work/devops-netology/Homework/7/4/terraform-04$ terraform apply -lock=false
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=5dc6a7189057f1fd930d66883978e02bfce7b33a7b97642153cb9b99f95a97d4]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vm_netwok.yandex_vpc_network.develop: Refreshing state... [id=enpr9q6cv73a769g2831]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 2s [id=fd85f37uh98ldl1omk30]
module.vm_netwok.yandex_vpc_subnet.develop[1]: Refreshing state... [id=e2l384bj19m72jad8r2g]
module.vm_netwok.yandex_vpc_subnet.develop[2]: Refreshing state... [id=b0ca1ib74rojdqlbf6te]
module.vm_netwok.yandex_vpc_subnet.develop[0]: Refreshing state... [id=e9bbeg3uadfa36a2o8mp]
module.test-vm.yandex_compute_instance.vm[0]: Refreshing state... [id=fhme8roso635v542idi3]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
...
```

------
### Задание 3

1. Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'.
2. Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте комит.
3. Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'.
4. Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
5. Пришлите ссылку на PR для ревью(вливать код в 'terraform-05' не нужно).

------
### Задание 4

1. Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console.

- type=string, description="ip-адрес", проверка что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты:  "192.168.0.1" и "1920.1680.0.1"
- type=list(string), description="список ip-адресов", проверка что все адреса верны.  Тесты:  ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]

## Дополнительные задания (со звездочкой*)

**Настоятельно рекомендуем выполнять все задания под звёздочкой.**   Их выполнение поможет глубже разобраться в материале.   
Задания под звёздочкой дополнительные (необязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию.
------
### Задание 5*
1. Напишите переменные с валидацией:
- type=string, description="любая строка", проверка что строка не содержит в себе символов верхнего регистра
- type=object, проверка что одно из значений равно true, а второе false, те не допускается false false и true true:
```
variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = false
    }

    validation {
        error_message = "There can be only one MacLeod"
        condition = <проверка>
    }
}
```
------
### Задание 6**

1. Настройте любую известную вам CI/CD систему. Если вы еще не знакомы с CI/CD  системами - настоятельно рекомендуем вернуться к данному заданию после изучения Jenkins/Teamcity/Gitlab.
2. Скачайте с ее помощью ваш репозиторий с кодом и инициализируйте инфраструктуру.
3. Уничтожтье инфраструктуру тем же способом.


### Правила приема работы

Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-05.

В качестве результата прикрепите ссылку на ветку terraform-05 в вашем репозитории.

**ВАЖНО!** Удалите все созданные ресурсы.
