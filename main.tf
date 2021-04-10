terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
    region = "eu-west-3"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

resource "aws_ecr_repository" "ecr_repo" {
  name                 = "testing"
  image_tag_mutability = "MUTABLE"

  #image_scanning_configuration {
  #  scan_on_push = true
  #}
}