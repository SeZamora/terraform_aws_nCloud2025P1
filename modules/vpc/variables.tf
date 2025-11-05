variable "project_name" {
  description = "This var definies the project name"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "owner" {
  description = "The owner of the infrastructure"
  type        = string
}

variable "ipElastic"{
  description = "Elastic IP for NAT Gateway"
  type        = string
}