terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web-1" {
    ami = "ami-0e001c9271cf7f3b9" # Ubuntu 22.04
    instance_type = "t2.micro"
}
