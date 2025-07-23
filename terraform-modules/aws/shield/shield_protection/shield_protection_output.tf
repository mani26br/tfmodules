#The unique identifier (ID) for the Protection object that is created.
output "shield_protection_id" {
  value = aws_shield_protection.shield_protection.id
}