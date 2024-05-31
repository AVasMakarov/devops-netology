# Домашнее задание к занятию «Кластеры. Ресурсы под управлением облачных провайдеров»

### Цели задания

1. Организация кластера Kubernetes и кластера баз данных MySQL в отказоустойчивой архитектуре.
2. Размещение в private подсетях кластера БД, а в public — кластера Kubernetes.

---
## Задание 1. Yandex Cloud

1. Настроить с помощью Terraform кластер баз данных MySQL.

- Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость.
- Разместить ноды кластера MySQL в разных подсетях.
- Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.
- Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
- Задать время начала резервного копирования — 23:59.
- Включить защиту кластера от непреднамеренного удаления. 

> Защита устанавливается флагом `deletion_protection = true`. В ДЗ этот флаг стоит в `false` чтобы проще было удалять ресурсы в облаке

- Создать БД с именем `netology_db`, логином и паролем.

2. Настроить с помощью Terraform кластер Kubernetes.

- Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
- Создать отдельный сервис-аккаунт с необходимыми правами.
- Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.
- Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
- Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
- Подключиться к кластеру с помощью `kubectl`.
- *Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
- *Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.

### Ответ

Развертывание инфраструктуры Terraform'ом

```bash
Apply complete! Resources: 19 added, 0 changed, 0 destroyed.

Outputs:

k8s_id = "cat51tjghdqhgtebu7rn"
mysql_host = "rc1a-6ztnyqdnoymdi7lg.mdb.yandexcloud.net"
```

Получение конфигурации кластера из YC

```bash
mav@mav-pc:~/work/devops-netology/Homework/13/4/terraform$ yc managed-kubernetes cluster get-credentials cat51tjghdqhgtebu7rn --external --force

Context 'yc-my-k8s-regional' was added as default to kubeconfig '/home/mav/.kube/config'.
Check connection to cluster using 'kubectl cluster-info --kubeconfig /home/mav/.kube/config'.

Note, that authentication depends on 'yc' and its config profile 'default'.
To access clusters using the Kubernetes API, please use Kubernetes Service Account.
mav@mav-pc:~/work/devops-netology/Homework/13/4/terraform$ kubectl get node
NAME                        STATUS   ROLES    AGE   VERSION
cl1gjgaoc3unv9nkiopc-ajiv   Ready    <none>   26m   v1.28.2
cl1gjgaoc3unv9nkiopc-iguv   Ready    <none>   26m   v1.28.2
cl1gjgaoc3unv9nkiopc-ocit   Ready    <none>   26m   v1.28.2
```

Запуск микросервиса phpmyadmin

```bash
mav@mav-pc:~/work/devops-netology/Homework/13/4/terraform$ kubectl apply -f kuber/phpmyadmin.yml
namespace/phpmyadmin created
deployment.apps/phpmyadmin-deployment created
service/phpmyadmin-service created
mav@mav-pc:~/work/devops-netology/Homework/13/4/terraform$ kubectl get svc -A
NAMESPACE     NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)                  AGE
default       kubernetes           ClusterIP      10.96.128.1     <none>           443/TCP                  34m
kube-system   kube-dns             ClusterIP      10.96.128.2     <none>           53/UDP,53/TCP,9153/TCP   33m
kube-system   metrics-server       ClusterIP      10.96.137.206   <none>           443/TCP                  33m
phpmyadmin    phpmyadmin-service   LoadBalancer   10.96.250.229   158.160.171.51   80:31280/TCP             77s
```

 ![1]()
Полезные документы:

- [MySQL cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster).
- [Создание кластера Kubernetes](https://cloud.yandex.ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)
- [K8S Cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster).
- [K8S node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group).

--- 
## Задание 2*. Вариант с AWS (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

1. Настроить с помощью Terraform кластер EKS в три AZ региона, а также RDS на базе MySQL с поддержкой MultiAZ для репликации и создать два readreplica для работы.

- Создать кластер RDS на базе MySQL.
- Разместить в Private subnet и обеспечить доступ из public сети c помощью security group.
- Настроить backup в семь дней и MultiAZ для обеспечения отказоустойчивости.
- Настроить Read prelica в количестве двух штук на два AZ.

2. Создать кластер EKS на базе EC2.

- С помощью Terraform установить кластер EKS на трёх EC2-инстансах в VPC в public сети.
- Обеспечить доступ до БД RDS в private сети.
- С помощью kubectl установить и запустить контейнер с phpmyadmin (образ взять из docker hub) и проверить подключение к БД RDS.
- Подключить ELB (на выбор) к приложению, предоставить скрин.

Полезные документы:

- [Модуль EKS](https://learn.hashicorp.com/tutorials/terraform/eks).

### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.