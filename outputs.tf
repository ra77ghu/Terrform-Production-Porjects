output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "project_name" {
  value = module.vpc.project_name
}
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "asg_name" {
  value = module.asg.alb_name
}
output "private_ips" {
  description = "Private IPs of EC2 instances in the ASG"
  value       = module.asg.private_ips
}