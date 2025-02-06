#Provides a Route53 health check.
resource "aws_route53_health_check" "route53_health_check" {
  fqdn              = var.route53_health_check_fqdn
  port              = var.route53_health_check_port
  type              = var.route53_health_check_type
  resource_path     = var.route53_health_check_resource_path
  failure_threshold = var.route53_health_check_failure_threshold
  request_interval  = var.route53_health_check_request_interval
  tags         = merge(map(
                "comment", var.route53_health_check_comment,
                ), var.route53_health_check_tags)
}