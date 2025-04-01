# Monitoring Security Group
resource "aws_security_group" "monitoring_sg" {
  name        = "monitoring-sg"
  description = "Allow Grafana (3000) and Prometheus (9090)"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow Prometheus UI"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    # tfsec:ignore:aws-ec2-no-public-ingress-sgr
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Grafana UI"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    # tfsec:ignore:aws-ec2-no-public-ingress-sgr
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # tfsec:ignore:aws-ec2-no-public-ingress-sgr
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # tfsec:ignore:aws-ec2-no-public-egress-sgr
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MonitoringSG"
  }
}

# Monitoring EC2 Instance
resource "aws_instance" "monitoring_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.monitoring_sg.id]

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    encrypted   = true
  }

  tags = {
    Name        = "MonitoringServer"
    Environment = "DevSecOps"
  }
}
