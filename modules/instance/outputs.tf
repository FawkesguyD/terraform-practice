output "ip_addresses" {
    value = {
        for name, vm in yandex_compute_instance.this :
        name => vm.network_interface.0.ip_address
    }
}