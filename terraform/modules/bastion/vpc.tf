resource "yandex_vpc_subnet" "bastion-subnet-1" {
  v4_cidr_blocks = ["10.1.0.0/16"]
  zone           = var.yc_zone
  network_id     = var.vpc-id
}

resource "yandex_vpc_route_table" "bastion-rt" {
  name       = "bastion-rt"
  network_id = var.vpc-id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.bastion.network_interface.0.ip_address
  }
}