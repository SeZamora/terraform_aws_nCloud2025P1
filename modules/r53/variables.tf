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

variable "alb_dns_name" {
  description = "DNS name of the Load Balancer"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID of the Load Balancer"
  type        = string
}

variable "domain_name" {
  description = "The domain name for Route 53"
  type        = string
}

variable "subdomain_name" {
  description = "The subdomain name for Route 53"
  type        = string
}