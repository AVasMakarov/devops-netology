# Домашнее задание к занятию 14 «Средство визуализации Grafana»

## Задание повышенной сложности

**При решении задания 1** не используйте директорию [help](./help) для сборки проекта. Самостоятельно разверните grafana, где в роли источника данных будет выступать prometheus, а сборщиком данных будет node-exporter:

- grafana;
- prometheus-server;
- prometheus node-exporter.

За дополнительными материалами можете обратиться в официальную документацию grafana и prometheus.

В решении к домашнему заданию также приведите все конфигурации, скрипты, манифесты, которые вы
использовали в процессе решения задания.

**При решении задания 3** вы должны самостоятельно завести удобный для вас канал нотификации, например, Telegram или email, и отправить туда тестовые события.

В решении приведите скриншоты тестовых событий из каналов нотификаций.

## Обязательные задания

### Задание 1

1. Используя директорию [help](./help) внутри этого домашнего задания, запустите связку prometheus-grafana.
1. Зайдите в веб-интерфейс grafana, используя авторизационные данные, указанные в манифесте docker-compose.
1. Подключите поднятый вами prometheus, как источник данных.
1. Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource.

> Использовал готовую сборку с `github` `stefanprodan/dockprom` и донастраивал ее под себя. Так же добавил `cAdvisor` для мониторинга контейнеров.

```bash
VERSION=v0.47.0

docker run \
--volume=/:/rootfs:ro \
--volume=/var/run:/var/run:ro \
--volume=/sys:/sys:ro \
--volume=/var/lib/docker/:/var/lib/docker:ro \
--volume=/dev/disk/:/dev/disk:ro \
--publish=8080:8080 \
--detach=true \
--name=cadvisor \
--privileged \
--device=/dev/kmsg \
--restart=unless-stopped \
gcr.io/cadvisor/cadvisor:$VERSION
```

```docker-compose.yml
version: '2.1'

networks:
  monitor-net:
    driver: bridge

volumes:
    prometheus_data: {}
    grafana_data: {}

services:

  minio:
     image: minio/minio:latest
     expose:
       - 9000
       - 9001
     networks:
       - monitor-net
     command: server ~ --address ':9000' --console-address ':9001'

  createbuckets:
     image: minio/mc
     networks:
       - monitor-net
     depends_on:
       - minio
     entrypoint: >
       /bin/sh -c "
       /usr/bin/mc config host add myminio http://minio:9000 minioadmin minioadmin;
       /usr/bin/mc rm -r --force myminio/loki;
       /usr/bin/mc mb myminio/loki;
       /usr/bin/mc policy set public myminio/loki;
       exit 0;
       "
 
  loki:
    image: grafana/loki:2.7.4
    container_name: loki 
    volumes:
      - ./loki:/etc/loki
    command: -config.file=/etc/loki/local-config.yml
    restart: unless-stopped
    expose:
      - 3100
    networks:
      - monitor-net

  promtail:
    image: grafana/promtail:2.7.4
    container_name: promtail
    volumes:
      - /var/log:/var/log
      - ./promtail:/etc/promtail
    command: -config.file=/etc/promtail/config.yml
    restart: unless-stopped
    networks:
      - monitor-net

  prometheus:
    image: prom/prometheus:v2.42.0
    container_name: prometheus
    volumes:
      - ./prometheus:/etc/prometheus
      - prometheus_data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=200h'
      - '--web.enable-lifecycle'
    restart: unless-stopped
    expose:
      - 9090
    networks:
      - monitor-net
    labels:
      org.label-schema.group: "monitoring"

  alertmanager:
    image: prom/alertmanager:v0.25.0
    container_name: alertmanager
    volumes:
      - ./alertmanager:/etc/alertmanager
    command:
      - '--config.file=/etc/alertmanager/config.yml'
      - '--storage.path=/alertmanager'
    restart: unless-stopped
    expose:
      - 9093
    networks:
      - monitor-net
    labels:
      org.label-schema.group: "monitoring"

  nodeexporter:
    image: prom/node-exporter:v1.5.0
    container_name: nodeexporter
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro
    command:
      - '--path.procfs=/host/proc'
      - '--path.rootfs=/rootfs'
      - '--path.sysfs=/host/sys'
      - '--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($$|/)'
    restart: unless-stopped
    expose:
      - 9100
    networks:
      - monitor-net
    labels:
      org.label-schema.group: "monitoring"

  cadvisor:
    image: gcr.io/cadvisor/cadvisor:v0.47.1
    container_name: cadvisor
    privileged: true
    devices:
      - /dev/kmsg:/dev/kmsg
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker:/var/lib/docker:ro
      #- /cgroup:/cgroup:ro #doesn't work on MacOS only for Linux
    restart: unless-stopped
    expose:
      - 8080
    networks:
      - monitor-net
    labels:
      org.label-schema.group: "monitoring"

  grafana:
    image: grafana/grafana:9.4.1
    container_name: grafana
    volumes:
      - grafana_data:/var/lib/grafana
      - ./grafana/provisioning/dashboards:/etc/grafana/provisioning/dashboards
      - ./grafana/provisioning/datasources:/etc/grafana/provisioning/datasources
    environment:
      - GF_SECURITY_ADMIN_USER=${ADMIN_USER:-admin}
      - GF_SECURITY_ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}
      - GF_USERS_ALLOW_SIGN_UP=false
    restart: unless-stopped
    expose:
      - 3000
    networks:
      - monitor-net
    labels:
      org.label-schema.group: "monitoring"

  pushgateway:
    image: prom/pushgateway:v1.5.1
    container_name: pushgateway
    restart: unless-stopped
    expose:
      - 9091
    networks:
      - monitor-net
    labels:
      org.label-schema.group: "monitoring"

  caddy:
    image: caddy:2.6.4
    container_name: caddy
    ports:
      - "3000:3000"
      - "8080:8080"
      - "9090:9090"
      - "9093:9093"
      - "9091:9091"
      - "3100:3100"
      - "9000:9000"
      - "9001:9001"
    volumes:
      - ./caddy:/etc/caddy
    environment:
      - ADMIN_USER=${ADMIN_USER:-admin}
      - ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}
      - ADMIN_PASSWORD_HASH=${ADMIN_PASSWORD_HASH:-$2a$14$1l.IozJx7xQRVmlkEQ32OeEEfP5mRxTpbDTCTcXRqn19gXD8YK1pO}
    restart: unless-stopped
    networks:
      - monitor-net
    labels:
      org.label-schema.group: "monitoring"
```


 ![1]()

## Задание 2

Изучите самостоятельно ресурсы:

1. [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085).
1. [Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage).
1. [Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/).

Создайте Dashboard и в ней создайте Panels:

- утилизация CPU для nodeexporter (в процентах, 100-idle);
> sum(rate(node_cpu_seconds_total{instance="nodeexporter:9100"}[1m]))
- CPULA 1/5/15;
> avg(node_load1{instance="nodeexporter:9100"}) /  count(count(node_cpu_seconds_total{instance="nodeexporter:9100"}) by (cpu))
> avg(node_load5{nstance="nodeexporter:9100"}) /  count(count(node_cpu_seconds_total{instance="nodeexporter:9100"}) by (cpu))
> avg(node_load15{instance="nodeexporter:9100"}) /  count(count(node_cpu_seconds_total{instance="nodeexporter:9100"}) by (cpu))
- количество свободной оперативной памяти;
> node_memory_MemAvailable_bytes{instance=~"nodeexporter:9100"}
- количество места на файловой системе.
> sum(node_filesystem_free_bytes{fstype="ext4", instance=~"nodeexporter:9100"})

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

 ![2]()

## Задание 3

1. Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».
1. В качестве решения задания приведите скриншот вашей итоговой Dashboard.

 ![3]()

## Задание 4

1. Сохраните ваш Dashboard.Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.
1. В качестве решения задания приведите листинг этого файла.

[Ссылка]() на `JSON Model`

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---