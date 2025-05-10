variable "vpc_id" {
  
}
variable "project_name" {
  
}
variable "public_subnets" {
  
}
variable "listener_type" {
  default = "forward"
}
variable "load_balancer_type" {
  default = "application"
}
variable "internal_facing" {
  default = "false"
}