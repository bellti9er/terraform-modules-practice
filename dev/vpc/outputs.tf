output "vpc_id" { 
  value = module.vpc.vpc_id
}

output "ap-northeast-2a_public_subnet_id" {
  value = module.vpc.public_subnet_az_to_id_map["ap-northeast-2a"]
}

output "ap-northeast-2b_public_subnet_id" {
  value = module.vpc.public_subnet_az_to_id_map["ap-northeast-2b"]
}

output "ap-northeast-2c_public_subnet_id" {
  value = module.vpc.public_subnet_az_to_id_map["ap-northeast-2c"]
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
