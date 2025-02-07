terraform {
  backend "azurerm" {
    resource_group_name   = "nih-ncats-aspire-rg-admin-az"
    storage_account_name  = "ncatstfstatefilebackup"   
    container_name        = "nih-ncats-aspire-tfstate"            
    key                   = "platform-services/terraform-nih-ncats-aspire.tfstate"
  }
}
