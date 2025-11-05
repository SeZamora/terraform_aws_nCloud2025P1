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

variable "alb_dns_name" {
  description = "DNS name of the Load Balancer"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the Target Group"
  type        = string
}

variable "ec2_template_id" {
  description = "The ID of the EC2 Launch Template"
  type        = string
}
