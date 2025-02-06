variable "budgets" {
  description = "A map of budgets to create"
  type = map(object({
    name                     = string
    budget_type              = string
    time_unit                = string
    limit_amount             = number
    limit_unit               = string
    cost_filter = map(list(string))
    cost_types = object({
      include_credit             = bool
      include_discount           = bool
      include_other_subscription = bool
      include_recurring          = bool
      include_refund             = bool
      include_subscription       = bool
      include_support            = bool
      include_tax                = bool
      include_upfront            = bool
      use_amortized              = bool
      use_blended                = bool
    })
    time_period_start        = string
    time_period_end          = string
    notification = list(object({
      comparison_operator = string
      notification_type   = string
      threshold           = number
      threshold_type      = string
      subscriber_email_addresses = list(string)
    }))
  }))
}