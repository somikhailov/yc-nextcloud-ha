variable "ansible_hosts" {
  default = {
    app = {
      app-1 = "10.0.0.1"
      app-2 = "10.0.0.2"
    }

    db = {
      db-1 = "10.0.0.3"
      db-2 = "10.0.0.4"
    }
  }
}

variable "bastion_ip" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "ansible_inventory_template" {
  description = "Path to ansible inventory template"
  type        = string
}

variable "ansible_inventory" {
  description = "Path to generated ansible inventory"
  type        = string
}

variable "ansible_playbook_template" {
  description = "Path to main ansible playbook template"
  type        = string
}

variable "ansible_playbook" {
  description = "Path to main ansible playbook file"
  type        = string
}

variable "ssh_key" {
  description = "path to your ssh private Key"
  type        = string
}

variable "user" {
  description = "user for connection to instances with ssh public key"
  type        = string
}