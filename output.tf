output "bastion_ip" {
  value = module.bastion.bastion_ip
}

output "external_lb_ip" {
  value = module.yc-instance.external_lb_ip
}

output "domain_name" {
  value = module.yc-instance.domain_name
}