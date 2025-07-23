resource "azurerm_local_network_gateway" "onpremise" {
  name                = var.local_network_gateway_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  gateway_address     = var.local_gateway_address
  address_space       = var.local_gateway_address_space

  dynamic "bgp_settings" {
    for_each = var.bgp_settings

	content {
	  asn = "${lookup(bgp_settings.value, "asn", null)}"
	  bgp_peering_address = "${lookup(bgp_settings.value, "bgp_peering_address", null)}"

    }
  }

}
