resource "yandex_vpc_subnet" "app-subnet-1" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = var.yc_zone
  network_id     = var.vpc-id
}