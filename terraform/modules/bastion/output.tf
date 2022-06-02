output "bastion_ip" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}

output "rt_id" {
  value = yandex_vpc_route_table.bastion-rt.id
}