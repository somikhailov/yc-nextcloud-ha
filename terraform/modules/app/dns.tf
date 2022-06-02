data "yandex_dns_zone" "zone" {
  name = var.dns_zone
}

resource "yandex_dns_recordset" "nextcloud" {
  zone_id = data.yandex_dns_zone.zone.id
  name    = "nextcloud"
  type    = "A"
  ttl     = 200
  data    = [one(one(yandex_lb_network_load_balancer.app_lb.listener[*]).external_address_spec).address]
}