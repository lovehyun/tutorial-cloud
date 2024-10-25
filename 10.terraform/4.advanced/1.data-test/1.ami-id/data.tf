provider "aws" {
  region = "us-east-1"
}

# Ubuntu 22.04 Free Tier AMI ID 검색
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]  # Ubuntu의 공식 AWS 계정 ID
}
