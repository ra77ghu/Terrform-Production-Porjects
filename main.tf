provider "aws" {
  region = "ap-south-1"
}
data "aws_ami" "ami_value" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-${var.ubuntu_codename}-${var.ubuntu_version}-${var.architecture}-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "ec2_kp" {
  key_name = "raghu-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}
module "vpc" {
  source       = "./test-project/modules/vpc"
  vpc_cidr     = var.vpc_cidr
  subnets      = var.subnets
  project_name = var.project_name
}
module "alb" {
  source         = "./test-project/modules/alb"
  project_name   = var.project_name
  public_subnets = local.public_subnet_ids
  vpc_id         = module.vpc.vpc_id
}

module "bastion" {
  source                = "./test-project/modules/bastion"
  bastian_public_subnet = local.public_subnet_ids[0]
  project_name          = var.project_name
  allowed_ssh_cidrs     = var.allowed_ssh_cidrs
  vpc_id                = module.vpc.vpc_id
  instance_type         = var.bastian_instance_type
  ami_value             = data.aws_ami.ami_value.id
  key_name = aws_key_pair.ec2_kp.key_name
}

module "asg" {
  source             = "./test-project/modules/asg"
  private_subnet_ids = local.private_subnet_ids
  lt_sg_ids          = [module.alb.alb_sg_id]
  project_name       = var.project_name
  key_name           = var.key_name
  ami_value          = data.aws_ami.ami_value.id
  instance_type      = var.instance_type
  target_group_arn   = module.alb.alb_target_group_arn
  min_size           = var.min_size
  max_size           = var.max_size
  desired_capacity   = var.desired_capacity
  user_data          = var.user_data
}