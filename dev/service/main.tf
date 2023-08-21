provider "aws" {
  region  = "ap-northeast-2"
  profile = "jongbeom"
}

###########################################################
## Remote States
###########################################################
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "dev-tf-state"
    key     = "dev/vpc.state"
    region  = "ap-northeast-2"
    profile = "jongbeom"
  }
}

###########################################################
## EC2 Instance
###########################################################
resource "aws_instance" "ec2" {
  count         = length(data.terraform_remote_state.vpc.outputs.public_subnet_az_to_id_map)
  ami           = "ami-0c0ea4662d3cca101" # https://cloud-images.ubuntu.com/locator/ec2/
  instance_type = "t3.micro"
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnet_ids[count.index]

  tags = {
    Name = "EC2-${count.index}"
  }
}

###########################################################
## EIP
###########################################################
resource "aws_eip" "eip" {
  count      = length(aws_instance.ec2)
  instance   = aws_instance.ec2[count.index].id
  domain     = "vpc"
}

###########################################################
## Security Groups
###########################################################
resource "aws_security_group" "dev_ec2" {
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  name        = "EC2"
  description = "EC2 Security Group"
}

resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.dev_ec2.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.dev_ec2.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.dev_ec2.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "all_traffic_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = aws_security_group.dev_ec2.id
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}
