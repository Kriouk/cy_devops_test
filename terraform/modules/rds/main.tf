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

  subnet_ids             = "${var.database_subnets}"
  vpc_security_group_ids = "[${var.default_security_group_id}]"

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 0

}