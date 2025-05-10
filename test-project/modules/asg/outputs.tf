output "alb_name" {
  value = aws_autoscaling_group.app_asg.name
}

output "private_ips" {
  description = "Private IPs of EC2 instances in the ASG"
  value       = data.aws_instances.asg_instances.private_ips
}