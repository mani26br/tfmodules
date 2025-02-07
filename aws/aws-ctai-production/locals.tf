###Budget_Reports###

locals {
  budgets_by_program = {
    budget1 = {
        name         = "AWS-CTAI-PROD-Budget-ByProgram-ctsa/clic"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 600
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$ctsa/clic"]
        }
        cost_types = {
          include_credit             = true
          include_discount           = true
          include_other_subscription = true
          include_recurring          = true
          include_refund             = true
          include_subscription       = true
          include_support            = true
          include_tax                = true
          include_upfront            = true
          use_amortized              = false
          use_blended                = false
        }
        time_period_start = null #"2024-08-01_00:00"
        time_period_end   = null #"0000-00-00_00:00"
        notification = [
          {
            comparison_operator         = "GREATER_THAN"
            notification_type           = "ACTUAL"
            threshold                   = 80
            threshold_type              = "PERCENTAGE"
            subscriber_email_addresses = ["NCATSCPE@mail.nih.gov"]
          },
          {
            comparison_operator         = "GREATER_THAN"
            notification_type           = "ACTUAL"
            threshold                   = 100
            threshold_type              = "PERCENTAGE"
            subscriber_email_addresses = ["NCATSCPE@mail.nih.gov"]
          }
        ]
      }
  }
}