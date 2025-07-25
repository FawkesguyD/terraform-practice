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


# NAT TABLES
variable "sec_group_name" {
    type    = string 
    default = "default-instance-sg"
}

variable "sec_group_discribe" {
    type    = string
    default = " default secutrity groups: allow ingress 22/tcp(ssh), 80/tcp(http), 443/tcp(https). Allow egress any"
}

 variable "sec_group_ingress" {
    type = list(object({
        protocol        = string
        description     = string
        v4_cidr_blocks  = list(string)
        from_port       = number
        to_port         = number
    }))
    default = [
    {
        description    = "ssh"
        from_port      = 22
        to_port        = 22
        protocol       = "TCP"
        v4_cidr_blocks = [ "0.0.0.0/0" ]
    },
    {
        description    = "ext-http"
        from_port      = 80
        to_port        = 80
        protocol       = "TCP"
        v4_cidr_blocks = [ "0.0.0.0/0" ]
    },
    {
        description    = "ext-https"
        from_port      = 443
        to_port        = 443
        protocol       = "TCP"
        v4_cidr_blocks = [ "0.0.0.0/0" ]
    },
    {
        description    = "internal"
        from_port      = 0
        to_port        = 65535
        protocol       = "ANY"
        v4_cidr_blocks = [ "172.16.10.0/24" ]
    },

    {
      description = "gitlab_ssh"
      from_port = 2222
      protocol = "TCP"
      to_port = 2222
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    },
    {
      description = "gitlab_registry"
      from_port = 5000
      protocol = "TCP"
      to_port = 5000
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
    ]
 }

variable "sec_group_egress" { 
    type = list(object({
        description     = string
        from_port       = number
        to_port         = number
        protocol        = string
        v4_cidr_blocks  = list(string)
    }))
    default = [ {
        description    = "any"
        from_port      = 0
        to_port        = 65535
        protocol       = "ANY"
        v4_cidr_blocks = [ "0.0.0.0/0" ]
    } ]
}

variable "nat_route_table_name" {
    type    = string 
    default = "internal-nat-route"
}

variable "nat_route_table" {
    type = list(object({
        destination_prefix = string
        next_hop_address   = string
    })) 
    default = [ {
        destination_prefix = "0.0.0.0/0"
        next_hop_address   = "172.16.20.20"
    }]
}