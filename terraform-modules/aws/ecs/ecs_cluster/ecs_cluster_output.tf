output "ecs_cluster_id" {
  description = "ECS cluster ID"
  value = aws_ecs_cluster.ecs_cluster.id
}

output "ecs_cluster_arn" {
  description = "ECS cluster ARN output"
  value = aws_ecs_cluster.ecs_cluster.arn
}
