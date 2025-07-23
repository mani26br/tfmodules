resource "aws_s3_bucket_replication_configuration" "repliction" {

  bucket = var.existing_bucket
  role = var.replication_role


    rule {
      id = "tfstate_replication"

      status = "Enabled"

      delete_marker_replication {
        status = "Enabled"
      }

      filter {
        prefix = var.s3_bucket_prefix
      }

      destination {
        bucket  = "arn:aws:s3:::${var.destination_bucket}"
        storage_class = "STANDARD"
        access_control_translation {
         owner = "Destination"
        }
        account = var.destination_account
      }
   }
}
