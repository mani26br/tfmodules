#Creates an association between a Route53 Health Check and a Shield Advanced protected resource.
# This association uses the health of your applications to improve responsiveness and accuracy in attack detection and mitigation.

resource "aws_shield_protection_health_check_association" "shield_protection_health_check_association" {
  health_check_arn     = var.shield_protection_health_check_association_arn
  shield_protection_id = var.shield_protection_health_check_association_id
}