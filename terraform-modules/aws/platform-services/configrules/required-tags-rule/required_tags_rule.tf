resource "aws_config_config_rule" "required-tags" {
  count       = var.check_required_tags ? 1 : 0
  name        = "required-tags"
  description = "Checks if resources are deployed with configured tags."

  scope {
    compliance_resource_types = ["AWS::ACM::Certificate", "AWS::AutoScaling::AutoScalingGroup", "AWS::CloudFormation::Stack", "AWS::DynamoDB::Table", "AWS::EC2::CustomerGateway", "AWS::EC2::Instance", "AWS::EC2::InternetGateway", "AWS::EC2::NetworkAcl", "AWS::EC2::RouteTable", "AWS::EC2::SecurityGroup", "AWS::EC2::Subnet", "AWS::EC2::Volume", "AWS::EC2::VPC", "AWS::EC2::VPNConnection", "AWS::EC2::VPNGateway", "AWS::ElasticLoadBalancing::LoadBalancer", "AWS::ElasticLoadBalancingV2::LoadBalancer", "AWS::RDS::DBInstance", "AWS::RDS::DBSecurityGroup", "AWS::RDS::DBSnapshot", "AWS::RDS::DBSubnetGroup", "AWS::RDS::EventSubscription", "AWS::S3::Bucket"]
  }

  input_parameters = jsonencode({
    tag1Key = "org",
    tag2Key = "program",
    tag3Key = "project",
    tag4Key = "access-team",
    tag5Key = "environment",
    tag6Key = "Name"
  })

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }
}
