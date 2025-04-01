data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "devsecops_sg" {
  name        = "devsecops-demo-sg"
  description = "Allow SSH and app traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24"]
  }

  ingress {
    description = "App Port"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    # tfsec:ignore:aws-ec2-no-public-egress-sgr
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

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    encrypted   = true
  }

  tags = {
    Name        = "DevSecOpsApp"
    Environment = "DevSecOps"
  }
}
