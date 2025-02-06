resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.ec2_profile_name
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = var.iam_role_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = merge(tomap({
  "Name" = var.iam_role_name,
  }), var.role_tags)
}