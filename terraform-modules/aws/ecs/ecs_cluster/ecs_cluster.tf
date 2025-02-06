resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
  capacity_providers = var.ecs_cluster_providers
  setting {
    name  = "containerInsights"
    value = var.ecs_insight_value
  }
  tags = merge(map(
     "Name", var.ecs_cluster_name,
     ),var.ecs_cluster_tags)
}
