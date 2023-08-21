# VPC

현재 최소한의 recources만을 모듈화하였으며, 이후 추가로 작성하며 update 할 예정입니다.

vpc 모듈화를 진행하며 참고한 자료는 다음과 같습니다.

- https://github.com/terraform-aws-modules/terraform-aws-vpc
- https://developer.hashicorp.com/terraform/language/meta-arguments/for_each

</br>

Terraform module for VPC. This module creates the following AWS resources:

- VPC
- Public subnets
- Routing table for public subnets
- Internet gateway for public subnets

</br>

## Usage
--------------------------------------------------------------------------------
```terraform
module "vpc" {
  source     = "../modules/vpc"
  name       = "your-vpc-name"
  cidr_block = "10.0.0.0/16"

  public_subnets = [
    {
      cidr_block = "10.0.2.0/24"
      zone       = "ap-northeast-2a"
      tags       = { Name = "your-public-subnet-name-1" }
    },
    {
      cidr_block = "10.0.4.0/24"
      zone       = "ap-northeast-2b"
      tags       = { Name = "your-public-subnet-name-2" }
    },
    {
      cidr_block = "10.0.6.0/24"
      zone       = "ap-northeast-2c"
      tags       = { Name = "your-public-subnet-name-3" }
    }
  ]
}
```
> 🚧 This code is a basic example. For actual use, you can change this value according to your requirements.


</br>

## Variables
--------------------------------------------------------------------------------
```terraform
variable "name"            {    } 
variable "cidr_block"      {    } 
variable "public_subnets"  {    } 
```

</br>

## Outputs
--------------------------------------------------------------------------------
- `vpc_id`
- `vpc_cidr_block`
- `public_subnet_ids`
- `public_route_table_id`
- `public_subnet_az_to_id_map`


</br>
