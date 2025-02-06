resource "azurerm_api_management" "api_management" {
  name                = var.api_management_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_name
}

resource "azuread_application" "ad_application" {
  name                       = var.ad_application
  oauth2_allow_implicit_flow = true
  reply_urls                 = var.reply_urls
}

resource "azuread_application_password" "application_password" {
  application_object_id = var.application_object_id
  end_date_relative     = var.end_date_relative
  value                 = var.value
}

resource "azurerm_api_management_identity_provider_aadb2c" "aadb2c" {
  api_management_id = azurerm_api_management.api_management.id
  client_id         = azuread_application.ad_application.application_id
  client_secret     = var.client_secret
  allowed_tenant    = var.allowed_tenant
  signin_tenant     = var.signin_tenant
  authority         = var.authority
  signin_policy     = var.signin_policy
  signup_policy     = var.signup_policy

  depends_on = [azuread_application_password.application_password]
}