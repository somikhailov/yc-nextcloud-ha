output "app_name_ip" {
  value = {
    for app in yandex_compute_instance.app :
    app.name => app.network_interface.0.ip_address
  }
}

output "app_proxy_name_ip" {
  value = {
    for app_proxy in yandex_compute_instance.app_proxy :
    app_proxy.name => app_proxy.network_interface.0.ip_address
  }
}

output "external_lb_ip" {
  value = one(one(tolist(yandex_lb_network_load_balancer.app_lb.listener)[0][*]).external_address_spec).address
}