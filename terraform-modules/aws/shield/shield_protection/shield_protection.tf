#Enables AWS Shield Advanced for a specific AWS resource. 

resource "aws_shield_protection" "shield_protection" {
  name         = var.shield_protection_name
  resource_arn = var.shield_protection_arn
  tags         = merge(map(
                "comment", var.shield_protection_comment,
                ), var.shield_protection_tags)
}