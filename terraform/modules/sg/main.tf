module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3"

  name        = "sg-mysql"
  description = "Complete MySQL example security group"
  vpc_id      = var.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = var.vpc_cidr_block
    },
  ]

}