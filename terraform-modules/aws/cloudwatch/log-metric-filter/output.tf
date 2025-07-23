# output "this_cloudwatch_log_metric_filter_arn" {
#     description = "arn of the metric filter"
#     value = aws_cloudwatch_log_metric_filter.metric_filter.arn
# }

# output "this_cloudwatch_metric_alarm_id" {
#   description = "The ID of the Cloudwatch log metric filter."
#   #represents ID attribute of all instances* 
#   #concat is used to concatenate the list of IDs with an empty list 
#   #element() used to retrieve the element at index 0 from the concatenated list of IDs.
#   value       = element(concat(aws_cloudwatch_log_metric_filter.metric_filter.*.id, [""]), 0)
#   #Overall, this Terraform output will display the ID of the CloudWatch log metric filter defined by the "aws_cloudwatch_log_metric_filter" resource named "this". If no instances of the resource exist, an empty string will be returned.
# }