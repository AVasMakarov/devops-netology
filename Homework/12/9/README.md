# Домашнее задание к занятию «Управление доступом»

### Цель задания

В тестовой среде Kubernetes нужно предоставить ограниченный доступ пользователю.

------

### Чеклист готовности к домашнему заданию

1. Установлено k8s-решение, например MicroK8S.
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым github-репозиторием.

------

### Инструменты / дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) RBAC.
2. [Пользователи и авторизация RBAC в Kubernetes](https://habr.com/ru/company/flant/blog/470503/).
3. [RBAC with Kubernetes in Minikube](https://medium.com/@HoussemDellai/rbac-with-kubernetes-in-minikube-4deed658ea7b).

------

### Задание 1. Создайте конфигурацию для подключения пользователя

1. Создайте и подпишите SSL-сертификат для подключения к кластеру.

```bash
mav@mav-pc:~/work/devops-netology/Homework/12/9$ openssl genrsa -out user.key 2048
mav@mav-pc:~/work/devops-netology/Homework/12/9$ openssl req -new -key user.key -out user.csr -subj "/CN=user/O=opt"
mav@mav-pc:~/work/devops-netology/Homework/12/9$ openssl x509 -req -in user.csr -CA /var/snap/microk8s/current/certs/ca.crt -CAkey /var/snap/microk8s/current/certs/ca.key -CAcreateserial -out user.crt -days 365
Certificate request self-signature ok
subject=CN = user, O = opt
mav@mav-pc:~/work/devops-netology/Homework/12/9$ ls
README.md  user.crt  user.csr  user.key
mav@mav-pc:~/work/devops-netology/Homework/12/9$ cat user.crt 
-----BEGIN CERTIFICATE-----
MIICuzCCAaMCFDqgzbRvSpgWSPdu/WbNRHS+I3Q2MA0GCSqGSIb3DQEBCwUAMBcx
FTATBgNVBAMMDDEwLjE1Mi4xODMuMTAeFw0yNDA0MTEwNjU3NTBaFw0yNTA0MTEw
NjU3NTBaMB0xDTALBgNVBAMMBHVzZXIxDDAKBgNVBAoMA29wdDCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAK0cWBrgfTZthJEuoTtZrVHwoBuT/k6ES9JL
aEHhdaG23aNNhlyjjEaPZ/B8gs2H6jjCeJCNMdiHGy7s7JdOMyBz/VVwDdSNbM2B
4s2iWeWiL2KGT/yZlQp/wgPqqjS381VgxbexDH67+NmPDcLCGDDlIkxijdwVeyx+
wEDdK/KMvVDejHCxNXTcJ0tNVwxNhQRCezC4963GA21lMVWu63NRw+BbnsHpqEyC
7jOPAIiQy2dO8cmKy2XwwTdKrbxmnjckTos/FcEhJAwFsfh21ahRvkiN/wcE5t2i
fzjwiYa8SfBGcoC5JVxNwNCvLd82h7F5FqVwNoeuvZTZvAforwUCAwEAATANBgkq
hkiG9w0BAQsFAAOCAQEAVJjtQIJ4I8OcYi2zrw6um8AkTfIZXt4n4bBKGwUE54zV
b9L0q8+o/qDC5JArEBgQ3OaznzrNUUj56Mh53RtevZMQenjHN8oYUfgLpNhzYgcN
B5ZgST/gX8YnnWZ8Ic+0QczyIpiEWzszy2TKR3Pys99q8BaPmpYa+99QtyBHIUZZ
vmfRnrhRzp6kObofwjq7rapFGZurXkJluClRENt9NWTrb5eFiL63i7XUUo7zlCWH
vAu509lDhR+eYWZAoimpyj5ESrt1vUJxggH/Va2kl5Ay8mcpd/Uzb/17rv13heGC
lFk/Fs3kgieLFCP0eY+QsfpM7quZbCSSJ5WUYr/NqA==
-----END CERTIFICATE-----
```
2. Настройте конфигурационный файл kubectl для подключения.

```bash
mav@mav-pc:~/work/devops-netology/Homework/12/9$ kubectl config set-credentials user --client-certificate=user.crt --client-key=user.key --embed-certs=true
User "user" set.
mav@mav-pc:~/work/devops-netology/Homework/12/9$ kubectl config set-context --namespace=ls8 user --cluster=microk8s-cluster --user=user
Context "user" created.
```

3. Создайте роли и все необходимые настройки для пользователя.
4. Предусмотрите права пользователя. Пользователь может просматривать логи подов и их конфигурацию (`kubectl logs pod <pod_id>`, `kubectl describe pod <pod_id>`).
5. Предоставьте манифесты и скриншоты и/или вывод необходимых команд.

> Настройка `role` и `role-binding` в [манифесте]()  
>   
> ![1]()
------

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------
