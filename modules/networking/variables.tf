variable "az" {
  type = string
  default = "ap-southeast-1a"
}

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_presentation_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_app_cidr" {
  type = string
  default = "10.0.2.0/24"
}

variable "private_subnet_db_cidr" {
  type = string
  default = "10.0.3.0/24"
}