variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "ecr_repository_name" {}

module "backend" {
  source = "github.com/samstav/terraform-aws-backend"
  backend_bucket = "cycloid-tf-state-bucket"
  # using options, e.g. if you dont want a dynamodb lock table, uncomment this:
  dynamodb_lock_table_enabled = false
}

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


#S3 bucket for Terraform state file
resource "aws_s3_bucket" "b" {

  bucket = "cycloid-tf-state-bucket"
  acl    = "private"

  tags = {
    Name = "TerraformState"
  }

  versioning {
    enabled = true #best practice for recovering tf-state on the S3 bucket in case of an accident
  }

}

#ECR
resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  #image_scanning_configuration {
  #  scan_on_push = true
  #}
}

#RDS