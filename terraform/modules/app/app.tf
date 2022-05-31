resource "yandex_compute_instance" "app" {
  count       = var.app_count
  name        = "app-${count.index}"
  platform_id = "standard-v1"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd80o2eikcn22b229tsa"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
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
      "echo 'app-${count.index} up'",
    ]
  }
}