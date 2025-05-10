output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}
output "subnet_cidr" {
  value = module.vpc.subnet_cidr
}
output "project_name" {
  value = module.vpc.project_name
}