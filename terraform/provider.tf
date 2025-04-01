terraform {
  backend "s3" {
    bucket         = "devsecops-demo-tf-state"
    key            = "devsecops-node-app/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = var.aws_region
}
