variable "project_name" {
  description = "Defines the project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
}

variable "ipElastic" {
  description = "Elastic IP for NAT Gateway"
  type        = string
}

variable "domain_name" {
  description = "Domain name for Route53"
  type        = string
}

variable "subdomain_name" {
  description = "Subdomain for Route53"
  type        = string
}

variable "arn_certificate" {
  description = "ARN of the SSL certificate for HTTPS"
  type        = string
}
