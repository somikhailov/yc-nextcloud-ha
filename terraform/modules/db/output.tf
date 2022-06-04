output "db_name_ip" {
  value = {
    for db in yandex_compute_instance.db :
    db.name => db.network_interface.0.ip_address
  }
}

output "etcd_name_ip" {
  value = {
    for etcd in yandex_compute_instance.etcd :
    etcd.name => etcd.network_interface.0.ip_address
  }
}