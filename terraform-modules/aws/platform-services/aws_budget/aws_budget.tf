resource "aws_budgets_budget" "this" {
  for_each = var.budgets

  name                     = each.value.name
  budget_type              = each.value.budget_type
  time_unit                = each.value.time_unit
  limit_amount             = each.value.limit_amount
  limit_unit               = each.value.limit_unit
  

  dynamic "cost_filter" {
    for_each = each.value.cost_filter
    content {
      name = cost_filter.key
      values = cost_filter.value
    }
  }
  
  cost_types {
    include_credit             = each.value.cost_types.include_credit
    include_discount           = each.value.cost_types.include_discount
    include_other_subscription = each.value.cost_types.include_other_subscription
    include_recurring          = each.value.cost_types.include_recurring
    include_refund             = each.value.cost_types.include_refund
    include_subscription       = each.value.cost_types.include_subscription
    include_support            = each.value.cost_types.include_support
    include_tax                = each.value.cost_types.include_tax
    include_upfront            = each.value.cost_types.include_upfront
    use_amortized              = each.value.cost_types.use_amortized
    use_blended                = each.value.cost_types.use_blended
  }
  time_period_start        = each.value.time_period_start
  time_period_end          = each.value.time_period_end

  dynamic "notification" {
    for_each = each.value.notification
    content {
      comparison_operator = notification.value.comparison_operator
      notification_type   = notification.value.notification_type
      threshold           = notification.value.threshold
      threshold_type      = notification.value.threshold_type
      subscriber_email_addresses = notification.value.subscriber_email_addresses
    }
  }
}