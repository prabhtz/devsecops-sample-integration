data "aws_vpc" "default" {
  default = true
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_security_group" "devsecops_sg" {
  name        = "devsecops-demo-sg"
  description = "Allow SSH and app traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DevSecOps-Demo-SG"
  }
}

resource "aws_instance" "devsecops_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.devsecops_sg.id]

  tags = {
    Name        = "DevSecOpsApp"
    Environment = "DevSecOps"
  }
}
