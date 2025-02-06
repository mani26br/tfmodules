#The Amazon Resource Name (ARN) of the Health Check.

output "route53_health_check_arn" {
  value = aws_route53_health_check.route53_health_check.arn
}