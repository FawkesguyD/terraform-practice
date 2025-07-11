# Settings
variable "service_account_key_file" {
    description = "Path to authorized service account key JSON"
    type        = string
}

variable "cloud_id" {
    description = "YC ID"
    type        = string
}

variable "folder_id" {
    description = "Yandex Folder ID"
    type        = string
}

variable "vms" {
  type = list(object({
    name          = string
    platform_id   = string
    zone          = string
    cores         = number
    memory        = number
    core_fraction = number
    image_id      = string 
    disk_type     = string
    disk_size     = number
    subnet_label  = string
    nat           = bool 
  }))
}

# SSH
variable "ssh_pubkey" {}
variable "ssh_user" {}

variable "subdomain_type" {
  default = "A"
}
variable "subdomain_ttl" {
  default = 600
}