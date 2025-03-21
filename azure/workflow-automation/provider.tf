terraform {
  required_version = "1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.74.0"  # Update to the latest compatible version
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "AZURE_SUBSCRIPTION_ID"
  client_id       = "AZURE_CLIENT_ID"
  client_secret   = "AZURE_CLIENT_SECRET"
  tenant_id       = "AZURE_TENANT_ID"
  skip_provider_registration = "true"
}

