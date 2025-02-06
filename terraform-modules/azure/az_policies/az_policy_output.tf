output "policy_assignment_id" {
  description = "The Policy Assignment id."
  value = azurerm_policy_assignment.policy_assignment.id
}

output "policy_assignment_identity" {
  description = "An identity block"
  value = azurerm_policy_assignment.policy_assignment.identity
}