# Домашнее задание к занятию 12 «GitLab»

## Подготовка к выполнению


1. Или подготовьте к работе Managed GitLab от yandex cloud [по инструкции](https://cloud.yandex.ru/docs/managed-gitlab/operations/instance/instance-create) .
   Или создайте виртуальную машину из публичного образа [по инструкции](https://cloud.yandex.ru/marketplace/products/yc/gitlab ) .
2. Создайте виртуальную машину и установите на нее gitlab runner, подключите к вашему серверу gitlab  [по инструкции](https://docs.gitlab.com/runner/install/linux-repository.html) .

3. (* Необязательное задание повышенной сложности. )  Если вы уже знакомы с k8s попробуйте выполнить задание, запустив gitlab server и gitlab runner в k8s  [по инструкции](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/gitlab-containers).

4. Создайте свой новый проект.
5. Создайте новый репозиторий в GitLab, наполните его [файлами](./repository).
6. Проект должен быть публичным, остальные настройки по желанию.

## Основная часть

### DevOps

В репозитории содержится код проекта на Python. Проект — RESTful API сервис. Ваша задача — автоматизировать сборку образа с выполнением python-скрипта:

1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated).
2. Python версии не ниже 3.7.
3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`.
4. Создана директория `/python_api`.
5. Скрипт из репозитория размещён в /python_api.
6. Точка вызова: запуск скрипта.
7. При комите в любую ветку должен собираться docker image с форматом имени hello:gitlab-$CI_COMMIT_SHORT_SHA . Образ должен быть выложен в Gitlab registry или yandex registry.

> [Ссылка](https://gitlab.com/makarovdevops/devops-netology/container_registry) на Contaner Registry c собранным образом

### Product Owner

Вашему проекту нужна бизнесовая доработка: нужно поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:

1. Какой метод необходимо исправить.
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`.
3. Issue поставить label: feature.

 ![1](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW9_5/1.png?raw=true)

### Developer

Пришёл новый Issue на доработку, вам нужно:

1. Создать отдельную ветку, связанную с этим Issue.
2. Внести изменения по тексту из задания. 
3. Подготовить Merge Request, влить необходимые изменения в `master`, проверить, что сборка прошла успешно.
 
 ![2](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW9_5/2.png?raw=true)

### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:

1. Поднять докер-контейнер с образом `hello:gitlab-$CI_COMMIT_SHORT_SHA` и проверить возврат метода на корректность.
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый.

 ![3](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW9_5/3.png?raw=true)

## Итог

В качестве ответа пришлите подробные скриншоты по каждому пункту задания:

- файл [gitlab-ci.yml;](https://gitlab.com/makarovdevops/devops-netology/-/blob/main/.gitlab-ci.yml)
- [Dockerfile;](https://gitlab.com/makarovdevops/devops-netology/-/blob/main/Dockerfile)
- лог успешного выполнения пайплайна;
```bash
Running with gitlab-runner 16.3.0~beta.108.g2b6048b4 (2b6048b4)
  on green-2.saas-linux-small-amd64.runners-manager.gitlab.com/default ns46NMmJ, system ID: s_85d7af184313
  feature flags: FF_USE_IMPROVED_URL_MASKING:true, FF_RESOLVE_FULL_TLS_CHAIN:false
Preparing the "docker+machine" executor
00:29
Using Docker executor with image docker:24.0.5 ...
Starting service docker:24.0.5-dind ...
Pulling docker image docker:24.0.5-dind ...
Using docker image sha256:7015f2c475d511a251955877c2862016a4042512ba625ed905e69202f87e1a21 for docker:24.0.5-dind with digest docker@sha256:3c6e4dca7a63c9a32a4e00da40461ce067f255987ccc9721cf18ffa087bcd1ef ...
WARNING: Service docker:24.0.5-dind is already created. Ignoring.
Waiting for services to be up and running (timeout 30 seconds)...
Pulling docker image docker:24.0.5 ...
Using docker image sha256:7015f2c475d511a251955877c2862016a4042512ba625ed905e69202f87e1a21 for docker:24.0.5 with digest docker@sha256:3c6e4dca7a63c9a32a4e00da40461ce067f255987ccc9721cf18ffa087bcd1ef ...
Preparing environment
00:01
Running on runner-ns46nmmj-project-51875263-concurrent-0 via runner-ns46nmmj-s-l-s-amd64-1699089051-e90e45cb...
Getting source from Git repository
00:01
Fetching changes with git depth set to 20...
Initialized empty Git repository in /builds/makarovdevops/devops-netology/.git/
Created fresh repository.
Checking out 2a7ee790 as detached HEAD (ref is main)...
Skipping Git submodules setup
$ git remote set-url origin "${CI_REPOSITORY_URL}"
Executing "step_script" stage of the job script
00:50
Using docker image sha256:7015f2c475d511a251955877c2862016a4042512ba625ed905e69202f87e1a21 for docker:24.0.5 with digest docker@sha256:3c6e4dca7a63c9a32a4e00da40461ce067f255987ccc9721cf18ffa087bcd1ef ...
$ docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
Login Succeeded
$ docker build -t $CI_REGISTRY/$CI_PROJECT_PATH/hello:gitlab-$CI_COMMIT_SHORT_SHA .
#0 building with "default" instance using docker driver
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 247B done
#1 DONE 0.0s
#2 [internal] load .dockerignore
#2 transferring context: 2B done
#2 DONE 0.0s
#3 [internal] load metadata for docker.io/library/centos:7
#3 DONE 0.6s
#4 [internal] load build context
#4 transferring context: 562B done
#4 DONE 0.0s
#5 [1/5] FROM docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4
#5 resolve docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4 0.0s done
#5 sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 0B / 76.10MB 0.1s
#5 sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4 1.20kB / 1.20kB done
#5 sha256:dead07b4d8ed7e29e98de0f4504d87e8880d4347859d839686a31da35a3b532f 529B / 529B done
#5 sha256:eeb6ee3f44bd0b5103bb561b4c16bcb82328cfe5809ab675bb17ab3a16c517c9 2.75kB / 2.75kB done
#5 sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 14.68MB / 76.10MB 0.2s
#5 sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 26.21MB / 76.10MB 0.3s
#5 sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 50.33MB / 76.10MB 0.5s
#5 sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 65.01MB / 76.10MB 0.6s
#5 sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 76.10MB / 76.10MB 0.8s
#5 sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 76.10MB / 76.10MB 1.2s done
#5 extracting sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc
#5 extracting sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 3.3s done
#5 DONE 4.9s
#6 [2/5] RUN yum install python3 python3-pip -y
#6 0.280 Loaded plugins: fastestmirror, ovl
#6 0.433 Determining fastest mirrors
#6 3.958  * base: forksystems.mm.fcix.net
#6 3.959  * extras: us.mirrors.virtono.com
#6 3.960  * updates: coresite.mm.fcix.net
#6 10.69 Resolving Dependencies
#6 10.69 --> Running transaction check
#6 10.69 ---> Package python3.x86_64 0:3.6.8-19.el7_9 will be installed
#6 10.69 --> Processing Dependency: python3-libs(x86-64) = 3.6.8-19.el7_9 for package: python3-3.6.8-19.el7_9.x86_64
#6 10.82 --> Processing Dependency: python3-setuptools for package: python3-3.6.8-19.el7_9.x86_64
#6 10.82 --> Processing Dependency: libpython3.6m.so.1.0()(64bit) for package: python3-3.6.8-19.el7_9.x86_64
#6 10.82 ---> Package python3-pip.noarch 0:9.0.3-8.el7 will be installed
#6 10.83 --> Running transaction check
#6 10.83 ---> Package python3-libs.x86_64 0:3.6.8-19.el7_9 will be installed
#6 10.84 --> Processing Dependency: libtirpc.so.1()(64bit) for package: python3-libs-3.6.8-19.el7_9.x86_64
#6 10.84 ---> Package python3-setuptools.noarch 0:39.2.0-10.el7 will be installed
#6 10.84 --> Running transaction check
#6 10.84 ---> Package libtirpc.x86_64 0:0.2.4-0.16.el7 will be installed
#6 10.91 --> Finished Dependency Resolution
#6 10.92 
#6 10.92 Dependencies Resolved
#6 10.92 
#6 10.92 ================================================================================
#6 10.92  Package                  Arch         Version              Repository     Size
#6 10.92 ================================================================================
#6 10.92 Installing:
#6 10.92  python3                  x86_64       3.6.8-19.el7_9       updates        70 k
#6 10.92  python3-pip              noarch       9.0.3-8.el7          base          1.6 M
#6 10.92 Installing for dependencies:
#6 10.92  libtirpc                 x86_64       0.2.4-0.16.el7       base           89 k
#6 10.92  python3-libs             x86_64       3.6.8-19.el7_9       updates       6.9 M
#6 10.92  python3-setuptools       noarch       39.2.0-10.el7        base          629 k
#6 10.92 
#6 10.92 Transaction Summary
#6 10.92 ================================================================================
#6 10.92 Install  2 Packages (+3 Dependent packages)
#6 10.92 
#6 10.92 Total download size: 9.3 M
#6 10.92 Installed size: 48 M
#6 10.92 Downloading packages:
#6 11.06 warning: /var/cache/yum/x86_64/7/updates/packages/python3-3.6.8-19.el7_9.x86_64.rpm: Header V4 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
#6 11.06 Public key for python3-3.6.8-19.el7_9.x86_64.rpm is not installed
#6 11.14 Public key for libtirpc-0.2.4-0.16.el7.x86_64.rpm is not installed
#6 11.41 --------------------------------------------------------------------------------
#6 11.41 Total                                               19 MB/s | 9.3 MB  00:00     
#6 11.41 Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
#6 11.41 Importing GPG key 0xF4A80EB5:
#6 11.41  Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
#6 11.41  Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
#6 11.41  Package    : centos-release-7-9.2009.0.el7.centos.x86_64 (@CentOS)
#6 11.41  From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
#6 11.43 Running transaction check
#6 11.45 Running transaction test
#6 11.47 Transaction test succeeded
#6 11.48 Running transaction
#6 11.54   Installing : libtirpc-0.2.4-0.16.el7.x86_64                               1/5 
#6 11.81   Installing : python3-setuptools-39.2.0-10.el7.noarch                      2/5 
#6 12.10   Installing : python3-pip-9.0.3-8.el7.noarch                               3/5 
#6 12.13   Installing : python3-3.6.8-19.el7_9.x86_64                                4/5 
#6 13.16   Installing : python3-libs-3.6.8-19.el7_9.x86_64                           5/5 
#6 13.21   Verifying  : libtirpc-0.2.4-0.16.el7.x86_64                               1/5 
#6 13.23   Verifying  : python3-libs-3.6.8-19.el7_9.x86_64                           2/5 
#6 13.24   Verifying  : python3-3.6.8-19.el7_9.x86_64                                3/5 
#6 13.25   Verifying  : python3-setuptools-39.2.0-10.el7.noarch                      4/5 
#6 13.26   Verifying  : python3-pip-9.0.3-8.el7.noarch                               5/5 
#6 13.30 
#6 13.30 Installed:
#6 13.30   python3.x86_64 0:3.6.8-19.el7_9        python3-pip.noarch 0:9.0.3-8.el7       
#6 13.30 
#6 13.30 Dependency Installed:
#6 13.30   libtirpc.x86_64 0:0.2.4-0.16.el7                                              
#6 13.30   python3-libs.x86_64 0:3.6.8-19.el7_9                                          
#6 13.30   python3-setuptools.noarch 0:39.2.0-10.el7                                     
#6 13.30 
#6 13.30 Complete!
#6 DONE 17.2s
#7 [3/5] COPY requirements.txt requirements.txt
#7 DONE 0.0s
#8 [4/5] RUN pip3 install -r requirements.txt
#8 0.473 WARNING: Running pip install with root privileges is generally not a good idea. Try `pip3 install --user` instead.
#8 0.515 Collecting flask (from -r requirements.txt (line 2))
#8 0.759   Downloading https://files.pythonhosted.org/packages/cd/77/59df23681f4fd19b7cbbb5e92484d46ad587554f5d490f33ef907e456132/Flask-2.0.3-py3-none-any.whl (95kB)
#8 0.851 Collecting flask_restful (from -r requirements.txt (line 3))
#8 0.968   Downloading https://files.pythonhosted.org/packages/d7/7b/f0b45f0df7d2978e5ae51804bb5939b7897b2ace24306009da0cc34d8d1f/Flask_RESTful-0.3.10-py2.py3-none-any.whl
#8 1.044 Collecting flask_jsonpify (from -r requirements.txt (line 4))
#8 1.137   Downloading https://files.pythonhosted.org/packages/60/0f/c389dea3988bffbe32c1a667989914b1cc0bce31b338c8da844d5e42b503/Flask-Jsonpify-1.5.0.tar.gz
#8 1.465 Collecting itsdangerous>=2.0 (from flask->-r requirements.txt (line 2))
#8 1.568   Downloading https://files.pythonhosted.org/packages/9c/96/26f935afba9cd6140216da5add223a0c465b99d0f112b68a4ca426441019/itsdangerous-2.0.1-py3-none-any.whl
#8 1.630 Collecting Jinja2>=3.0 (from flask->-r requirements.txt (line 2))
#8 1.747   Downloading https://files.pythonhosted.org/packages/20/9a/e5d9ec41927401e41aea8af6d16e78b5e612bca4699d417f646a9610a076/Jinja2-3.0.3-py3-none-any.whl (133kB)
#8 1.828 Collecting Werkzeug>=2.0 (from flask->-r requirements.txt (line 2))
#8 1.972   Downloading https://files.pythonhosted.org/packages/f4/f3/22afbdb20cc4654b10c98043414a14057cd27fdba9d4ae61cea596000ba2/Werkzeug-2.0.3-py3-none-any.whl (289kB)
#8 2.078 Collecting click>=7.1.2 (from flask->-r requirements.txt (line 2))
#8 2.201   Downloading https://files.pythonhosted.org/packages/4a/a8/0b2ced25639fb20cc1c9784de90a8c25f9504a7f18cd8b5397bd61696d7d/click-8.0.4-py3-none-any.whl (97kB)
#8 2.276 Collecting aniso8601>=0.82 (from flask_restful->-r requirements.txt (line 3))
#8 2.380   Downloading https://files.pythonhosted.org/packages/e3/04/e97c12dc034791d7b504860acfcdd2963fa21ae61eaca1c9d31245f812c3/aniso8601-9.0.1-py2.py3-none-any.whl (52kB)
#8 2.454 Collecting six>=1.3.0 (from flask_restful->-r requirements.txt (line 3))
#8 2.559   Downloading https://files.pythonhosted.org/packages/d9/5a/e7c31adbe875f2abbb91bd84cf2dc52d792b5a01506781dbcf25c91daf11/six-1.16.0-py2.py3-none-any.whl
#8 2.620 Collecting pytz (from flask_restful->-r requirements.txt (line 3))
#8 2.880   Downloading https://files.pythonhosted.org/packages/32/4d/aaf7eff5deb402fd9a24a1449a8119f00d74ae9c2efa79f8ef9994261fc2/pytz-2023.3.post1-py2.py3-none-any.whl (502kB)
#8 3.075 Collecting MarkupSafe>=2.0 (from Jinja2>=3.0->flask->-r requirements.txt (line 2))
#8 3.300   Downloading https://files.pythonhosted.org/packages/fc/d6/57f9a97e56447a1e340f8574836d3b636e2c14de304943836bd645fa9c7e/MarkupSafe-2.0.1-cp36-cp36m-manylinux1_x86_64.whl
#8 3.368 Collecting dataclasses; python_version < "3.7" (from Werkzeug>=2.0->flask->-r requirements.txt (line 2))
#8 3.464   Downloading https://files.pythonhosted.org/packages/fe/ca/75fac5856ab5cfa51bbbcefa250182e50441074fdc3f803f6e76451fab43/dataclasses-0.8-py3-none-any.whl
#8 3.526 Collecting importlib-metadata; python_version < "3.8" (from click>=7.1.2->flask->-r requirements.txt (line 2))
#8 3.711   Downloading https://files.pythonhosted.org/packages/a0/a1/b153a0a4caf7a7e3f15c2cd56c7702e2cf3d89b1b359d1f1c5e59d68f4ce/importlib_metadata-4.8.3-py3-none-any.whl
#8 3.799 Collecting typing-extensions>=3.6.4; python_version < "3.8" (from importlib-metadata; python_version < "3.8"->click>=7.1.2->flask->-r requirements.txt (line 2))
#8 3.909   Downloading https://files.pythonhosted.org/packages/45/6b/44f7f8f1e110027cf88956b59f2fad776cca7e1704396d043f89effd3a0e/typing_extensions-4.1.1-py3-none-any.whl
#8 3.972 Collecting zipp>=0.5 (from importlib-metadata; python_version < "3.8"->click>=7.1.2->flask->-r requirements.txt (line 2))
#8 4.101   Downloading https://files.pythonhosted.org/packages/bd/df/d4a4974a3e3957fd1c1fa3082366d7fff6e428ddb55f074bf64876f8e8ad/zipp-3.6.0-py3-none-any.whl
#8 4.149 Installing collected packages: itsdangerous, MarkupSafe, Jinja2, dataclasses, Werkzeug, typing-extensions, zipp, importlib-metadata, click, flask, aniso8601, six, pytz, flask-restful, flask-jsonpify
#8 4.721   Running setup.py install for flask-jsonpify: started
#8 4.981     Running setup.py install for flask-jsonpify: finished with status 'done'
#8 5.027 Successfully installed Jinja2-3.0.3 MarkupSafe-2.0.1 Werkzeug-2.0.3 aniso8601-9.0.1 click-8.0.4 dataclasses-0.8 flask-2.0.3 flask-jsonpify-1.5.0 flask-restful-0.3.10 importlib-metadata-4.8.3 itsdangerous-2.0.1 pytz-2023.3.post1 six-1.16.0 typing-extensions-4.1.1 zipp-3.6.0
#8 DONE 5.3s
#9 [5/5] COPY /python_api/python-api.py python-api.py
#9 DONE 0.0s
#10 exporting to image
#10 exporting layers
#10 exporting layers 1.7s done
#10 writing image sha256:2e4739d1e5aca277f1d950a48f3e09dc6cdef805e930a9a96cc0f00947ad73f7 done
#10 naming to registry.gitlab.com/makarovdevops/devops-netology/hello:gitlab-2a7ee790 done
#10 DONE 1.7s
WARNING: buildx: git was not found in the system. Current commit information was not captured by the build
$ docker push $CI_REGISTRY/$CI_PROJECT_PATH/hello:gitlab-$CI_COMMIT_SHORT_SHA
The push refers to repository [registry.gitlab.com/makarovdevops/devops-netology/hello]
d19030a8cfb8: Preparing
092f0876cfb7: Preparing
1bc9fe8b4839: Preparing
9238de432e78: Preparing
174f56854903: Preparing
1bc9fe8b4839: Pushed
d19030a8cfb8: Pushed
092f0876cfb7: Pushed
174f56854903: Pushed
9238de432e78: Pushed
gitlab-2a7ee790: digest: sha256:b59395efe70cea608ba9d8ef19ba4b3d328f0e3435c863e106f34d182e091184 size: 1366
Cleaning up project directory and file based variables
00:01
Job succeeded
```
- [решённый Issue.](https://gitlab.com/makarovdevops/devops-netology/-/issues/2)

### Важно
После выполнения задания выключите и удалите все задействованные ресурсы в Yandex Cloud.
