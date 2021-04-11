module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "~> 2"

    name = "testing-mysql"
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

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3"

  name        = "testing-mysql"
  description = "Complete MySQL example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

}


module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.34.0"

  identifier = "testing-mysql-default"

  create_db_option_group    = false
  create_db_parameter_group = false

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.20"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t2.micro"

  allocated_storage = 5

  name                   = "testingdb"
  username               = "dbuser"
  password               = "test123"
  port                   = 3306

  subnet_ids             = module.vpc.database_subnets
  vpc_security_group_ids = [module.vpc.default_security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 0

}