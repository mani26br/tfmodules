output "aws_ecs_service_name" {
  description = "Name of the ECS Service"
  value = aws_ecs_service.ecs-service.name
}

output "aws_ecs_service_arn" {
  description = "ARN of the ECS Service"
  value = aws_ecs_service.ecs-service.id
}

output "aws_ecs_service_desired_count" {
  description = "The number of instances of the task definition"
  value = aws_ecs_service.ecs-service.desired_count
}
