
variable "database_name" {
  description = "username for grafana dashboard"
  type        = string
}

variable "database_user" {
  description = "password for grafana password"
  type        = string
}

variable "database_password" {
  description = "database_password"
  type        = string
}

variable "database_port" {
  description = "database_port"
  type        = string
}

variable "subnet_ids" {
  description = "PVC subnets"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "vpc_security_group_ids"
  type        = list(string)
}
