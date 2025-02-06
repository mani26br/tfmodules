resource "aws_ecs_task_definition" "ecs-task-definition" {
  family                   = var.task_definition_name
  container_definitions    = file(var.task_def_container_definitions)
  execution_role_arn       = var.task_def_execution_role_arn
  task_role_arn            = var.task_def_task_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  volume {
     name      = var.fargate_storage
  }

  tags = merge(map(
     "Name", var.task_definition_name,
     ),var.ecs_task_definition_tags)
}
