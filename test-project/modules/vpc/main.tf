resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags = {
    Name = "${var.project_name}_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}_igw"
  }
}
resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}_public_rtb"
  }
}

resource "aws_route" "pub_igw_route" {
  route_table_id = aws_route_table.internet.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_subnet" "subnets" {
  vpc_id = aws_vpc.vpc.id
  for_each = var.subnets
  cidr_block = cidrsubnet(var.vpc_cidr,2,index(keys(var.subnets),each.key))
  availability_zone = each.value.az
  map_public_ip_on_launch = each.value.type=="public"
  tags = {
    Name = each.key
    Type = each.value.type
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each = local.public_subnets
  route_table_id = aws_route_table.internet.id
  subnet_id = aws_subnet.subnets[each.key].id
}

resource "aws_eip" "nat_eips" {
  for_each = local.public_subnets
  domain = "vpc"
  tags = {
    Name = "${each.key}_eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
    for_each = aws_eip.nat_eips
    allocation_id = each.value.id
    subnet_id = aws_subnet.subnets[each.key].id
    tags = {
      Name = "nat_${each.key}"
    }
}

resource "aws_route_table" "rtb_priv" {
  for_each = local.private_subnets
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "rtb_priv_${each.key}"
  }
}

resource "aws_route_table_association" "priv_assoc" {
  for_each = local.private_subnets
  route_table_id = aws_route_table.rtb_priv[each.key].id
  subnet_id = aws_subnet.subnets[each.key].id
}

resource "aws_route" "private_nat_route" {
  for_each = local.private_subnets
  route_table_id = aws_route_table.rtb_priv[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw[each.value.nat_key].id
}