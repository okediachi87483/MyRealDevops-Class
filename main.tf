terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_instance" "ec2" {
  ami                    = var.ami # MUST be Ubuntu 22 if using deploy.sh
  instance_type           = var.instance_type
  subnet_id               = data.aws_subnets.default.ids[0]
  vpc_security_group_ids  = [aws_security_group.ec2_SecurityGroups.id]

  user_data = file("deploy.sh")

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 200
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name        = "u2-${var.environment}-${var.application}"
    CreatedBy   = var.launched_by
    Application = var.application
    OS          = var.os
    Environment = var.environment
  }
}

output "ec2_private_ip"  { value = aws_instance.ec2.private_ip }
output "ec2_public_ip"   { value = aws_instance.ec2.public_ip }
output "ec2_name"        { value = aws_instance.ec2.tags["Name"] }
output "ec2_instance_id" { value = aws_instance.ec2.id }