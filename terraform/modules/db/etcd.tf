resource "yandex_compute_instance" "etcd" {
  count       = 3
  name        = "etcd-${count.index}"
  platform_id = "standard-v1"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      # docker host
      image_id = "fd80o2eikcn22b229tsa"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.db-subnet-1.id
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
      "echo 'etcd-${count.index} up'",
    ]
  }
}