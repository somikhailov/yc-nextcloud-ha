module "yc-instance" {
  source = "./terraform/modules/app"

  yc_zone         = "ru-central1-a"
  ssh_pub         = var.ssh_pub
  ssh_key         = var.ssh_key
  dns_zone        = "somikhailov-fun"
  app_count       = 1
  app_proxy_count = 2
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
  ssh_key = var.ssh_key
  user    = "ubuntu"
}