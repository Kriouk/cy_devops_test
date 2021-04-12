variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "ecr_repository_name" {}
#variable "rds_name" {}
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
        encrypt = true
    }
}
provider "aws" {
    region = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

module "ecr" {
  source = "../modules/ecr"
}

module "vpc" {
    source = "../modules/vpc"
}

module "security_group" {
    source = "../modules/sg"
    vpc_id = module.vpc.vpc_id
    vpc_cidr_block = module.vpc.vpc_cidr_block
}

#RDS
module "rds" {
   source = "../modules/rds"
   vpc_database_subnets   = module.vpc.database_subnets
   vpc_default_security_group_id = [module.vpc.default_security_group_id]
}

#module "ecs" {
#    source = "../modules/ecs"
#}