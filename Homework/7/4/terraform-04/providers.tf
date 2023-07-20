terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "tfstate-devopsnetology"
    key    = "terraform.tfstate"
    region = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g9kv6bhc9t3hbsqh5s/etnrlcjebu6h4g8fo7mk"
    dynamodb_table = "tfstate-devopsnetologyydb"
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
#  zone      = var.default_zone
}