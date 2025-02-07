locals {
sg_ingress_http = {
  SG = {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  description = "NIH VPN"
  prefix_list_ids = [module.security_group_prefix.sg_prefix_list]
  }
}

sg_ingress_https = {
  SG = {
  from_port = 443
  to_port = 443
  protocol = "tcp"
  description = "NIH VPN"
  prefix_list_ids = [module.security_group_prefix.sg_prefix_list]
  }
}
}