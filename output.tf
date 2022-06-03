output "bastion_ip" {
  value = module.bastion.bastion_ip
}

output "external_lb_ip" {
  value = module.app.external_lb_ip
}

output "domain_name" {
  value = module.app.domain_name
}