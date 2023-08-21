output "instance_ids" {
  value = [ for instance in aws_instance.ec2: instance.id ]
}

output "instance_public_ips" {
  value = [ for eip in aws_eip.eip : eip.public_id ]
}

output "security_group_id" {
  value = aws_security_group.dev_ec2.id
}
