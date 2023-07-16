resource "local_file" "hosts_cfg" {
  content = templatefile("${abspath(path.module)}/inventory/hosts.tftpl",
    {storage = yandex_compute_instance.vm_4_each}
  )
  filename = "${abspath(path.module)}/inventory/hosts.cfg"
}


resource "null_resource" "web_hosts_provision" {
  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.count]

  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "cat ~/.ssh/yc | ssh-add -"
  }

  #Костыль!!! Даем ВМ время на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
  provisioner "local-exec" {
    command = "sleep 30"
  }

  #Запуск ansible-playbook
  provisioner "local-exec" {
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/inventory/hosts.cfg ${abspath(path.module)}/inventory/nginx.yml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
  triggers = {
    always_run         = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
    playbook_src_hash  = file("${abspath(path.module)}/inventory/nginx.yml") # при изменении содержимого playbook файла
    ssh_public_key     = "${file("~/.ssh/yc.pub")}" # при изменении переменной
  }

}