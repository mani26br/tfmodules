#The unique identifier (ID) for the Protection object that is created.

output "shield_protection_health_check_association_id" {
  value = aws_shield_protection_health_check_association.shield_protection_health_check_association.id
}