output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.network.public_subnet_id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = module.network.private_subnet_id
}

output "security_group_id" {
  description = "Application security group ID"
  value       = module.compute.security_group_id
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.compute.instance_id
}
