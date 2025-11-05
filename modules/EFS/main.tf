locals {
  true_owner = "${var.owner}-nclouds-2026"
}


resource "aws_efs_file_system" "main" {
    creation_token = "my-product"

    tags = {
    Name    = "jorge0509-EFS"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_security_group" "sec_group"{
    
    name        = "jorge0509-EFS-SG"
    description = "Security Group for EFS"
    vpc_id      = var.vpc_id
    tags = {
        Name    = "jorge0509-EFS-SG"
        Owner   = local.true_owner
        Project = var.project_name
    }
}

resource "aws_security_group_rule" "efs_sg_rule_inbound" {
    type                     = "ingress"
    from_port                = 2049
    to_port                  = 2049
    protocol                 = "tcp"
    security_group_id        = aws_security_group.sec_group.id
    cidr_blocks              = [var.vpc_cidr]
    description              = "Allow NFS traffic from VPC"
}


resource "aws_efs_mount_target" "target" {
  count           = length(var.subnet_id)
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.subnet_id[count.index]

  security_groups = [aws_security_group.sec_group.id]
}

