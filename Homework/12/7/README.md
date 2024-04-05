# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Цель задания

В тестовой среде Kubernetes нужно создать PV и продемострировать запись и хранение файлов.

------

### Чеклист готовности к домашнему заданию

1. Установленное K8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным GitHub-репозиторием.

------

### Дополнительные материалы для выполнения задания

1. [Инструкция по установке NFS в MicroK8S](https://microk8s.io/docs/nfs).
2. [Описание Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).
3. [Описание динамического провижининга](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/).
4. [Описание Multitool](https://github.com/wbitt/Network-MultiTool).

------

### Задание 1

**Что нужно сделать**

Создать Deployment приложения, использующего локальный PV, созданный вручную.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.

> Сделал [манифест](https://github.com/AVasMakarov/devops-netology/blob/main/Homework/12/7/k8s_deployment.yml)

2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.

> Сделал манифесты [PV](https://github.com/AVasMakarov/devops-netology/blob/main/Homework/12/7/k8s_pv.yml) и [PVC](https://github.com/AVasMakarov/devops-netology/blob/main/Homework/12/7/k8s_pvc.yml)
> После bound'инга  
> ![1](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW12_7/1.png?raw=true)

3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории.

![2](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW12_7/2.png?raw=true)

4. Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему.

> PV остался, так как это отдельная сущность кластера, не зависящая от Deployment и PVC
> ![3](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW12_7/3.png?raw=true)

5. Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV.  Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему.

> До удаления PV  
> ![4](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW12_7/4.png?raw=true)
> 
> После удаления PV  
> ![5](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW12_7/5.png?raw=true)  
> 
> После удаления PV файл остался, т.к. указана политика `persistentVolumeReclaimPolicy: Retain`

5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

------

### Задание 2

**Что нужно сделать**

Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

1. Включить и настроить NFS-сервер на MicroK8S.
2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.

> Сделал манифест [Deployment](https://github.com/AVasMakarov/devops-netology/blob/main/Homework/12/7/k8s_nfs-deployment.yml) и [PVC](https://github.com/AVasMakarov/devops-netology/blob/main/Homework/12/7/k8s_nfs-pvc.yml)
> ![6](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW12_7/6.png?raw=true)

3. Продемонстрировать возможность чтения и записи файла изнутри пода.

> ![7](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW12_7/7.png?raw=true)

4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

------

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.