resource "yandex_vpc_network" "nextloud-net" {}

module "bastion" {
  source = "./terraform/modules/bastion"

  yc_zone = "ru-central1-a"
  ssh_pub = var.ssh_pub
  ssh_key = var.ssh_key
  vpc-id  = yandex_vpc_network.nextloud-net.id
}

module "yc-instance" {
  source = "./terraform/modules/app"

  yc_zone    = "ru-central1-a"
  ssh_pub    = var.ssh_pub
  ssh_key    = var.ssh_key
  dns_zone   = "somikhailov-fun"
  vpc-id     = yandex_vpc_network.nextloud-net.id
  bastion_ip = module.bastion.bastion_ip
}

module "ansible_provision" {
  source = "./terraform/modules/ansible_provision"

  ansible_inventory_template = "ansible/inventory.tmpl"
  ansible_inventory          = "ansible/inventory.ini"
  ansible_playbook           = "ansible/site.yml"
  ansible_hosts = {
    app_proxy = module.yc-instance.app_proxy_name_ip
    app       = module.yc-instance.app_name_ip
  }
  bastion_ip = module.bastion.bastion_ip
  ssh_key    = var.ssh_key
  user       = "ubuntu"
}