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
variable "availability_zones" {
  type        = list(any)
  description = "The names of the availability zones to use"
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
  default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the public subnet"
  default = ["10.0.1.0/24", "10.0.2.0/24","10.0.3.0/24"]

}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the private subnet"
  default = ["10.0.4.0/24", "10.0.5.0/24","10.0.6.0/24"]

}
