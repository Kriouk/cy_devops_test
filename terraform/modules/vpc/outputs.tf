output "vpc_id" {
  value       = module.vpc.vpc_id
}

output "default_security_group_id" {
  value       = module.vpc.default_security_group_id
}

output "private_subnets" {
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  value       = module.vpc.public_subnets
}

output "database_subnets" {
  value       = module.vpc.database_subnets
}
output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
}