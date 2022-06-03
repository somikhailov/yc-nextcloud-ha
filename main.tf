resource "yandex_vpc_network" "nextloud-net" {
  name = var.yc_vpc_network_name
}

module "bastion" {
  source = "./terraform/modules/bastion"

  yc_zone = var.yc_zone
  ssh_pub = var.ssh_pub
  ssh_key = var.ssh_key
  vpc-id  = yandex_vpc_network.nextloud-net.id
}

module "db" {
  source = "./terraform/modules/db"

  yc_zone       = var.yc_zone
  ssh_pub       = var.ssh_pub
  ssh_key       = var.ssh_key
  vpc-id        = yandex_vpc_network.nextloud-net.id
  bastion_ip    = module.bastion.bastion_ip
  bastion_rt_id = module.bastion.rt_id
}

module "app" {
  source = "./terraform/modules/app"

  yc_zone       = var.yc_zone
  ssh_pub       = var.ssh_pub
  ssh_key       = var.ssh_key
  dns_zone      = var.yc_dns_zone_name
  vpc-id        = yandex_vpc_network.nextloud-net.id
  bastion_ip    = module.bastion.bastion_ip
  bastion_rt_id = module.bastion.rt_id
}

module "ansible_provision" {
  source = "./terraform/modules/ansible_provision"

  ansible_inventory_template = "ansible/inventory.tmpl"
  ansible_inventory          = "ansible/inventory.ini"
  ansible_playbook_template  = "ansible/site.tmpl"
  ansible_playbook           = "ansible/site.yml"
  ansible_hosts = {
    app_proxy = module.app.app_proxy_name_ip
    app       = module.app.app_name_ip
    db        = module.db.db_name_ip
    etcd      = module.db.etcd_name_ip
  }
  bastion_ip    = module.bastion.bastion_ip
  domain_name   = module.app.domain_name
  postgres_host = module.db.db_ip
  ssh_key       = var.ssh_key
  user          = "ubuntu"
}