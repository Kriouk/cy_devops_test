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
    backend "s3" {
        bucket = "cycloid-tf-state-bucket"
        key = "states/terraform.tfstate"
        access_key = "${{ secrets.AWS_ACCESS_KEY }}"
        secret_key = "${{ secrets.AWS_SECRET_KEY }}"
        region = "${{ secrets.AWS_REGION }}"
        encrypt = true
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