output "internal_ip_address_vm" {
  value = yandex_compute_instance.app[0].network_interface.0.ip_address
}

output "app_name_ip" {
  value = {
    for app in yandex_compute_instance.app :
    app.name => app.network_interface.0.nat_ip_address
  }
}

output "app_proxy_name_ip" {
  value = {
    for app_proxy in yandex_compute_instance.app_proxy :
    app_proxy.name => app_proxy.network_interface.0.nat_ip_address
  }
}
