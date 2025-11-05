output "efs_id" {
  value = aws_efs_file_system.main.id
}

output "efs_sg_id" {
  value = aws_security_group.sec_group.id
}

output "efs_dns_name" {
  value = aws_efs_file_system.main.dns_name
}