variable "project_name" {
  type = string
}
variable "vpc_id" {
    type = string
  
}
variable "allowed_ssh_cidrs" {
  type = list(string)
}
variable "ami_value" {
    default = ""
    type = string
}
variable "key_name" {
  type = string
}
variable "bastian_public_subnet" {
    
}
variable "instance_type" {
  default = "t2.micro"
  type = string
}
