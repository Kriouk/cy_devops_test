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
  backend "s3" {
    bucket = "cycloid-tf-state-bucket"
    key = "states/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    encrypt = "true"
  }
}
provider "aws" {
    region = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
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