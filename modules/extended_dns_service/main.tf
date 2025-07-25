# Select zone with name "example.com"
data "twc_dns_zone" "example-zone" {
  name = var.dns_zone_name 
}

resource "twc_dns_rr" "example-resource-record" {
  for_each = { for record in var.twc_dns_records : record.name => record.value }
  zone_id = data.twc_dns_zone.example-zone.id

  name = each.key
  type = "A"
  value = each.value 
}