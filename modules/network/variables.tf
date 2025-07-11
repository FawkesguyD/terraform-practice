variable "folder_id" {
    description = "Yandex Folder ID"
    type        = string
}

variable "network_name" {
    default     = "net-default"
}

variable "network_description" {
    default     = "default network"
}

variable "subnet_zone" {
    default = "ru-central1-a"
}

variable "subnets" {
    type = list(object({
        name           = string
        v4_cidr_blocks = list(string)
    }))
    default = [ {
        name           = "default-subnet"
        v4_cidr_blocks = ["172.16.10.0/24"]
    }]
}


#DNS

variable "dns_name" {
    default = "default-dns"
}

variable "dns_description" {
    default = "default dns zone-1"
}

variable "dns_zone" {
    default = "example.com."
}