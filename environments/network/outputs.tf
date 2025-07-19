output "network_id" {
    value = module.network.network_id
}

output "dns_zone_id" {
  value       = module.network.dns_zone_id
}

output "subnet_ids" {
    value = module.network.subnet_ids
}

output "security_group_id" {
  value = module.network.security_group_id
}