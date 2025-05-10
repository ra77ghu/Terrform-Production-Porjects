locals {
  private_subnets = {
    for k, v in var.subnets : k => v if v.type == "private"
  }
  public_subnets = {
    for k, v in var.subnets : k => v if v.type == "public"
  }
}
  
