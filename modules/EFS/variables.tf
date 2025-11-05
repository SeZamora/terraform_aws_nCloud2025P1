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

variable "subnet_id" {
  description = "List of subnet IDs where EFS will be deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where EFS will be deployed"
  type        = string
}

