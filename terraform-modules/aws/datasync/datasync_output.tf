output "source_location_arn" {
    value = aws_datasync_location_s3.s3_datasync_source_location.arn
}

output "destination_location_arn" {
    value = aws_datasync_location_s3.s3_datasync_destination_location.arn
}
