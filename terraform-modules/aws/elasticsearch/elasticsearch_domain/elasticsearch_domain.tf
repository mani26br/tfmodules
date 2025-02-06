resource "aws_elasticsearch_domain" "elasticsearch_domain" {

  domain_name           = var.elasticsearch_domain_name
  elasticsearch_version = var.elasticsearch_version
  access_policies       = var.elasticsearch_access_policies

  cluster_config {
    instance_type  = var.elasticsearch_instance_type
    instance_count = var.elasticsearch_instance_count
    dedicated_master_enabled = var.elasticsearch_dedicated_master
    dedicated_master_type    = var.elasticsearch_master_type
    dedicated_master_count   = var.elasticsearch_master_count
    zone_awareness_enabled   = var.elasticsearch_zone_awareness_enabled
    zone_awareness_config {
       availability_zone_count = var.elasticsearch_availability_zone_count
    }
  }

  dynamic "vpc_options" {
     for_each = var.elasticsearch_vpc_options
     content {
        subnet_ids         = lookup(vpc_options.value, "subnet_ids", null)
        security_group_ids = lookup(vpc_options.value, "security_group_ids", null)
     }
  }

  ebs_options {
     ebs_enabled = true
     volume_type = "gp2"
     volume_size = var.elasticsearch_ebs_volume_size
  }

  snapshot_options {
    automated_snapshot_start_hour = var.elasticsearch_snapshot_start_hour
  }

  encrypt_at_rest {
    enabled = var.elasticsearch_encrypt_at_rest_enabled
  }

  node_to_node_encryption {
    enabled = var.elasticsearch_node_to_node_encryption
  }

  domain_endpoint_options {
    enforce_https = var.elasticsearch_enforce_https
    tls_security_policy   = var.elasticsearch_tls_security_policy
  }

  advanced_security_options {
     enabled = var.elasticsearch_advanced_security_options_enabled
     internal_user_database_enabled = var.elasticsearch_internal_user_database_enabled
     master_user_options {
        master_user_name     = var.elasticsearch_master_user_name
        master_user_password = var.elasticsearch_master_user_password
     }
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.elasticsearch_aws_cloudwatch_log_group_arn
    log_type                 = "INDEX_SLOW_LOGS"
    enabled                  = var.elasticsearch_index_slow_logs_enabled
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.elasticsearch_aws_cloudwatch_log_group_arn
    log_type                 = "SEARCH_SLOW_LOGS"
    enabled                  = var.elasticsearch_search_slow_logs_enabled
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.elasticsearch_aws_cloudwatch_log_group_arn
    log_type                 = "ES_APPLICATION_LOGS"
    enabled                  = var.elasticsearch_es_application_logs_enabled
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.elasticsearch_aws_cloudwatch_log_group_arn
    log_type                 = "AUDIT_LOGS"
    enabled                  = var.elasticsearch_audit_logs_enabled
  }

  tags = merge(map(
  "Name", var.elasticsearch_domain_name,
  ), var.elasticsearch_domain_tags)

}
