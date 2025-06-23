output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
  
}

output "public_subnets" {
  description = "Public subnet IDs and their availability zones"
  value       = module.vpc.public_subnets
  
}

output "private_subnets" {
  description = "Private subnet IDs and their availability zones"
  value       = module.vpc.private_subnets
  
}