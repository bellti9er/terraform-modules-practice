provider "aws" {
  region  = "ap-northeast-2"
  profile = "jongbeom"
}

############################################################
# VPC
############################################################
module "vpc" {
  source         = "../../modules/vpc"
  cidr_block     = "172.5.0.0/16"
  name           = "Dev"
  public_subnets = [
    {
      cidr_block = "172.5.0.0/24"
      zone       = "ap-northeast-2a"
      tags       = { Name = "Dev Public Subnet 1" }
    },
    {
      cidr_block = "172.5.2.0/24"
      zone       = "ap-northeast-2b"
      tags       = { Name = "Dev Public Subnet 2" }
    },
    {
      cidr_block = "172.5.4.0/24"
      zone       = "ap-northeast-2c"
      tags       = { Name = "Dev Public Subnet 3" }
    },
  ]
}
