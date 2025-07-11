resource "yandex_vpc_network" "this" {
  name        = var.network_name 
  description = var.network_description
  folder_id   = var.folder_id
}

resource "yandex_vpc_subnet" "this" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }
    
  name           = each.value.name
  v4_cidr_blocks = each.value.v4_cidr_blocks

  network_id     = yandex_vpc_network.this.id
  zone           = var.subnet_zone
}

resource "yandex_dns_zone" "this" {
  name              = var.dns_name
  description       = var.dns_description
  zone              = var.dns_zone
  public            = false
  private_networks  = [yandex_vpc_network.this.id]
}