variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "project_name" {
  default = "default_project"
}

variable "subnets" {
  type = map(object({
    az = string
    type = string
    nat_key = optional(string)
  }))
  default = {
    "pub_sub_ap_south_1a" = {
      az="ap-south-1a",type="public"
    }
    "pub_sub_ap_south_1b" = {
      az="ap-south-1b",type="public"
    }
    "priv_sub_ap_south_1a" = {
      az="ap-south-1a",type="private",nat_key="pub_sub_ap_south_1a"
    }
    "priv_sub_ap_south_1b" = {
      az="ap-south-1b",type="private",nat_key="pub_sub_ap_south_1b"
    }
  }
}