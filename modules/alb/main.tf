locals {
  true_owner = "${var.owner}-nclouds-2026"
}

resource "aws_security_group" "alb_sg" {
  name        = "jorge0509-alb-SG"
  description = "Security group for alb instances"
  vpc_id      = var.vpc_id

  tags = {
    Name    = "jorge0509-alb-SG"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_security_group_rule" "http_inbound_lb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
  description       = "Allow HTTP from the internet"
}

resource "aws_security_group_rule" "https_inbound_lb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
  description       = "Allow HTTPS from the internet"
}

resource "aws_security_group_rule" "alb_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
  description       = "Allow all outbound traffic"
}

resource "aws_lb" "main" {
  name               = "jorge0509-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnet_id

  enable_deletion_protection = false

  tags = {
    Name    = "jorge0509-ALB"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "jorge0509-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name    = "jorge0509-TG"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.arn_certificate 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}