resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name        = var.subnet_group_name
  subnet_ids  = var.subnet_ids
  description = var.subnet_group_description
  tags        = merge(map(
                "Name", var.subnet_group_name
                ), var.tags)
}

# Description : Terraform module which creates cluster for Elasticache Redis.
resource "aws_elasticache_replication_group" "cluster" {
  engine                        = var.engine
  replication_group_id          = var.replication_group_id
  replication_group_description = var.replication_group_description
  engine_version                = var.engine_version
  port                          = var.port
  parameter_group_name          = var.parameter_group_name
  node_type                     = var.node_type
  automatic_failover_enabled    = var.automatic_failover_enabled
  multi_az_enabled              = var.multi_az_enabled
  subnet_group_name             = aws_elasticache_subnet_group.elasticache_subnet_group.name
  security_group_ids            = var.security_group_ids
  security_group_names          = var.security_group_names
  snapshot_arns                 = var.snapshot_arns
  snapshot_name                 = var.snapshot_name
  notification_topic_arn        = var.notification_topic_arn
  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit
  apply_immediately             = var.apply_immediately
  availability_zones            = var.availability_zones
  auto_minor_version_upgrade    = var.auto_minor_version_upgrade
  maintenance_window            = var.maintenance_window
  at_rest_encryption_enabled    = var.at_rest_encryption_enabled
  transit_encryption_enabled    = var.transit_encryption_enabled
  auth_token                    = var.auth_token
  kms_key_id                    = var.kms_key_id
  tags                          = merge(map(
                                  "Name", var.cluster_name
                                  ), var.tags)
  cluster_mode {
    replicas_per_node_group     = var.replicas_per_node_group #Replicas per Shard
    num_node_groups             = var.num_node_groups         #Number of Shards
  }

  dynamic "log_delivery_configuration" {
    for_each = "${var.log_delivery_configuration}"
    content {
      destination      = "${lookup(log_delivery_configuration.value, "destination", null)}"
      destination_type = "${lookup(log_delivery_configuration.value, "destination_type", null)}"
      log_format       = "${lookup(log_delivery_configuration.value, "log_format", null)}"
      log_type         = "${lookup(log_delivery_configuration.value, "log_type", null)}"
    }
  }
}
