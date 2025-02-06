output "arn" {
 value = "${aws_ecr_repository.ecr_repo.arn}"
 description = "Repository arn"
}
output "name" {
 value = "${aws_ecr_repository.ecr_repo.name}"
 description = "repository name"
}
output "registry_id" {
 value = "${aws_ecr_repository.ecr_repo.registry_id}"
 description = "registry id"
}
output "url" {
 value = "${aws_ecr_repository.ecr_repo.repository_url}"
 description = "repository url"
}

