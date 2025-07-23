
resource "aws_iam_role" "aggregator" {
  count                = var.aggregate_organization ? 1 : 0
  name                 = "${var.config_name}-aggregator-role"
  assume_role_policy   = data.aws_iam_policy_document.aws_config_aggregator_role_policy.json
  tags   = merge(tomap({
  "Name" = "${var.config_name}-aggregator-role",
  }), var.tags)
}

resource "aws_iam_role_policy_attachment" "aggregator" {
  count      = var.aggregate_organization ? 1 : 0
  role       = aws_iam_role.aggregator[0].name
  policy_arn = format("arn:%s:iam::aws:policy/service-role/AWSConfigRoleForOrganizations", data.aws_partition.current.partition)
}

#
# Configuration Aggregator
#

resource "aws_config_configuration_aggregator" "organization" {
  count      = var.aggregate_organization ? 1 : 0
  depends_on = [aws_iam_role_policy_attachment.aggregator]
  name       = var.config_aggregator_name

  organization_aggregation_source {
    all_regions = true
    role_arn    = aws_iam_role.aggregator[0].arn
  }

  tags   = merge(tomap({
  "Name" = var.config_aggregator_name,
  }), var.tags)
}
