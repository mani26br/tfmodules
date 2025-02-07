locals {
sg_ingress_http = {
  SG = {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  description = "NIH VPN"
  prefix_list_ids = [module.security_group_prefix.sg_prefix_list]
  }
}

sg_ingress_https = {
  SG = {
  from_port = 443
  to_port = 443
  protocol = "tcp"
  description = "NIH VPN"
  prefix_list_ids = [module.security_group_prefix.sg_prefix_list]
  }
}

sg_ingress_ssh = {
  SG = {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  description = "NIH VPN"
  prefix_list_ids = [module.security_group_prefix.sg_prefix_list]
  }
}

sg_ingress_rdp = {
  SG = {
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  description = "NIH VPN"
  prefix_list_ids = [module.security_group_prefix.sg_prefix_list]
  }
 }
}

###Budget_Reports###

locals {
 budgets_by_program = {
    budget1 = {
        name         = "AWS-PROD-Budget-ByProgram-gard"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 150
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$gard"]
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
    budget2 = {
        name         = "AWS-PROD-Budget-ByProgram-management-services"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 500
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$management-services"]
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
    budget3 = {
        name         = "AWS-PROD-Budget-ByProgram-netapp"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 2400
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$netapp"]
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
    budget4 = {
        name         = "AWS-PROD-Budget-ByProgram-netapp-ontap-cloud"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 6400
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$netapp-ontap-cloud"]
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
    budget5 = {
        name         = "AWS-PROD-Budget-ByProgram-palantir"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 10
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$palantir"]
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
    budget6 = {
        name         = "AWS-PROD-Budget-ByProgram-polus"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 60
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$polus"]
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
    budget7 = {
        name         = "AWS-PROD-Budget-ByProgram-servicenow"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 1000
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$management-servicenow"]
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

###CloudWatch alerts###

locals {
  CloudTrailMetrics = {
    "IamPolicyChanges" = "{($.eventSource=iam.amazonaws.com) && (($.eventName=DeleteGroupPolicy) || ($.eventName=DeleteRolePolicy) || ($.eventName=DeleteUserPolicy) || ($.eventName=PutGroupPolicy) || ($.eventName=PutRolePolicy) || ($.eventName=PutUserPolicy) || ($.eventName=CreatePolicy) || ($.eventName=DeletePolicy) || ($.eventName=CreatePolicyVersion) || ($.eventName=DeletePolicyVersion) || ($.eventName=AttachRolePolicy) || ($.eventName=DetachRolePolicy) || ($.eventName=AttachUserPolicy) || ($.eventName=DetachUserPolicy) || ($.eventName=AttachGroupPolicy) || ($.eventName=DetachGroupPolicy))}"
  }
}