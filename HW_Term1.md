Домашнее задание к занятию "Работа в терминале. Лекция 1"

## Задание

1. С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant:

	* Создайте директорию, в которой будут храниться конфигурационные файлы Vagrant. В ней выполните `vagrant init`. Замените содержимое Vagrantfile по умолчанию следующим:

		```bash
		Vagrant.configure("2") do |config|
			config.vm.box = "bento/ubuntu-20.04"
		end
		```
    ![Создал ВМ]{https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW_Term1/1.JPG}
	* Выполнение в этой директории `vagrant up` установит провайдер VirtualBox для Vagrant, скачает необходимый образ и запустит виртуальную машину.

	* `vagrant suspend` выключит виртуальную машину с сохранением ее состояния (т.е., при следующем `vagrant up` будут запущены все процессы внутри, которые работали на момент вызова suspend), `vagrant halt` выключит виртуальную машину штатным образом.

2. Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?

3. Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: [документация](https://www.vagrantup.com/docs/providers/virtualbox/configuration.html). Как добавить оперативной памяти или ресурсов процессора виртуальной машине?
    - для добавления памяти и ЦПУ необходимо добавить строки в Vagrantfile 
    >config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 4
    end

4. Команда `vagrant ssh` из директории, в которой содержится Vagrantfile, позволит вам оказаться внутри виртуальной машины без каких-либо дополнительных настроек. Попрактикуйтесь в выполнении обсуждаемых команд в терминале Ubuntu.

5. Ознакомьтесь с разделами `man bash`, почитайте о настройках самого bash:
    * какой переменной можно задать длину журнала `history`, и на какой строчке manual это описывается?
   >history-size 1710 строка
    * что делает директива `ignoreboth` в bash?
   >игнорирует в запись истории команд, команды которые начинаются с пробела и повторяющуюся с последней командой
6. В каких сценариях использования применимы скобки `{}` и на какой строчке `man bash` это описано?
   >`{}` применимы для перечисления нескольких переменных для выполнения команды
   
   >746 строка
   > 
   >This construct is typically used as shorthand when the common prefix of the strings to be generated is longer than in the above example:

              mkdir /usr/local/src/bash/{old,new,dist,bugs}
       or
              chown root /usr/{ucb/{ex,edit},lib/{ex?.?*,how_ex}}
7. С учётом ответа на предыдущий вопрос, как создать однократным вызовом `touch` 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?
   >  touch file {1..100000}

   > root@vagrant:~/fortouch# touch file {1..300000}
     -bash: /usr/bin/touch: Argument list too long
8. В man bash поищите по `/\[\[`. Что делает конструкция `[[ -d /tmp ]]`
   > `[[ -d /tmp ]]` добавляет к команде `-d /tmp`
9. Сделайте так, чтобы в выводе команды `type -a bash` первым стояла запись с нестандартным путем, например bash is ...
Используйте знания о просмотре существующих и создании новых переменных окружения, обратите внимание на переменную окружения PATH

	```bash
	bash is /tmp/new_path_directory/bash
	bash is /usr/local/bin/bash
	bash is /bin/bash
	```

	(прочие строки могут отличаться содержимым и порядком)
    В качестве ответа приведите команды, которые позволили вам добиться указанного вывода или соответствующие скриншоты.
   > 38 type -a bash
     39  cd /usr/bin/
     40  ls
     41  cd bash
     42  nano bash
     43  cp bash /tmp/new_path_directory/
     44  cd /tmp/new_path_directory/
     45  ls
     46  type -a bash
     47  echo $PATH
     48  export PATH=/tmp/new_path_directory:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
     root@vagrant:/tmp/new_path_directory# type -a bash
     bash is /tmp/new_path_directory/bash
     bash is /usr/bin/bash
     bash is /bin/bash
     root@vagrant:/tmp/new_path_directory#
10. Чем отличается планирование команд с помощью `batch` и `at`?
   > batch планирует выполнение задачи исходя из ресурсов ПК, at планирует выполнение команды по времени

11. Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.
   > vagrant halt
