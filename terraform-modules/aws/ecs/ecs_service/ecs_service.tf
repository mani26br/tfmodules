resource "aws_ecs_service" "ecs-service" {
  name                  = var.ecs_service_name
  cluster               = var.ecs_service_cluster
  task_definition       = var.ecs_task_definition_arn
  desired_count         = var.ecs_service_desired_count
  launch_type           = "FARGATE"
  health_check_grace_period_seconds = var.ecs_service_health_chk_grace_period
  platform_version      = var.ecs_platform_version
  scheduling_strategy   = "REPLICA"
  network_configuration {
     subnets            =  [var.ecs_service_subnet_ids]
     security_groups    = [var.ecs_service_sg]
  }
  load_balancer {
    target_group_arn = var.ecs_service_lb_target_group_arn
    container_name   = var.ecs_service_container_name
    container_port   = var.ecs_service_container_port
  }
  deployment_minimum_healthy_percent = var.ecs_service_minimum_healthy_percent
  deployment_maximum_percent = var.ecs_service_maximum_percent
  enable_ecs_managed_tags = var.ecs_service_managed_tags
  tags = merge(map(
     "Name", var.ecs_service_name,
     ),var.ecs_service_tags)
}
