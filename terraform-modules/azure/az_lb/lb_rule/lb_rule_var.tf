#Specifies the name of the LB Rule.
variable "lb_rule_name" {
  type = string
  default = ""
}
#The ID of the Load Balancer in which to create the Rule.
variable "lb_rule_loadbalancer_id" {
  type = string
  default = ""
}
#The transport protocol for the external endpoint. Possible values are Tcp, Udp or All.
variable "lb_rule_protocol" {
  type = string
  default = ""
}
# The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. 
variable "lb_rule_frontend_port" {
  type = string
  default = ""
}
# The port used for internal connections on the endpoint.
variable "lb_rule_backend_port" {
  type = string
  default = ""
}
#The name of the frontend IP configuration to which the rule is associated.
variable "lb_rule_frontend_ip_config_name" {
  type = string
  default = ""
}
# floating IP is reassigned to a secondary server in case the primary server fails.
variable "lb_rule_enable_floating_ip" {
  type = string
  default = "false"
}
#Is snat enabled for this Load Balancer Rule
variable "lb_rule_disable_outbound_snat" {
  type = string
  default = "false"
}
#A reference to a Probe used by this Load Balancing Rule.
variable "lb_rule_probe_id" {
  type = string
  default = ""
}
# A list of reference to a Backend Address Pool over which this Load Balancing Rule operates
variable "lb_rule_backend_address_pool_ids" {
  type = list(any)
  default =[]
}