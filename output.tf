output "app_name_ip" {
  value = module.yc-instance.app_name_ip
}

output "app_proxy_name_ip" {
  value = module.yc-instance.app_proxy_name_ip
}

output "bastion_ip" {
  value = module.bastion.bastion_ip
}

output "external_lb_ip" {
  value = module.yc-instance.external_lb_ip
}