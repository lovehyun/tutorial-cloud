# AWS Provider 설정
provider "aws" {
  region = "ap-northeast-2"  # 사용하려는 AWS 리전 지정
  # region = "us-east-1"  # 사용하려는 AWS 리전 지정
}

# 변수 정의
variable "name" {
  default = "Terraform User"
}

variable "environment" {
  default = "production"
}

# 로컬 블록을 사용하여 템플릿 파일을 처리
locals {
  user_data = templatefile("${path.module}/userdata.tpl", { # 내장변수, 현재 모듈이 정의된 디렉토리
    name        = var.name,
    environment = var.environment
  })
}

# EC2 인스턴스 리소스 정의
resource "aws_instance" "example" {
  ami           = "ami-02c329a4b4aba6a48"  # 예시 AMI ID (ap-northeast-2 의 Amazon Linux 2)
#   ami           = "ami-06b21ccaeff8cd686"  # 예시 AMI ID (us-east-1 의 Amazon Linux 2)
  instance_type = "t2.micro"

  # 템플릿을 처리한 결과를 사용자 데이터로 사용
  user_data = local.user_data

  tags = {
    Name = "ExampleInstance"
  }
}
