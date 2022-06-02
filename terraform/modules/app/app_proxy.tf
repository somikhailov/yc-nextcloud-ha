resource "yandex_compute_instance" "app_proxy" {
  count       = 2
  name        = "app-proxy-${count.index}"
  platform_id = "standard-v1"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # docker host
      image_id = "fd80o2eikcn22b229tsa"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.app-subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_pub)}"
  }

  connection {
    type         = "ssh"
    user         = "ubuntu"
    agent        = false
    private_key  = file(var.ssh_key)
    host         = self.network_interface.0.ip_address
    bastion_host = var.bastion_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'app_proxy-${count.index} up'",
    ]
  }
}