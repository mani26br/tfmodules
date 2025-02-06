resource "aws_vpn_connection" "vpnconnection" {

  vpn_gateway_id = "${var.vpn_gateway_id}"

  customer_gateway_id = "${var.customer_gateway_id}"
  type = "${var.type}"

  static_routes_only = "${var.static_routes_only}"

  tunnel1_preshared_key = "${var.tunnel1_preshared_key}"
  tunnel2_preshared_key = "${var.tunnel2_preshared_key}"

  tags = merge(map(
     "Name", var.vpnconnection_name,
     "customer_gateway_id", var.customer_gateway_id,
     ),var.vpnconnection_tags)
}
