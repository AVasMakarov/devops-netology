import socket,time

list_service = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}
while 1 == 1 :
    for service in list_service:
        response_ip = socket.gethostbyname(service)
        if response_ip != list_service[service] :
            print(' [ERROR] ' + str(service) +' IP mistmatch: '+list_service[service]+' '+response_ip)
            list_service[service]=response_ip
        else :
            print(str(service) + ' ' + response_ip)
    time.sleep(10)


