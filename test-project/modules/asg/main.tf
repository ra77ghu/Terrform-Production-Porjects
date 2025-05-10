resource "aws_launch_template" "app_lt" {
  name_prefix = "${var.project_name}-lt"
  image_id = var.ami_value
  instance_type = var.instance_type
  key_name = var.key_name
  
  network_interfaces {
    associate_public_ip_address = false
    security_groups = var.lt_sg_ids
  }
  user_data = base64encode(var.user_data)
}

resource "aws_autoscaling_group" "app_asg" {
  name = "${var.project_name}-asg"
  desired_capacity = var.desired_capacity
  min_size = var.min_size
  max_size = var.max_size
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id = aws_launch_template.app_lt.id
    version = "$Latest"
  }
  target_group_arns = [var.target_group_arn]

  tag {
    key = "Name"
    value = "${var.project_name}-app"
    propagate_at_launch = true
  }
}


# Use the AWS Autoscaling Group to get the instance IDs
data "aws_autoscaling_group" "asg_group" {
  name = aws_autoscaling_group.app_asg.name
}

# Get the private IPs of instances using the instance IDs from the ASG
data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [aws_autoscaling_group.app_asg.name]
  }
}