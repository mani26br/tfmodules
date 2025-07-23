resource "aws_vpc_security_group_ingress_rule" "rule" {
  count = var.sg_ingress_rule_create ? 1:0
  security_group_id = var.sg_ingress_rule_id

  from_port = var.sg_ingress_rule_from_port   
  ip_protocol = var.sg_ingress_rule_ip_protocol
  to_port = var.sg_ingress_rule_to_port 
  referenced_security_group_id = var.referenced_sg_ingress_rule_id
}