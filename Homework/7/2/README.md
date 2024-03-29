# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

### Задание 0

1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav).
2. Запросите preview доступ к данному функционалу в ЛК Yandex Cloud. Обычно его выдают в течении 24-х часов.
   https://console.cloud.yandex.ru/folders/<ваш cloud_id>/vpc/security-groups.   
   Этот функционал понадобится к следующей лекции.


### Задание 1
В качестве ответа всегда полностью прикладываете ваш terraform-код в git!

1. Изучите проект. В файле variables.tf объявлены переменные для yandex provider.
2. Переименуйте файл personal.auto.tfvars_example в personal.auto.tfvars. Заполните переменные (идентификаторы облака, токен доступа). Благодаря .gitignore этот файл не попадет в публичный репозиторий. **Вы можете выбрать иной способ безопасно передать секретные данные в terraform.**
3. Сгенерируйте или используйте свой текущий ssh ключ. Запишите его открытую часть в переменную **vms_ssh_root_key**.
4. Инициализируйте проект, выполните код. Исправьте намеренное допущенные ошибки. Ответьте в чем заключается их суть?

> Ошибки заключались в наименовании платформы, допустимые названия `standard-v1, standard-v2, standard-v3`. И количество ядер должно быть четное, например, `2`

5. Ответьте, как в процессе обучения могут пригодиться параметры```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ? Ответ в документации Yandex cloud.

> scheduling_policy — политика планирования. Чтобы создать прерываемую ВМ, укажите preemptible = true (прерываемые ВМ дешевле)
> core_fraction=5 устанавливает минимальную производительность в 5%, что также снижает стоимость содержания ВМ

В качестве решения приложите:
- скриншот ЛК Yandex Cloud с созданной ВМ,
   ![1](https://github.com/AVasMakarov/devops-netology/blob/terraform-02/Screenshots/HW7_2/1.png?raw=true)
- скриншот успешного подключения к консоли ВМ через ssh,
   ![2](https://github.com/AVasMakarov/devops-netology/blob/terraform-02/Screenshots/HW7_2/2.png?raw=true)
- ответы на вопросы.


### Задание 2

1. Изучите файлы проекта.
2. Замените все "хардкод" **значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf.
3. Проверьте terraform plan (изменений быть не должно).

> [Ссылка](https://github.com/AVasMakarov/devops-netology/commit/67c46693d754f3ca701c611ad4c0047ca7331142) на commit c изменениями

### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ(в файле main.tf): **"netology-develop-platform-db"** ,  cores  = 2, memory = 2, core_fraction = 20. Объявите ее переменные с префиксом **vm_db_** в том же файле('vms_platform.tf').
3. Примените изменения.

> [Ссылка](https://github.com/AVasMakarov/devops-netology/commit/5f02810d1823c873a6adde7e67d707f1e3c7b2ae) на commit c изменениями

### Задание 4

1. Объявите в файле outputs.tf output типа map, содержащий { instance_name = external_ip } для каждой из ВМ.
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```

   ![3](https://github.com/AVasMakarov/devops-netology/blob/terraform-02/Screenshots/HW7_2/3.png?raw=true)

### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с несколькими переменными по примеру из лекции.
2. Замените переменные с именами ВМ из файла variables.tf на созданные вами local переменные.
3. Примените изменения.

   ![4](https://github.com/AVasMakarov/devops-netology/blob/terraform-02/Screenshots/HW7_2/4.png?raw=true)

### Задание 6

1. Вместо использования 3-х переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедените их в переменные типа **map** с именами "vm_web_resources" и "vm_db_resources". В качестве продвинутой практики попробуйте создать одну map переменную **vms_resources** и уже внутри нее конфиги обеих ВМ(вложенный map).
2. Так же поступите с блоком **metadata {serial-port-enable, ssh-keys}**, эта переменная должна быть общая для всех ваших ВМ.
3. Найдите и удалите все более не используемые переменные проекта.
4. Проверьте terraform plan (изменений быть не должно).

 ![5](https://github.com/AVasMakarov/devops-netology/blob/terraform-02/Screenshots/HW7_2/5.png?raw=true)

 ![Ссылка](https://github.com/AVasMakarov/devops-netology/tree/terraform-02/Homework/7/terraform-02) на репозиторий Terraform

------

## Дополнительные задания (со звездочкой*)

**Настоятельно рекомендуем выполнять все задания под звёздочкой.**   
Их выполнение поможет глубже разобраться в материале. Задания под звёздочкой дополнительные (необязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию.

### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания:

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list?

```hcl
> local.test_list[1]
"staging"
```

2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
```hcl
> length(local.test_list)
3
```
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map ?
```hcl
> local.test_map.admin
"John"
```
4. Напишите interpolation выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.
```hcl
> "${local.test_map.admin} is admin for ${local.test_list[2]} server based on OS ${local.servers.develop.image} with ${local.servers.production.cpu} cpu, ${local.servers.production.ram} ram and ${length(local.servers.production.disks)} virtual disks"
"John is admin for production server based on OS ubuntu-21-10 with 10 cpu, 40 ram and 4 virtual disks"
```
В качестве решения предоставьте необходимые команды и их вывод.

------
### Правила приема работы

В git-репозитории, в котором было выполнено задание к занятию "Введение в Terraform", создайте новую ветку terraform-02, закомитьте в эту ветку свой финальный код проекта. Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-02.

В качестве результата прикрепите ссылку на ветку terraform-02 в вашем репозитории.

**ВАЖНО! Удалите все созданные ресурсы**.


### Критерии оценки

Зачёт:

* выполнены все задания;
* ответы даны в развёрнутой форме;
* приложены соответствующие скриншоты и файлы проекта;
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку:

* задание выполнено частично или не выполнено вообще;
* в логике выполнения заданий есть противоречия и существенные недостатки. 