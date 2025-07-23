//creates a S3 folder as a bucket object
resource "aws_s3_bucket_object" "s3_folder" {
    bucket   = var.bucket //"${module.s3_bucket.bucket_id}"
    acl      = var.acl
    key      =  var.key //"${var.folder_name}/"
    content_type = var.content_type //"application/x-directory"
    //  (Optional) Specifies the AWS KMS Key ARN to use for object encryption. This value is a fully qualified ARN of the KMS Key. 
    kms_key_id = var.kms_key_id //"${var.kms_key_arn}"
}
