output "db_name_ip" {
  value = {
    for db in yandex_compute_instance.db :
    db.name => db.network_interface.0.ip_address
  }
}

output "db_ip" {
  value = yandex_compute_instance.db.0.network_interface.0.ip_address
}