data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "inline_lambda_policy" {
  statement {
    actions   = ["ec2:TerminateInstances", "ec2:StopInstances", "ec2:DescribeInstances"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["lambda:InvokeFunction"]
    effect    = "Allow"
    resources = ["${aws_lambda_function.instance_termination_lambda.arn}"]
  }

  statement {
    actions   = ["ecs:Describe*", "ecs:List*", "ecs:UpdateContainerInstanceStatus"]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    effect    = "Allow"
    resources = [aws_cloudwatch_log_group.instance_termination_lambda_log_group.arn]
  }
}
####
data "aws_iam_policy_document" "lambda_execution_policy" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    effect    = "Allow"
    resources = ["${aws_lambda_function.instance_termination_lambda.arn}"]
  }
}
# Define an IAM policy document for CloudWatch Events permissions
data "aws_iam_policy_document" "cloudwatch_events_policy" {
  statement {
    actions   = ["events:PutTargets", "events:PutRule", "events:DescribeRule"]
    effect    = "Allow"
    resources = ["*"]  # Adjust this to limit to specific resources if needed
  }
}
###

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_ec2_termination_policy" {
  
  statement {
    actions   = ["ec2:DescribeInstances"]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions   = ["ec2:TerminateInstances"]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    effect    = "Allow"
    resources = [aws_cloudwatch_log_group.instance_termination_lambda_log_group.arn]
  }
  statement {
    actions   = ["sns:Publish"]
    effect    = "Allow"
    resources = ["*"]
  }

}

data "aws_iam_policy_document" "s3_decommission_policy" {
   statement {
     actions = [
       "s3:*",
       "s3-object-lambda:*"
     ]
     effect   = "Allow"
     resources = ["arn:aws:s3:::*"]
   }
}

# RDS Decommission Policy
data "aws_iam_policy_document" "rds_decommission_policy" {
  statement {
    actions   = [
      "rds:DescribeDBInstances",
      "rds:DeleteDBInstance",
      "rds:ListTagsForResource"
    ]
    effect    = "Allow"
    resources = ["*"]  # Adjust this to limit to specific resources if needed
  }
  # Add more statements if needed for other RDS-related actions
}

# VPC Decommission Policy
data "aws_iam_policy_document" "vpc_decommission_policy" {
  statement {
    actions   = [
      "ec2:DescribeVpcs",
      "ec2:DeleteVpc",
    ]
    effect    = "Allow"
    resources = ["*"] # Adjust this to limit to specific resources if needed
  }
}


# ELB Decommission Policy
data "aws_iam_policy_document" "elb_decommission_policy" {
  statement {
    actions   = [
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DeleteLoadBalancer",
    ]
    effect    = "Allow"
    resources = ["*"]  # Adjust this to limit to specific resources if needed
  }
}

# Elastic IPs Policy
data "aws_iam_policy_document" "elastic_ips_policy" {
  statement {
    actions   = [
      "ec2:DescribeAddresses",
      "ec2:ReleaseAddress",
    ]
    effect    = "Allow"
    resources = ["*"]  # Adjust this to limit to specific resources if needed
  }
}
