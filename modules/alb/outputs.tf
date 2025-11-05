output "alb_dns_name" {
  description = "DNS name of the Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_sg_id" {
  description = "Security Group ID of the ALB"
  value       = aws_security_group.alb_sg.id
}

output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.tg.arn
}

output "alb_zone_id" {
  description = "Zone ID of the Load Balancer"
  value       = aws_lb.main.zone_id
}