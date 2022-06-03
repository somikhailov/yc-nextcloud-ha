resource "yandex_lb_network_load_balancer" "app_lb" {
  name = "app-lb"

  listener {
    name     = "https-listener"
    port     = 443
    protocol = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  listener {
    name     = "http-listener"
    port     = 80
    protocol = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.app_proxy_group.id

    healthcheck {
      name = "http"
      tcp_options {
        port = 443
      }
    }
  }
}

resource "yandex_lb_target_group" "app_proxy_group" {
  name = "app-proxy-group"

  target {
    subnet_id = yandex_vpc_subnet.app-subnet-1.id
    address   = yandex_compute_instance.app_proxy[0].network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.app-subnet-1.id
    address   = yandex_compute_instance.app_proxy[1].network_interface.0.ip_address
  }
}