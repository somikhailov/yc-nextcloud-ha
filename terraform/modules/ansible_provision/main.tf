resource "local_file" "AnsibleInventory" {
  content = templatefile(var.ansible_inventory_template, {
    ansible_hosts = var.ansible_hosts
    user          = var.user
    ssh_key       = var.ssh_key
    bastion_ip    = var.bastion_ip
    }
  )
  filename = var.ansible_inventory
}

resource "null_resource" "ansible" {

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      ansible-playbook -i ${var.ansible_inventory} ${var.ansible_playbook}
    EOT
  }

  depends_on = [
    local_file.AnsibleInventory,
  ]
}