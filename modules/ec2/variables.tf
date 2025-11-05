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
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where EFS will be deployed"
  type        = string
}

variable "alb_sg_id" {
  description = "The security group ID of the ALB"
  type        = string
}

variable "efs_id" {
  description = "The ID of the EFS"
  type        = string
}

variable "efs_sg_id" {
  description = "The security group ID of the EFS"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "efs_dns_name" {
  description = "The DNS name of the EFS"
  type        = string
}