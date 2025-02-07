terraform {
  backend "azurerm" {
    resource_group_name   = "ncats-az-k2-automation-jenkins"
    storage_account_name  = "aztfstatefilebackup"   
    container_name        = "az-ncats-workflow-automation-tfstate"            
    key                   = "platform-services/terraform-ncats-workflow-automation.tfstate"
    subscription_id = "AZURE_SUBSCRIPTION_ID"
    client_id       = "AZURE_CLIENT_ID"
    client_secret   = "AZURE_CLIENT_SECRET"
    tenant_id       = "AZURE_TENANT_ID"
  }
}
