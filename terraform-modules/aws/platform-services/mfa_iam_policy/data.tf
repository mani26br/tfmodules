data "aws_iam_policy_document" "NCATSMFAEnforcementPolicy" {

  statement {
    sid = "AllowListUsers"
    effect = "Allow"
    actions = [
      "iam:ListUsers"
    ]
    resources = [
      "arn:aws:iam::*:user/"
    ]
  }
  statement {
    sid = "AlloUsersToChangePassword"
    effect = "Allow"
    actions = [
      "iam:ChangePassword"
    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}"
    ]
  }
  statement {
    sid = "AccountPasswordPolicy"
    effect = "Allow"
    actions = [
      "iam:GetAccountPasswordPolicy"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "AllowMFAHandling"
    effect = "Allow"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices"
    ]
    resources = [
      "arn:aws:iam::*:mfa/*",
      "arn:aws:iam::*:user/&{aws:username}"
    ]
  }
  statement {
    sid = "BlockEverythingUnlessSignedInWithMFA"
    effect = "Deny"
    not_actions = [
      "iam:ChangePassword",
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices"
    ]
    resources = [
      "*"
    ]
    condition {
      test = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values = [
        "false",
      ]
    }
  }
}
