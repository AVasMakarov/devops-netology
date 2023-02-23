# Домашнее задание к занятию "Работа в терминале. Лекция 2"

## Задание

1. Какого типа команда `cd`? Попробуйте объяснить, почему она именно такого типа: опишите ход своих мыслей, если считаете, что она могла бы быть другого типа.
    > vagrant@vagrant:~$ type cd  
      cd is a shell builtin

    > Это внутренняя команда. Сделано с целью защиты от "дурака". На мой взгляд ее нельзя сделать внешней, 
      т.к. пришлось бы провести первоначальную настройку для ее использования.
2. Какая альтернатива без pipe команде `grep <some_string> <some_file> | wc -l`?   

	<details>
	<summary>Подсказка</summary>

	`man grep` поможет в ответе на этот вопрос. 

	</details>
	
	Ознакомьтесь с [документом](http://www.smallo.ruhr.de/award.html) о других подобных некорректных вариантах использования pipe.

    > grep -c systemd syslog

3. Какой процесс с PID `1` является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?

    > root@vagrant:/var/log# ps aux  
      USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND  
      root           1  0.0  1.1 168120 11352 ?        Ss   07:58   0:01 /sbin/init  

4. Как будет выглядеть команда, которая перенаправит вывод stderr `ls` на другую сессию терминала?

    > root@vagrant:/var/log# ls /etc > /dev/pts/1 2>&1  
      При выполнении данной команды проходит вывод в другой терминал

    > root@vagrant:/var/log# ls /etc > /dev/pts/1 > 2>&1  
      -bash: syntax error near unexpected token `2'  
      При таком варианте команды, как на лекции, выдает ошибку

    ![2](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW_Term2/2.JPG?raw=true)

5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.

    >root@vagrant:/var/log# ls < /etc > /dev/pts/1

    ![3](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW_Term2/3.JPG?raw=true)

6. Получится ли, находясь в графическом режиме, вывести данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?

    > Да, все будет работать при перенаправлении `/dev/tty1`
 
    ![4](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW_Term2/4.JPG?raw=true)

7. Выполните команду `bash 5>&1`. К чему она приведет? Что будет, если вы выполните `echo netology > /proc/$$/fd/5`? Почему так происходит?

    > `bash 5>&1` перенаправит вывод 5го файлового дескриптора в 1й файловый дескриптор. При выполнении `echo netology > /proc/$$/fd/5` результатом будет `netology` в shell.  
      Так происходит, потому что мы сначала перенаправили 5й в 1й, а затем перенаправили выполнение `echo` в 5й, соответственно из 5го он попал в 1й (Stdout)

8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty?  
	Напоминаем: по умолчанию через pipe передается только stdout команды слева от `|` на stdin команды справа.
Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.

    > При выполнении команды с перенаправлением `2>/dev/pts/1`, поток stderr уходит в другой терминал, а stdout остается в текущем.

9. Что выведет команда `cat /proc/$$/environ`? Как еще можно получить аналогичный по содержанию вывод?

   > vagrant@vagrant:$ cat /proc/$$/environ  
   > USER=vagrant LOGNAME=vagrant HOME=/home/vagrant PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin SHELL=/bin/bash TERM=xterm-256color XDG_SESSION_ID=6 XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus XDG_SESSION_TYPE=tty XDG_SESSION_CLASS=user MOTD_SHOWN=pam LANG=en_US.UTF-8 SSH_CLIENT=10.0.2.2 50763 22 SSH_CONNECTION=10.0.2.2 50763 10.0.2.15 22 SSH_TTY=/dev/pts/1  
     
    >vagrant@vagrant:$ env  
     SHELL=/bin/bash  
     PWD=/home/vagrant  
     LOGNAME=vagrant  
     XDG_SESSION_TYPE=tty  
     MOTD_SHOWN=pam  
     HOME=/home/vagrant  
     LANG=en_US.UTF-8  
     LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:  
     SSH_CONNECTION=10.0.2.2 50763 10.0.2.15 22  
     LESSCLOSE=/usr/bin/lesspipe %s %s  
     XDG_SESSION_CLASS=user  
     TERM=xterm-256color  
     LESSOPEN=| /usr/bin/lesspipe %s  
     USER=vagrant  
     SHLVL=1  
     XDG_SESSION_ID=6  
     XDG_RUNTIME_DIR=/run/user/1000  
     SSH_CLIENT=10.0.2.2 50763 22  
     XDG_DATA_DIRS=/usr/local/share:/usr/share:/var/lib/snapd/desktop  
     PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin  
     DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus  
     SSH_TTY=/dev/pts/1  
     _=/usr/bin/env  

10. Используя `man`, опишите что доступно по адресам `/proc/<PID>/cmdline`, `/proc/<PID>/exe`.

    > /proc/[pid]/cmdline  
              This read-only file holds the complete command line for the process, unless the process  is  a  zombie.
              In  the  latter case, there is nothing in this file: that is, a read on this file will return 0 characters. 
              The command-line arguments appear in this file as a set  of  strings  separated  by  null  bytes
              ('\0'), with a further null byte after the last string.
    > 
    >/proc/[pid]/exe  
              Under  Linux 2.2 and later, this file is a symbolic link containing the actual pathname of the executed
              command.  This symbolic link can be dereferenced normally; attempting to open it  will  open  the  exe‐
              cutable.   You  can  even type /proc/[pid]/exe to run another copy of the same executable that is being
              run by process [pid].  If the pathname has been unlinked, the symbolic link  will  contain  the  string
              '(deleted)'  appended  to the original pathname.  In a multithreaded process, the contents of this sym‐
              bolic link are not  available  if  the  main  thread  has  already  terminated  (typically  by  calling
              pthread_exit(3)). 

11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью `/proc/cpuinfo`.

    > Процессор поддерживает SSE первой версии

    > root@vagrant:~# cat /proc/cpuinfo  
      processor       : 0  
      vendor_id       : GenuineIntel  
      cpu family      : 6  
      model           : 142  
      model name      : Intel(R) Core(TM) i5-10210U CPU @ 1.60GHz  
      stepping        : 12  
      cpu MHz         : 2112.002  
      cache size      : 6144 KB  
      physical id     : 0  
      siblings        : 2  
      core id         : 0  
      cpu cores       : 2  
      apicid          : 0  
      initial apicid  : 0  
      fpu             : yes  
      fpu_exception   : yes  
      cpuid level     : 22  
      wp              : yes  
      flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single fsgsbase bmi1 avx2 bmi2 invpcid rdseed clflushopt md_clear flush_l1d arch_capabilities  
      bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs itlb_multihit srbds mmio_stale_data retbleed  
      bogomips        : 4224.00  
      clflush size    : 64  
      cache_alignment : 64  
      address sizes   : 39 bits physical, 48 bits virtual  

12. При открытии нового окна терминала и `vagrant ssh` создается новая сессия и выделяется pty.  
	Это можно подтвердить командой `tty`, которая упоминалась в лекции 3.2.  
	Однако:

    ```bash
	vagrant@netology1:~$ ssh localhost 'tty'
	not a tty
    ```

	Почитайте, почему так происходит, и как изменить поведение.

    > TTY не подходит для удаленного подключения. В команду добавляем `-t` и тогда будет работать.  
      PS C:\VM\Vagrant> ssh -p 2222 -i C:\VM\Vagrant\.vagrant\machines\default\virtualbox\private_key vagrant@localhost 'tty'  
      not a tty  
      PS C:\VM\Vagrant> ssh -t -p 2222 -i C:\VM\Vagrant\.vagrant\machines\default\virtualbox\private_key vagrant@localhost 'tty'  
      /dev/pts/2  

13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись `reptyr`. Например, так можно перенести в `screen` процесс, который вы запустили по ошибке в обычной SSH-сессии.

    > Открыл файл в `vi` в одном терминале, остановил процесс (Ctrl+Z), посмотрел PID и открыл его в другом терминале с помощью `reptyr`

    ![1](https://github.com/AVasMakarov/devops-netology/blob/main/Screenshots/HW_Term2/1.JPG?raw=true)

14. `sudo echo string > /root/new_file` не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без `sudo` под вашим пользователем. Для решения данной проблемы можно использовать конструкцию `echo string | sudo tee /root/new_file`. Узнайте, что делает команда `tee` и почему в отличие от `sudo echo` команда с `sudo tee` будет работать.

    > Вариант с `tee` сработает, потому что команда запускается с привелегиями и она будет перезаписывать файл, а в первом случае это выполняет `shell` без привилегий