output "scheduler_schedule_id" {
  description = "The ID (name) of the EventBridge scheduler schedule."
  value       = aws_scheduler_schedule.schedule.id
}

output "scheduler_schedule_arn" {
  description = "The ARN of the EventBridge scheduler schedule."
  value       = aws_scheduler_schedule.schedule.arn
}
