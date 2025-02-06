variable "diagnostic_setting_name" {
    type = string
    description = "The name of the diagnostic setting"
}

variable "target_resource_id" {
    type = string
    description = "The resource id of the resource to add diagnostic settings to."
}

variable "storage_account_id" {
    type = string
    description = "storage account id"
}

variable "log_analytics_workspace_id" {
    type = string
    description = "The workspace id of the log analytics workspace to send logs to."
}

variable "log_analytics_destination_type" {
    type = string
    description = "The workspace id of the log analytics destination."
}

variable "diagnostic_logs" {
    type = list
	description = "An array of diagnostic logs to configure."
}

variable "diagnostic_metrics" {
    type = list
	description = "An array of diagnostic metrics to configure."
}
