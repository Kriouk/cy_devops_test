provider "aws" {
    region = "eu-west-3"
    access_key = "{{env `AWS_ACCESS_KEY`}}"
    secret_key = "{{env `AWS_SECRET_KEY`}}"
}

resource "aws_ecr_repository" "ecr_repo" {
  name                 = "testing"
  image_tag_mutability = "MUTABLE"

  #image_scanning_configuration {
  #  scan_on_push = true
  #}
}