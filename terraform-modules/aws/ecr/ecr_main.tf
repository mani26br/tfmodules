resource "aws_ecr_repository" "ecr_repo" {
  name = var.ecr_repository_name
  image_tag_mutability = var.ecr_image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.ecr_scan_images_on_push
  }
  tags = merge(map(
  "Name", var.ecr_repository_name,
  ), var.ecr_repository_tags)
}

resource "aws_ecr_repository_policy" "CrossAccountPull" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = data.aws_iam_policy_document.ecr_policy_doc.json
}
data "aws_iam_policy_document" "ecr_policy_doc" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.ecr_accounts
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }
}
