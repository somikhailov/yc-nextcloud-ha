resource "yandex_vpc_subnet" "db-subnet-1" {
  v4_cidr_blocks = ["10.3.0.0/16"]
  zone           = var.yc_zone
  network_id     = var.vpc-id
  route_table_id = var.bastion_rt_id
}