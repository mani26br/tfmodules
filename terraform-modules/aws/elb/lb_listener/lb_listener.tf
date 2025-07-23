resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = var.lb_listener_load_balancer_arn
  port = var.lb_listener_port
  protocol = var.lb_listener_protocol
  ssl_policy = var.lb_listener_ssl_policy
  certificate_arn = var.lb_listener_certificate_arn
  tags = merge(tomap({
  "Name" = var.lb_listener_load_balancer_arn,
  }), var.lb_listener_tags)

  dynamic "default_action" {
      for_each = length(keys(var.lb_listener_default_action)) == 0 ? [] : [var.lb_listener_default_action]


    content {
      type = lookup(default_action.value, "type", "forward")
      target_group_arn = lookup(default_action.value, "target_group_arn", "")

      #added redirect feature
      dynamic "redirect" {
        for_each = length(keys(lookup(default_action.value, "redirect", {}))) == 0 ? [] : [lookup(default_action.value, "redirect", {})]

        content {
          host = lookup(redirect.value, "type", null)
          path = lookup(redirect.value, "path", null)
          port = lookup(redirect.value, "port", null)
          protocol = lookup(redirect.value, "protocol", null)
          query = lookup(redirect.value, "query", null)
          status_code = redirect.value["status_code"]
        }
      }
    }
  }
}
