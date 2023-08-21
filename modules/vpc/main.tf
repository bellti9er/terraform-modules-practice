############################################################
# VPC 
############################################################
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = { 
    Name = var.name 
  }
}

############################################################
# Public Subnets
############################################################
resource "aws_subnet" "public_subnets" {
  for_each = { for v in var.public_subnets : v.zone => v }

	vpc_id            = aws_vpc.vpc.id
	cidr_block        = each.value.cidr_block
	availability_zone = each.value.zone

  tags  = each.value.tags
}

############################################################
# Routing table for public subnets
############################################################
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name} Internet Gateway" 
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = { 
    Name = "${var.name} Public Default Route Table" 
  }
}

resource "aws_route" "public" {
	route_table_id         = aws_vpc.vpc.default_route_table_id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public_subnets

	subnet_id      = each.value.id
	route_table_id = aws_vpc.vpc.default_route_table_id
}
