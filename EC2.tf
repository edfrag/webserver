provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "terraformstufff"
    key    = "terraform/state-us-east-1-webserver"
    region = "ap-southeast-2"
  }
}

data "aws_ami" "web_ami" {
  most_recent = true
  owners = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_security_group" "standard" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }

resource "aws_instance" "webserver" {
    ami = data.aws_ami.web_ami.id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.standard.id]
    subnet_id = var.subnet-web
    user_data = <<EOF
		#! /bin/bash
                sudo yum update -y
		        sudo yum install -y httpd
		        sudo systemctl start httpd
		        sudo systemctl enable httpd
		        echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
	EOF
	tags = {
		Name = "Terraform"
	}
    count = 1
}
