output "elasticsearch_domain_name" {
  value = aws_elasticsearch_domain.elasticsearch_domain.domain_name
}

output "elasticsearch_domain_arn" {
  value = aws_elasticsearch_domain.elasticsearch_domain.arn
}

output "elasticsearch_domain_id" {
  value = aws_elasticsearch_domain.elasticsearch_domain.domain_id
}

output "elasticsearch_domain_endpoint" {
  value = aws_elasticsearch_domain.elasticsearch_domain.endpoint
}

output "elasticsearch_domain_kibana_endpoint" {
  value = aws_elasticsearch_domain.elasticsearch_domain.kibana_endpoint
}
