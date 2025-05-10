variable "vpc_cidr" {
}
variable "project_name" {
}

variable "subnets" {
  type = map(object({
    az      = string
    type    = string
    nat_key = optional(string)
  }))
}

variable "allowed_ssh_cidrs" {
  type = list(string)
}

variable "key_name" {
  default = "raghu-keypair"
  type    = string
}
variable "ubuntu_codename" {
  default = "noble"
  type    = string
}
variable "ubuntu_version" {
  default = "24.04"
  type    = string
}
variable "architecture" {
  default = "amd64"
  type = string
}
variable "instance_type" {
  default = "t2.micro"
  type    = string
}
variable "min_size" {
  type = number
}
variable "max_size" {
  type = number
}
variable "desired_capacity" {
  type = number
}
variable "user_data" {
  default = ""
  type    = string
}
variable "bastian_instance_type" {
  default = "t2.micro"
  type    = string
}

