output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
output "project_name" {
    value = var.project_name 
}
output "subnets" {
  value = {
    for k, v in aws_subnet.subnets :
    k => {
      id         = v.id
      cidr_block = v.cidr_block
      az         = v.availability_zone
      type       = lookup(var.subnets[k], "type", null)
    }
  }
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "private_subnets" {
  value = {for k, v in aws_subnet.subnets : k => v.id if v.map_public_ip_on_launch == false}
}