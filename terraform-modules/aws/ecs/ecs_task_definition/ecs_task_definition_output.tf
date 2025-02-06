output "ecs_task_definition_arn" {
  description = "ARN of the Task Definition"
  value = aws_ecs_task_definition.ecs-task-definition.arn
}

output "ecs_task_definition_family" {
  description = "The family of the Task Definition"
  value = aws_ecs_task_definition.ecs-task-definition.family
}

output "ecs_task_definition_revision" {
  description = "revision number the Task Definition"
  value = aws_ecs_task_definition.ecs-task-definition.revision
}
