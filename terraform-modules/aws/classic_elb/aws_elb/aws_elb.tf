resource "aws_elb" "elb" {
  name = var.elb_name
  name_prefix = var.elb_name_prefix

  dynamic "access_logs" {
    for_each = var.elb_access_logs

    content {
      bucket = lookup(access_logs.value, "bucket", null)
      bucket_prefix = lookup(access_logs.value, "bucket_prefix", null)
      interval = lookup(access_logs.value, "interval", null)
      enabled = lookup(access_logs.value, "enabled", null)
    }
  }

  availability_zones = var.elb_availability_zones
  security_groups = var.elb_security_groups
  subnets = var.elb_subnets
  instances = var.elb_instances
  internal = var.elb_internal

  dynamic "listener" {
    for_each = var.elb_listener

    content {
      instance_port = lookup(listener.value, "instance_port", null)
      instance_protocol = lookup(listener.value, "instance_protocol", null)
      lb_port = lookup(listener.value, "lb_port", null)
      lb_protocol = lookup(listener.value, "lb_protocol", null)
      ssl_certificate_id = lookup(listener.value, "ssl_certificate_id", null)
    }
  }

  dynamic "health_check" {
    for_each = var.elb_health_check

    content {
      healthy_threshold = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      target = lookup(health_check.value, "target", null)
      interval = lookup(health_check.value, "interval", null)
      timeout = lookup(health_check.value, "timeout", null)
    }
  }

  cross_zone_load_balancing = var.elb_cross_zone_load_balancing
  idle_timeout = var.elb_idle_timeout
  connection_draining = var.elb_connection_draining
  connection_draining_timeout = var.elb_connection_draining_timeout
  tags = merge(map(
  "Name", var.elb_name,
  ), var.elb_tags)
}
