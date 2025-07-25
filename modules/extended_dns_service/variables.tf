variable "twc_dns_records" {
    type = list(object({
        name  = string
        value = string
    }))
}

variable "dns_zone_name" {
    type    = string
    default = "fawkesguyd.ru"
}

variable "dns_record_type" {
    type    = string
    default = "A"
}