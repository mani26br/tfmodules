resource "aws_wafv2_regex_pattern_set" "wafv2_regex_pattern_set" {
  name        = var.wafv2_regex_pattern_set_name
  description = var.wafv2_regex_pattern_set_description
  scope       = var.wafv2_regex_pattern_set_scope

  dynamic "regular_expression" {
    for_each = var.wafv2_regex_string
    content {
      regex_string = lookup(regular_expression.value, "regex_string", null)
    }
  }

  tags = merge(map(
    "Name", var.wafv2_regex_pattern_set_name,
  ), var.wafv2_regex_pattern_set_tags)
}
