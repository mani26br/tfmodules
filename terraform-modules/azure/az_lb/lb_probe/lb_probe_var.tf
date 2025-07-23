#Specifies the name of the Probe.
variable "lb_probe_name" {
  type = string
  default = ""
}
#The ID of the LoadBalancer in which to create the NAT Rule.
variable "lb_probe_loadbalancer_id" {
  type = string
  default = ""
}
#Port on which the Probe queries the backend endpoint.
variable "lb_probe_port" {
  type = string
  default = ""
}