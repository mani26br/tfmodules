resource "aws_customer_gateway" "customergateway" {
   bgp_asn = var.bgp_asn
   ip_address = var.ip_address
   type = var.type
   tags = merge(map(
     "Name", var.customergateway_name,
     "bgp_asn", var.bgp_asn,
     ), var.customergateway_tags)
}