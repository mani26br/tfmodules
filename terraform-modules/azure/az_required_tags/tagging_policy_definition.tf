#### Create a policy definition for restricting resources without adding required tags
locals {
  required_tags = var.required_tags

  required_tag_conditions = [
    for tag in local.required_tags : {
      field  = "tags['${tag}']"
      exists = false
    }
  ]

  excluded_resource_types = [
    "Microsoft.Compute/virtualMachines/extensions",
    "Microsoft.Insights/diagnosticSettings",
    "Microsoft.KeyVault/vaults/accessPolicies",
    "Microsoft.EventHub/namespaces/eventhubs/consumergroups",
    "Microsoft.Sql/servers/databases/extensions",
    "Microsoft.Compute/virtualMachineScaleSets/virtualMachines",
    "Microsoft.Resources/deployments",
    "Microsoft.OperationalInsights/workspaces"
    # Add more types if needed
  ]

  resource_type_exclusion_conditions = [
    for rt in local.excluded_resource_types : {
      field     = "type"
      notEquals = rt
    }
  ]
}

resource "azurerm_policy_definition" "add_tags" {
  name         = var.policy_name
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Enforce required tags on resources"
  description  = "This policy denies creation of resources missing required tags unless excluded."

  metadata = jsonencode({
    category = "Tags"
  })

  policy_rule = jsonencode({
    "if" = {
      "allOf" = concat(
        [
          {
            "anyOf" = local.required_tag_conditions
          }
        ],
        local.resource_type_exclusion_conditions
      )
    },
    "then" = {
      "effect" = "deny"
    }
  })
}

resource "azurerm_resource_group_policy_assignment" "assign_policy" {
  for_each             = toset(var.resource_group_names)
  name                 = var.policy_assignment_name
  resource_group_id    = "/subscriptions/${var.subscription_id[0]}/resourceGroups/${each.value}"
  policy_definition_id = azurerm_policy_definition.add_tags.id
  description          = var.policy_description
  display_name         = var.policy_assignment_name

  non_compliance_message {
    content = var.non_compliance_message
  }
}
