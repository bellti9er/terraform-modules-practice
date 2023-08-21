output "vpc_id" { 
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "public_subnet_ids" {
  value = [ for subnet in aws_subnet.public_subnets: subnet.id ]
}

output "public_route_table_id" {
  value =  "${aws_default_route_table.default.id}"
}

output "public_subnet_az_to_id_map" {
  value = { for subnet in aws_subnet.public_subnets: subnet.availability_zone => subnet.id }
}
