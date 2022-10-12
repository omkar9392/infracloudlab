variable "project" {
  description = "terraform-test-omkar"
  default = "terraform-test-omkar"
}

variable "environment" {
  description = "test"
  default = "test"
}

variable "region" {
  description = "ap-south-1"
  default = "ap-south-1"

}

variable "ami_id" {
  description = "ami-010aff33ed5991201"
  default = "ami-010aff33ed5991201"
}

variable "instance_type" {
  description = "t2.micro"
  default = "t2.micro"
}

variable "key_name" {
  description = "TFkey"
  default = "TFkey"
}

variable "subnet_id" {
  description = "subnet_id"

}

variable "vpc_security_group_ids" {
  description = "vpc_security_group_ids"
}
