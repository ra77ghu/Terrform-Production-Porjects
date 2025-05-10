vpc_cidr     = "10.1.0.0/16"
project_name = "pro_porsche"
subnets = {
  "public_sub_ap_south_1a" = {
    az = "ap-south-1a", type = "public"
  }
  "public_sub_ap_south_1b" = {
    az = "ap-south-1b", type = "public"
  }
  "private_sub_ap_south_1a" = {
    az = "ap-south-1a", type = "private", nat_key = "public_sub_ap_south_1a"
  }
  "private_sub_ap_south_1b" = {
    az = "ap-south-1b", type = "private", nat_key = "public_sub_ap_south_1b"
  }
}
allowed_ssh_cidrs = ["122.166.150.103/32"]
desired_capacity  = 2
min_size          = 1
max_size          = 4

ubuntu_codename = "jammy"
ubuntu_version = "22.04"
