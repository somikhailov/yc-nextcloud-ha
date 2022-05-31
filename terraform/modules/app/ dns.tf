data "yandex_dns_zone" "zone" {
  name = var.dns_zone
}

resource "yandex_dns_recordset" "nextcloud" {
  zone_id = data.yandex_dns_zone.zone.id
  name    = "nextcloud"
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.app[0].network_interface.0.nat_ip_address]
}