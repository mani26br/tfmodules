output "sg_prefix_list" {
    description = "NIH Prefix List"
    value = aws_ec2_managed_prefix_list.cidrrange.id
}