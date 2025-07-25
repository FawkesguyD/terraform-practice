variable "vms" {
  type = list(object({
    name                      = string
    platform_id               = string
    zone                      = string
    cores                     = number
    memory                    = number
    core_fraction             = number
    image_id                  = string 
    disk_type                 = string
    disk_size                 = number
    subnet_label              = string
    subnet_id                 = string
    nat                       = bool 
    ip_address                = string
    allow_stopping_for_update = bool
  }))
}

variable "security_group_ids" {
  type = list(string)
}

variable "ssh_pubkey" {
  type = string
}

variable "ssh_user" {
  type = string
}


variable "dns_zone_id" {
  type = string
}

variable "subdomain_type" {
  type    = string
}

variable "subdomain_ttl" {
  type    = number
}