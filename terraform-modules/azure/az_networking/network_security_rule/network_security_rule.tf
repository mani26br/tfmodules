provider "azurerm" {

  features {}
}

resource "azurerm_network_security_rule" "network_security_rule" {
  #count = "${length(var.network_security_rule)}"
  name = "${var.network_security_rule_name}"
  resource_group_name = "${var.network_security_rule_resource_group_name}"
  network_security_group_name = "${var.network_security_rule_network_security_group_name}"
  description = "${var.network_security_rule_description}"
  protocol = "${var.network_security_rule_protocol}"
  source_port_range = "${var.network_security_rule_source_port_range}"
  #source_port_ranges = "${var.network_security_rule_source_port_ranges}"
  destination_port_range = "${var.network_security_rule_destination_port_range}"
  #destination_port_ranges = "${var.network_security_rule_destination_port_ranges}"
  #source_address_prefix = "${var.network_security_rule_source_address_prefix}"
  source_address_prefixes = "${var.network_security_rule_source_address_prefixes}"
  source_application_security_group_ids = "${var.network_security_rule_source_application_security_group_ids}"
  destination_address_prefix = "${var.network_security_rule_destination_address_prefix}"
  #destination_address_prefixes = "${var.network_security_rule_destination_address_prefixes}"
  destination_application_security_group_ids = "${var.network_security_rule_destination_application_security_group_ids}"
  access = "${var.network_security_rule_access}"
  priority = "${var.network_security_rule_priority}"
  direction = "${var.network_security_rule_direction}"
}
