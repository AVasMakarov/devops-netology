
# Домашнее задание к занятию «Микросервисы: принципы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- маршрутизация запросов к нужному сервису на основе конфигурации,
- возможность проверки аутентификационной информации в запросах,
- обеспечение терминации HTTPS.

Обоснуйте свой выбор.

| Решение            | Маршрутизация | Аутентификация | Терминация HTTPS | Бесплатно/Открыто?                                               |
|--------------------|---------------|----------------|------------------|------------------------------------------------------------------|
| Kong Gateway       | +             | +              | +                | Бесплатно, Apache 2.0                                            |
| Tyk.io             | +             | +              | +                | Бесплатно, MPL                                                   |
| HAProxy            | +             | +              | +                | Бесплатно                                                        |
| Yandex API Gateway | +             | +              | +                | Платно                                                           |
| Azure API Gateway  | +             | +              | +                | Платно                                                           |
| NGINX              | +             | +              | +                | Бесплатно                                                        |
| KrakenD            | +             | +              | +                | Двойное лицензирование, нужные функции частично в платной версии |

В целом можно использовать любой из предложенных вариантов. Если приложение разворачивается в облаке удобно использовать готовые API, 
но при разворачивании собственного API возможна более тонкая настройка. 
Также не стоит забывать про стоимость, за облачный API необходимо платить как за сервис, а при развертывании собственного необходимо платить за вычислительные мощности.

Для компании выбрал бы вариант с NGINX, т.к. возможна более тонкая настройка под конкретные задачи и возможен полный контроль за работой API.

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- поддержка кластеризации для обеспечения надёжности,
- хранение сообщений на диске в процессе доставки,
- высокая скорость работы,
- поддержка различных форматов сообщений,
- разделение прав доступа к различным потокам сообщений,
- простота эксплуатации.

Обоснуйте свой выбор.

| Характеристика \ Брокер                               | Kafka | Redis | RabbitMQ | ActiveMQ |
|-------------------------------------------------------|-------|-------|----------|----------|
| Поддержка кластеризации для обеспечения надежности    | +     | +     | +        | +        |
| Хранение сообщений на диске в процессе доставки       | +     | -     | +        | +        |
| Высокая скорость работы                               | +     | +     | +        | -        |
| Поддержка различных форматов сообщений                | +     | +     | +        | +        |
| Разделение прав доступа к различным потокам сообщений | +     | +     | +        | +        |
| Простота эксплуатации                                 | +     | +     | +        | +        |

Исходя из данных приведенных в таблице под наши задачи подходят 2 брокера: Kafka и RabbitMQ.
Kafka — высокопроизводительный брокер с отличной поддержкой кластеризации, созданная для длительного хранения больших объемов данных.
RabbitMQ — давно известный, популярный брокер со множеством функций и возможностей, поддерживающих сложную маршрутизацию.
Выбор зависит от специфических требований системы и компетенций команды.

