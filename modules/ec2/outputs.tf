//salidas de la instancia EC2

output "ec2_security_group_id" {
  description = "The ID of the EC2 security group"
  value       = aws_security_group.ec2_sg.id
}

output "ec2_launch_template_id" {
  description = "The ID of the EC2 launch template"
  value       = aws_launch_template.aws_launch.id
}

