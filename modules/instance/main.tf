resource "yandex_compute_instance" "this" {
  for_each = { for vm in var.vms : vm.name => vm }

  name        = each.value.name
  platform_id = each.value.platform_id
  zone        = each.value.zone

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = each.value.image_id
      type     = each.value.disk_type
      size     = each.value.disk_size
    }
  }

  network_interface {
    subnet_id          = each.value.subnet_id
    nat                = each.value.nat
    ip_address         = each.value.ip_address
    security_group_ids = var.security_group_ids
  }

  metadata = {
    ssh-keys  = "${var.ssh_user}:${var.ssh_pubkey}"
    user-data = "${file("${path.module}/cloud-init/user-data.yaml")}"
  }
  allow_stopping_for_update = each.value.allow_stopping_for_update
}

resource "yandex_dns_recordset" "internal" {
  for_each = {
    for name, vm in yandex_compute_instance.this :
    name => vm.network_interface[0].ip_address
    if can(regex("^fable-instance-internal-*", name))
  }

  zone_id  = var.dns_zone_id
  name     = replace(each.key, "fable-instance-internal-", "")
  type     = var.subdomain_type
  ttl      = var.subdomain_ttl
  data     = [each.value]
}
