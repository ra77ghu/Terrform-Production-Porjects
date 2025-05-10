locals {
  public_subnet_ids = [
    for s in module.vpc.subnets : s.id if s.type == "public"
  ]
  private_subnet_ids = [
    for s in module.vpc.subnets : s.id if s.type == "private"
  ]
}
