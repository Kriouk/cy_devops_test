variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "ecr_repository_name" {}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
    region = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  #image_scanning_configuration {
  #  scan_on_push = true
  #}
}