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
        name         = "AWS-CI-Budget-ByProgram-activ"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 100
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$activ"]
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
        name         = "AWS-CI-Budget-ByProgram-agm"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 250
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$agm"]
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
        name         = "AWS-CI-Budget-ByProgram-aspire"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 1000
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$aspire"]
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
        name         = "AWS-CI-Budget-ByProgram-catalog"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 10
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$catalog"]
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
        name         = "AWS-CI-Budget-ByProgram-cpe"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 100
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$cpe"]
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
        name         = "AWS-CI-Budget-ByProgram-gard"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 2000
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
    budget7 = {
        name         = "AWS-CI-Budget-ByProgram-management-services"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 4000
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
    budget8 = {
        name         = "AWS-CI-Budget-ByProgram-metadata"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 50
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$metadata"]
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
    budget9 = {
        name         = "AWS-CI-Budget-ByProgram-polus"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 9000
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
    budget10 = {
        name         = "AWS-CI-Budget-ByProgram-project-tracking"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 80
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$project-tracking"]
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
    budget11 = {
        name         = "AWS-CI-Budget-ByProgram-rsc"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 100
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$rsc"]
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
    budget12 = {
        name         = "AWS-CI-Budget-ByProgram-smartcart"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 50
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$smartcart"]
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
    budget13 = {
        name         = "AWS-CI-Budget-ByProgram-snow"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 140
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$snow"]
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
    budget14 = {
        name         = "AWS-CI-Budget-ByProgram-umrs"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 50
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$umrs"]
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
    budget15 = {
        name         = "AWS-CI-Budget-ByProgram-una"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 150
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$una"]
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

locals {
  MaintenanceWindow_resource_group = {
    "InstanceId" = ["{{RESOURCE_ID}}"]
  }
}

###CloudWatch alerts###

locals {
  CloudTrailMetrics = {
    "KMSKeyDeletion" =  "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
    "AWSConfigChanges" = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
    "ConsoleLoginFailed" = "{($.eventName=ConsoleLogin) && ($.errorMessage=\"Failed authentication\")}"
    "RootAccountUsage" = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
  }
}