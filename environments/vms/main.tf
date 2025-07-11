data "terraform_remote_state" "network" {
    backend = "s3"

    config = { 
        endpoints = {
            s3 = "https://storage.yandexcloud.net"
        }
        bucket                      = "fable-tf-state"
        region                      = "ru-central1-a"
        key                         = "network/state.tf"
        skip_region_validation      = true
        skip_credentials_validation = true
        skip_requesting_account_id  = true
        skip_s3_checksum            = true
    }
}

locals {
    vms = [
        for vm in var.vms : merge(vm, {
            subnet_id = data.terraform_remote_state.network.outputs.subnet_ids[vm.subnet_label]
        })
    ]
}

module "instance" {
    source         = "../../modules/instance"

    vms            = local.vms

    ssh_pubkey     = var.ssh_pubkey
    ssh_user       = var.ssh_user

    dns_zone_id    = data.terraform_remote_state.network.outputs.dns_zone_id
    subdomain_type = var.subdomain_type
    subdomain_ttl  = var.subdomain_ttl
}