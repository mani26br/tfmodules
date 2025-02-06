output "state_machine_name" {
    value = aws_sfn_state_machine.sfn_state_machine.name
}

output "state_machine_arn" {
    value = aws_sfn_state_machine.sfn_state_machine.role_arn
}

output "state_machine_tags" {
    value = aws_sfn_state_machine.sfn_state_machine.tags
}