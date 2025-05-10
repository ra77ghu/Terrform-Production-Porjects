module "vpc" {
  source = "./test-project/modules/vpc"
  vpc_cidr = var.vpc_cidr
  subnets = var.subnets
  project_name = var.project_name
}
