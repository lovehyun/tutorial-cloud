# 2. 보안그룹이 누락되어 확인이 불가함으로, SG 추가

# AWS Provider 설정
provider "aws" {
  region = "ap-northeast-2"  # 사용하려는 AWS 리전 지정
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

# 기본 VPC 정보를 가져오는 데이터 소스
data "aws_vpc" "default" {
  default = true
}

# 보안 그룹 생성
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP traffic"
  vpc_id      = data.aws_vpc.default.id  # 기본 VPC의 ID를 사용

  # 인바운드 규칙: 포트 80 (HTTP) 허용
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 모든 IP에서 접근 허용
  }

  # 아웃바운드 규칙: 모든 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

# EC2 인스턴스 리소스 정의
resource "aws_instance" "example" {
  ami           = "ami-02c329a4b4aba6a48"  # 예시 AMI ID (ap-northeast-2 의 Amazon Linux 2)
#   ami           = "ami-06b21ccaeff8cd686"  # 예시 AMI ID (us-east-1 의 Amazon Linux 2)
  instance_type = "t2.micro"

  # 보안 그룹 설정
  vpc_security_group_ids = [aws_security_group.allow_http.id]

  # 템플릿을 처리한 결과를 사용자 데이터로 사용
  user_data = local.user_data

  tags = {
    Name = "ExampleInstance"
  }
}

# AWS 콘솔에서 아래를 통해 userdata 확인
# 인스턴스 클릭 -> 작업 -> 인스턴스 설정 -> 사용자 데이터 편집 (아래에서 4번째)
