output "vpnconnection_vpn_gateway_id" {
  value = aws_vpn_connection.vpnconnection.vpn_gateway_id
}

output "vpnconnection_customer_gateway_id" {
  value = aws_vpn_connection.vpnconnection.customer_gateway_id
}

output "vpnconnection_transit_gateway_id" {
  value = aws_vpn_connection.vpnconnection.transit_gateway_id
}

output "vpnconnection_tunnel1_preshared_key" {
  value = aws_vpn_connection.vpnconnection.tunnel1_preshared_key
}

output "vpnconnection_tunnel2_preshared_key" {
  value = aws_vpn_connection.vpnconnection.tunnel2_preshared_key 
}

output "vpn_connection_id" {
  value = aws_vpn_connection.vpnconnection.id
}


