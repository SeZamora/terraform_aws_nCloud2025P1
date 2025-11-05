locals {
  true_owner = "${var.owner}-nclouds-2026"
}

resource "aws_security_group" "ec2_sg" {
  name        = "jorge0509-EC2-SG"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  tags = {
    Name    = "jorge0509-EC2-SG"
    Owner   = local.true_owner
    Project = var.project_name
  }
}


resource "aws_security_group_rule" "http_inbound" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = var.alb_sg_id
  description              = "Allow HTTP from ALB"
}


resource "aws_security_group_rule" "nfs_outbound" {
  type              = "egress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_sg.id
  cidr_blocks       = [var.vpc_cidr]
  description       = "Allow NFS to EFS"
}

resource "aws_security_group_rule" "all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
  description       = "Allow all outbound traffic"
}



resource "aws_launch_template" "aws_launch" {
  name_prefix   = "p12025-jorge0509"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id, var.efs_sg_id]


  user_data = base64encode(templatefile("${path.module}/nginixIns.sh", {
    efs_dns_name = var.efs_dns_name
  }))

}