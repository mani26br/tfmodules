resource "az_policy" "policy"{
  source  = var.source
  version = var.version

  client_name = var.client_name
  environment = var.environment

  location       = var.location
  location_short = var.location_short
  stack          = var.stack

  policy_name_prefix = var.tags

  policy_rule_content       = var.policy_tags_rule
  policy_parameters_content = var.policy_tags_parameters
  policy_mode               = var.policy_mode 

  policy_assignment_display_name = var.policy_assignment_display_name
  policy_assignments = var.policy_assignments
}


resource "azurerm_policy_assignment" "policy_assignment" {
  name                 = var.name
  scope                = var.scope
  policy_definition_id = var.policy_definition_id
  description          = var.description
  display_name         = var.display_name

  metadata = var.metadata
  parameters = var.parameters
}

