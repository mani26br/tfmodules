resource "azurerm_backup_protected_vm" "backup_protected_vm" {
  resource_group_name = var.backup_protected_vm_resource_group_name
  recovery_vault_name = var.backup_protected_vm_recovery_vault_name
  source_vm_id = var.backup_protected_vm_source_vm_id
  backup_policy_id = var.backup_protected_vm_backup_policy_id
  tags = merge(tomap(
  "resource_group_name", var.backup_protected_vm_resource_group_name,
  ), var.backup_protected_vm_tags)
 }
