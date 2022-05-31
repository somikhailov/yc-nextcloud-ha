variable "yc_zone" {
  type = string
}

variable "ssh_pub" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "dns_zone" {
  type = string
}

variable "app_count" {
  description = "count app instances"
  type        = number
}

variable "app_proxy_count" {
  description = "count app_proxy instances"
  type        = number
}