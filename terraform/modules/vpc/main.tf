module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "~> 2"

    name = testing-mysql
    cidr = "10.99.0.0/18"

    azs              = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
    public_subnets   = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
    private_subnets  = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
    database_subnets = ["10.99.7.0/24", "10.99.8.0/24", "10.99.9.0/24"]

    create_database_subnet_group = true
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}