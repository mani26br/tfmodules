data "local_file" "input" {
  filename = var.state_machine_definition_json_file
}

data "template_file" "input" {
  template = data.local_file.input.content
  vars = {
  }
}

resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = var.state_machine_name
  role_arn = var.state_machine_role
  definition = data.template_file.input.rendered
  tags = var.state_machine_tags
}
