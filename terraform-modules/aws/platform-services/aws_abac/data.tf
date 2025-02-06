
data "aws_iam_policy_document" "ec2_abac_policy" {
  statement {
    sid    = "PermissionsToManageEc2Instances"
    effect = "Allow"
    actions   = ["ec2:RebootInstances", "ec2:StartInstances", "ec2:StopInstances"]
    resources = ["arn:aws:ec2:*:*:instance/*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/project"
      values   = ["$${aws:PrincipalTag/project}"]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["project", "access-team", "org", "program", "Name", "environment"]
    }

    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/project"
      values   = ["$${aws:PrincipalTag/project}"]
    }

    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
    }
  }

  statement {
    sid    = "DescribeAllEC2Instances"
    effect = "Allow"
    actions   = ["ec2:DescribeInstances*"]
    resources = ["*"]
  }
}

#####S3 Bucket/object s3_abac_policy  Document##

data "aws_iam_policy_document" "s3_abac_policy" {
  
  statement {
      sid  =  "PermissionsToManageS3"
      effect = "Allow"
      actions  =  ["s3:GetObject", "s3:PutObject", "s3:ListBucket" ]
      resources = ["arn:aws:s3:::*/*"]

      condition {
      test     = "StringEquals"
      variable = "s3:ExistingObjectTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
      } 
      condition {
      test     = "StringEquals"
      variable = "s3:ExistingObjectTag/project"
      values   = ["$${aws:PrincipalTag/project}"]
      } 

      condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["project", "access-team", "org", "program", "Name", "environment"]
      } 
    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/project"
      values   = ["$${aws:PrincipalTag/project}"]
    }

    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
    }
  } 
  
    statement {
      sid =  "DescribeAllS3Buckets"
      effect = "Allow"
      actions =  ["s3:ListAllMyBuckets"]
      resources =  ["*"]
    }
}


#####SecretManager abac_policy Document##

data "aws_iam_policy_document" "secrets_manager_abac_policy" {
  
  statement {
      sid  =  "PermissionsToManageSecrets"
      effect = "Allow"
      actions  =  ["secretsmanager:GetSecretValue","secretsmanager:DescribeSecret"]
      resources = ["arn:aws:secretsmanager:*:*:secret:*"]

      condition {
      test     = "StringEquals"
      variable = "secretsmanager:ResourceTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
      } 
      condition {
      test     = "StringEquals"
      variable = "secretsmanager:ResourceTag/Project"
      values   = ["$${aws:PrincipalTag/Project}"]
      } 

      condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["project", "access-team", "org", "program", "Name", "environment"]
      } 
    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/roject"
      values   = ["$${aws:PrincipalTag/project}"]
    }

    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
    }
  } 
  
    statement {
      sid =  "DescribeAllS3Buckets"
      effect = "Allow"
      actions =  ["secretsmanager:ListSecrets"]
      resources =  ["*"]
    }
}

##### SNS abac_policy Document##

data "aws_iam_policy_document" "sns_abac_policy" {
  
  statement {
      sid  =  "PermissionsToManageSNS"
      effect = "Allow"
      actions  =  ["sns:Publish","sns:Subscribe"]
      resources = ["arn:aws:sns:*:*:*","arn:aws:sns:*:*:*"]

      condition {
      test     = "StringEquals"
      variable = "sns:ResourceTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
      } 
      condition {
      test     = "StringEquals"
      variable = "sns:ResourceTag/project"
      values   = ["$${aws:PrincipalTag/project}"]
      } 

      condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["project", "access-team", "org", "program", "Name", "environment"]
      } 
    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/project"
      values   = ["$${aws:PrincipalTag/project}"]
    }

    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
    }
  } 
  
    statement {
      sid =  "ListAllSNSTopics"
      effect = "Allow"
      actions =  ["sns:ListTopics"]
      resources =  ["*"]
    }
}

##### SQS abac_policy Document ##

data "aws_iam_policy_document" "sqs_abac_policy" {
  
  statement {
      sid  =  "PermissionsToManageSQS"
      effect = "Allow"
      actions  =  ["sqs:SendMessage", "sqs:ReceiveMessage", "sqs:DeleteMessage"]
      resources = ["arn:aws:sqs:*:*:*"]

      condition {
      test     = "StringEquals"
      variable = "sqs:ResourceTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
      } 
      condition {
      test     = "StringEquals"
      variable = "sqs:ResourceTag/project"
      values   = ["$${aws:PrincipalTag/project}"]
      } 

      condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["project", "access-team", "org", "program", "Name", "environment"]
      } 
    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/project"
      values   = ["$${aws:PrincipalTag/project}"]
    }

    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/access-team"
      values   = ["$${aws:PrincipalTag/access-team}"]
    }
  } 
  
    statement {
      sid =  "ListAllSQSQueues"
      effect = "Allow"
      actions =  ["sqs:ListQueues"]
      resources =  ["*"]
    }
}
