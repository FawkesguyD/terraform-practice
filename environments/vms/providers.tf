terraform {
  required_providers {
    yandex = { source = "yandex-cloud/yandex" }
    twc    = { source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud" }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = "ru-central1-a"
}

# TIMEWEB (domain)
provider "twc" {
  token = var.twc_token_auth
}