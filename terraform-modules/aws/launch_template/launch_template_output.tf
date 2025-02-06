output "name" {
  value = aws_launch_template.launch_template.name
}

output "template_id" {
  value = aws_launch_template.launch_template.id
}

output "template_arn" {
  value = aws_launch_template.launch_template.arn
}

output "latest_version" {
  value = aws_launch_template.launch_template.latest_version
}

output "ami_image_id" {
  value = aws_launch_template.launch_template.image_id
}
