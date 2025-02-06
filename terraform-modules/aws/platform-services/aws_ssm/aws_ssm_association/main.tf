resource "aws_ssm_association" "example" {
  association_name = var.association_name
  name = var.name
  parameters = var.parameters
  
  apply_only_at_cron_interval = true
  schedule_expression = var.schedule_expression 
  
  targets {
    key = var.key
    values = var.values
  }
  
  output_location {
	s3_bucket_name = var.s3_bucket_name
  s3_key_prefix = var.s3_key_prefix
  }
}



