  resource "aws_security_group" "alb_sg" {
    name = "${var.project_name}-alb-sg"
    vpc_id = var.vpc_id

    ingress {
      description = "Allow HTTP from internet"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      description = "Allow HTTP from internet"
      from_port = 8000
      to_port = 8000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      description = "Allow ssh"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  resource "aws_alb" "app_alb" {
    name = replace("${var.project_name}-alb","_","-")
    internal = var.internal_facing
    load_balancer_type = var.load_balancer_type
    subnets = var.public_subnets
    security_groups = [aws_security_group.alb_sg.id]
  }
  resource "aws_lb_target_group" "app_tg" {
    name = replace("${var.project_name}-tg","_","-")
    port = 8000
    protocol = "HTTP"
    vpc_id = var.vpc_id
  }

  resource "aws_lb_listener" "app_listener" {
    load_balancer_arn = aws_alb.app_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = var.listener_type
      target_group_arn = aws_lb_target_group.app_tg.arn
    }
  }

  resource "aws_lb_listener" "app_listener_8000" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = 8000  # Incoming traffic on port 8000
  protocol          = "HTTP"

  default_action {
    type             = var.listener_type
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
