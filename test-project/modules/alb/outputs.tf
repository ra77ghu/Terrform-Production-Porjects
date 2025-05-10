output "alb_dns_name" {
  value = aws_alb.app_alb.dns_name
}
output "alb_target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}