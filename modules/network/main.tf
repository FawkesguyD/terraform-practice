resource "yandex_vpc_network" "this" {
  name        = var.network_name 
  description = var.network_description
  folder_id   = var.folder_id
}
 
resource "yandex_vpc_security_group" "this" {
  name        = var.sec_group_name
  description = var.sec_group_name
  network_id  = yandex_vpc_network.this.id

  dynamic "ingress" {
    for_each = { for group in var.sec_group_ingress : group.description => group }
    content {
      protocol       = ingress.value.protocol
      description    = ingress.key
      v4_cidr_blocks = ingress.value.v4_cidr_blocks
      from_port      = ingress.value.from_port
      to_port        = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = { for group in var.sec_group_egress : group.description => group }
    content { 
      protocol       = egress.value.protocol
      description    = egress.key
      v4_cidr_blocks = egress.value.v4_cidr_blocks
      from_port      = egress.value.from_port
      to_port        = egress.value.to_port
    }
  }
}

resource "yandex_vpc_route_table" "internal" {
  name       = var.nat_route_table_name
  network_id = yandex_vpc_network.this.id 

  dynamic "static_route" {
    for_each = var.nat_route_table
    content  {
      destination_prefix = static_route.value.destination_prefix
      next_hop_address   = static_route.value.next_hop_address
    }
  }
}

resource "yandex_vpc_subnet" "this" {
  for_each = {
    for subnet in var.subnets :
    subnet.name => subnet.v4_cidr_blocks
  }
  name           = each.key
  v4_cidr_blocks = each.value

  route_table_id = can(regex("internal", each.key )) ? yandex_vpc_route_table.internal.id : ""

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