# 웹 서버를 위한 보안 그룹
resource "aws_security_group" "web_sg" {
  name        = "web_security_group"
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id  # VPC ID를 변수에서 받아옴

  # HTTP 접근 허용
  ingress {
    from_port   = 80           # HTTP 포트
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 모든 IP 주소 허용
  }

  # SSM-Agent 통신용 (HTTPS 사용)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # SSH 접근 허용
  ingress {
    from_port   = 22           # SSH 포트
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 모든 IP 주소 허용 (보안상 특정 IP로 제한하는 것이 권장됨)
  }

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # 모든 프로토콜 허용
    cidr_blocks = ["0.0.0.0/0"]  # 모든 IP 주소로의 아웃바운드 허용
  }

  # 보안 그룹에 태그 추가
  tags = {
    Name = "web_security_group"  # 보안 그룹 이름
  }
}

# 웹 서버를 위한 EC2 인스턴스 설정
resource "aws_instance" "web" {
  ami                         = var.ami_id                # 사용할 AMI ID (Ubuntu 24.04)
  instance_type               = var.instance_type         # EC2 인스턴스 타입 (예: t2.micro)
  subnet_id                   = var.public_subnet_id      # 퍼블릭 서브넷 ID
  vpc_security_group_ids      = [aws_security_group.web_sg.id]  # VPC 환경에서 보안 그룹의 ID

  # 키 페어 설정 (SSH로 접속하기 위해 사용)
  key_name                    = var.key_name  # AWS에 등록된 키 페어 이름

  iam_instance_profile        = var.ssm_instance_profile_name  # SSM 접근 권한 적용

  # User data script to install and start nginx on instance
  # user_data = <<-EOF
  #   #!/bin/bash
  #   sudo apt update -y
  #   sudo apt install -y nginx
  #   sudo systemctl start nginx
  #   sudo systemctl enable nginx
  # EOF

  # EC2 인스턴스 시작 시 실행되는 사용자 데이터 스크립트 (외부 템플릿 파일에서 읽어옴)
  # user_data = templatefile("${path.module}/userdata.tpl", {})
  user_data = templatefile("${path.module}/userdata.tpl", {
    custom_message = "Hello, World from Terraform!"  # 사용자 정의 메시지 전달
  })

  # EC2 인스턴스에 태그 추가
  tags = {
    Name = "web_server"  # EC2 인스턴스 이름
  }
}
