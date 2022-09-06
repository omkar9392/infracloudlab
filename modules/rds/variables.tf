
variable "subnet_ids" {
  description = "db_subnet_group"
}

variable "vpc_security_group_ids" {
  description = "vpc_security_group_ids"
}

variable "db_password" {
  description = "db_password"
  default = "omkar1234"
}
