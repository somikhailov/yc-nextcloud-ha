resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  platform_id = "standard-v1"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # https://cloud.yandex.ru/marketplace/products/yc/nat-instance-ubuntu-18-04-lts
      image_id = "fd8pm25269c5gqs23eb9"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.bastion-subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_pub)}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    agent       = false
    private_key = file(var.ssh_key)
    host        = self.network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'bastion up'",
    ]
  }
}