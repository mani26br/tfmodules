variable "cluster_name" {
  default     = ""
  description = "The name of the cache cluster"
}

variable "replication_group_id" {
  default     = "default"
  description = "The replication group identifier This parameter is stored as a lowercase string."
}

variable "replication_group_description" {
  default     = ""
  description = "Description for the replication group."
}

variable "subnet_group_name" {
  default     = ""
  description = "The name of the cache subnet group"
}

variable "subnet_ids" {
  default     = []
  description = "List of VPC Subnet IDs for the cache subnet group."
}

variable "subnet_group_description" {
  type        = string
  default     = "Managed by Terraform"
  description = "Description for the cache subnet group. Defaults to `Managed by Terraform`."
}

variable "engine" {
  default     = ""
  description = "The name of the cache engine to be used for the clusters in this replication group. e.g. redis."
}

variable "engine_version" {
  default     = ""
  description = "The version number of the cache engine to be used for the cache clusters in this replication group."
}

variable "port" {
  default     = ""
  description = "the port number on which each of the cache nodes will accept connections."
}

variable "node_type" {
  default     = "cache.t2.small"
  description = "The compute and memory capacity of the nodes in the node group."
}

variable "automatic_failover_enabled" {
  default     = false
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to false."
}

variable "multi_az_enabled" {
  default     = false
  description = "Specifies whether to enable Multi-AZ Support for the replication group. If true, automatic_failover_enabled must also be enabled. Defaults to false."
}

variable "security_group_ids" {
  default     = []
  description = "One or more VPC security groups associated with the cache cluster."
}

variable "security_group_names" {
  default     = null
  description = "A list of cache security group names to associate with this replication group."
}

variable "snapshot_arns" {
  default     = null
  description = "A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3."
}

variable "snapshot_name" {
  default     = ""
  description = "The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource."
}

variable "snapshot_window" {
  default     = null
  description = "(Redis only) The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period."
}

variable "snapshot_retention_limit" {
  default     = "0"
  description = "(Redis only) The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes."
}

variable "notification_topic_arn" {
  default     = ""
  description = "An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to."
}

variable "apply_immediately" {
  default     = true
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
}

variable "availability_zones" {
  type        = any
  description = "A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important."
}

variable "number_cache_clusters" {
  type        = string
  default     = ""
  description = "(Required for Cluster Mode Disabled) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications."
}

variable "auto_minor_version_upgrade" {
  default     = true
  description = "Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true."
}

variable "maintenance_window" {
  default     = "sun:05:00-sun:06:00"
  description = "Maintenance window."
}

variable "at_rest_encryption_enabled" {
  default     = false
  description = "Enable encryption at rest."
}

variable "transit_encryption_enabled" {
  default     = false
  description = "Whether to enable encryption in transit."
}

variable "auth_token" {
  default     = null
  description = "The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true."
}

variable "replicas_per_node_group" {
  default     = ""
  description = "Replicas per Shard."
}

variable "num_node_groups" {
  default     = ""
  description = "Number of Shards (nodes)."
}

variable "kms_key_id" {
  default     = ""
  description = "The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true."
}

variable "parameter_group_name" {
  type        = string
  default     = "default.redis6.x.cluster.on"
  description = "The name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags."
}

variable "log_delivery_configuration" {
  type        = list(map(any))
  default     = []
  description = "The log_delivery_configuration block allows the streaming of Redis SLOWLOG to CloudWatch Logs"
}