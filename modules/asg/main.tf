locals {
  true_owner = "${var.owner}-nclouds-2026"
}

resource "aws_autoscaling_group" "main" {
  name                      = "p12025-jorge0509"
  vpc_zone_identifier       = var.subnet_id
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 3
  health_check_type         = "ELB"
  health_check_grace_period = 60

  target_group_arns = [var.target_group_arn]

  launch_template {
    id      = var.ec2_template_id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "p12025-jorge0509"
    propagate_at_launch = true
  }

  tag {
    key                 = "Owner"
    value               = local.true_owner
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }
}