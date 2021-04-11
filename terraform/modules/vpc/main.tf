# module "vpc" {
#     source  = "terraform-aws-modules/vpc/aws"
#     version = "~> 2"

#     name = "testing-mysql"
#     cidr = "10.99.0.0/18"

#     azs              = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
#     public_subnets   = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
#     private_subnets  = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
#     database_subnets = ["10.99.7.0/24", "10.99.8.0/24", "10.99.9.0/24"]

#     create_database_subnet_group = true
#   tags = {
#     Terraform = "true"
#     Environment = "dev"
#   }
# }


# module "security_group" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "~> 3"

#   name        = "testing-mysql"
#   description = "Complete MySQL example security group"
#   vpc_id      = module.vpc.vpc_id

#   # ingress
#   ingress_with_cidr_blocks = [
#     {
#       from_port   = 3306
#       to_port     = 3306
#       protocol    = "tcp"
#       description = "MySQL access from within VPC"
#       cidr_blocks = module.vpc.vpc_cidr_block
#     },
#   ]

# }