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

# Network
variable "network_name" {}
variable "network_description" {}

variable "subnets" {
    type = list(object({
        name           = string
        v4_cidr_blocks = list(string) 
    }))
}

#DNS

variable "dns_name" {}
variable "dns_description" {}
variable "dns_zone" {}







