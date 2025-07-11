output "network_id" {
  value       = yandex_vpc_network.this.id
}

output "dns_zone_id" {
  value       = yandex_dns_zone.this.id
}

output "subnet_ids" {
  description = "IDs of all created subnets"
  value       = { for k, s in yandex_vpc_subnet.this : k => s.id }
}