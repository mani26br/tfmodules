
resource "azurerm_role_assignment" "roleassignment" {
  scope                            = var.roleassignment_scope
  role_definition_id               = var.roledefinition
  role_definition_name             = var.roledefinition_name
  principal_id                     = var.principalid
  skip_service_principal_aad_check = var.skip_service_principal_aad_check
}
