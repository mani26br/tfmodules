resource "azurerm_disk_encryption_set" "diskencryptionset" {
  name                = var.disk_encryption_set
  resource_group_name = var.resource_group_name
  location            = var.resource_group_name_location
  key_vault_key_id    = var.keyvault_id

  dynamic "identity" {
    for_each = "${var.vm_identity}"

	content {
	  type = "${lookup(identity.value, "type", null)}"
    }
 }

}
