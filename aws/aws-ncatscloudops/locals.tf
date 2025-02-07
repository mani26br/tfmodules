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

  budgets_by_program = {
    budget1 = {
        name         = "AWS-NCATS-Cloud-Ops-Budget-ByProgram-ncats-cloud-ops"
        budget_type  = "COST"
        time_unit    = "MONTHLY"
        limit_amount = 2000
        limit_unit   = "USD"
        cost_filter = {
          "TagKeyValue" = ["user:program$ncats-cloud-ops"]
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
  ec2_eic_arns = {
    for key, value in var.EIC_vpc_ids : key => module.EC2_EIC[key].arn
  }
  ec2_eic_arn_list = values(local.ec2_eic_arns)
}