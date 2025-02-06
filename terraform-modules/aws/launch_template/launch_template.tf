resource "aws_launch_template" "launch_template" {

  name = var.launch_template_name
  instance_type = var.launch_instance_type
  description = var.launch_template_description
  image_id = var.launch_template_image_id
  vpc_security_group_ids = var.launch_template_vpc_security_group_ids
  block_device_mappings {
  device_name = var.launch_template_block_device_name

     ebs {
        volume_size = var.launch_template_volume_size  #default is set to 20GB
        volume_type = var.launch_template_volume_type  #default is set to gp2
        delete_on_termination = var.launch_template_ebs_delete_on_termination #default is set to true
     }
   }
  user_data = var.launch_template_user_data
  key_name = var.launch_template_ssh_key
  update_default_version = true # Updates default_version to latest_version on terraform apply

  tag_specifications {
      resource_type = "instance"
      tags = {
        Name = var.launch_template_instance_name
      }
  }

}
