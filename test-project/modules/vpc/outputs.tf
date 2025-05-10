output "subnet_cidr" {
  value = {for k,v in aws_subnet.subnets: k=>v.cidr_block} 
}
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
output "project_name" {
    value = var.project_name 
}