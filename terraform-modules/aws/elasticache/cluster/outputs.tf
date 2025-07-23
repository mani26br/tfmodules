output "id" {
  value       = aws_elasticache_replication_group.cluster.id
  description = "Redis cluster id."
}
 
output "arn" {
  value       = aws_elasticache_replication_group.cluster.arn
  description = "Redis cluster ARN."
}

output "engine_version_actual" {
  value       = aws_elasticache_replication_group.cluster.engine_version_actual
  description = "Redis cluster running version."
}

output "cluster_enabled" {
  value       = aws_elasticache_replication_group.cluster.cluster_enabled
  description = "Indicates if cluster mode is enabled."
}

output "port" {
  value       = var.port
  description = "Redis port."
}

output "redis_endpoint" {
  value       = aws_elasticache_replication_group.cluster.configuration_endpoint_address
  description = "Redis endpoint address."
}

output "member_clusters" {
  value       = aws_elasticache_replication_group.cluster.member_clusters
  description = "The identifiers of all the nodes that are part of this replication group."
}

output "tags" {
  value       = aws_elasticache_replication_group.cluster.tags_all
  description = "A mapping of tags to assign to the resource."
}