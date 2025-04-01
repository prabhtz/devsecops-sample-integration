variable "aws_region" {
  description = "The AWS region to deploy to"
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  default     = "ami-0efc43a4067fe9a3e" # Amazon Linux 2 AMI
}

variable "app_port" {
  description = "Port for the Node.js app"
  default     = 3000
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
  default     = "devsecops_vm"
}
