variable "project_name" {
}
variable "ami_value" {
  
}
variable "instance_type" {
  
}
variable "key_name" {
  
}
variable "lt_sg_ids" {
  type = list(string)
}
variable "user_data" {
  type = string
  default = ""
}
variable "desired_capacity" {
  default = 2
  type = number
}
variable "min_size" {
  default = 1
  type = number
}
variable "max_size" {
  type = number
  default = 4
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "target_group_arn" {
  type = string
}