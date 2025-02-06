resource "aws_inspector2_organization_configuration" "inspector" {
  auto_enable {
    ec2    = true
    ecr    = true
    lambda = true
  }
}
