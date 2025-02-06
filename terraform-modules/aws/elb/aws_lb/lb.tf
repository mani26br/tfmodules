resource "aws_lb" "lb" {
  name = var.lb_name
  name_prefix = var.lb_name_prefix
  internal = var.lb_internal
  load_balancer_type = var.lb_load_balancer_type
  security_groups = var.lb_security_groups

  dynamic "access_logs" {
    for_each = length(keys(var.lb_access_logs)) == 0 ? [] : [var.lb_access_logs]

    content {
      bucket = lookup(access_logs.value, "bucket", null)
      prefix = lookup(access_logs.value, "prefix", null)
      enabled = lookup(access_logs.value, "enabled", false)
    }
  }

  subnets = var.lb_subnets

  dynamic "subnet_mapping" {
    for_each = var.lb_subnet_mapping

    content {
      subnet_id = subnet_mapping.value.subnet_id
      allocation_id = lookup(subnet_mapping.value, "allocation_id", null)
    }
  }

  idle_timeout = var.lb_idle_timeout
  enable_deletion_protection = var.lb_enable_deletion_protection
  enable_cross_zone_load_balancing = var.lb_enable_cross_zone_load_balancing
  enable_http2 = var.lb_enable_http2
  ip_address_type = var.lb_ip_address_type
  tags = merge(map(
  "Name", var.lb_name,
  ), var.lb_tags)
}

// Associate AWS WAF Web ACL with ALB if WAF ACL is created
resource "aws_wafv2_web_acl_association" "lb_waf_acl_association" {
  count      = var.create_waf_acl ? 1 : 0
  resource_arn = aws_lb.lb.arn
  web_acl_arn = aws_waf_web_acl.lb_waf_acl.arn
}
