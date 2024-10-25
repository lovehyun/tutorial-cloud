# WAS 서버를 위한 보안 그룹
resource "aws_security_group" "was_sg" {
  name        = "was_security_group"
  description = "Allow internal communication and SSH from web server"
  vpc_id      = var.vpc_id

  # 8080 포트 접근 허용 (내부 서비스 통신)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # 내부 VPC 대역
  }

  # SSM-Agent 통신용 (HTTPS 사용)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH 접근 허용 (Web 서버 대역에서만 SSH 접근 허용)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.web_subnet_cidr_block]  # Web 서버 서브넷 대역에서만 SSH 접근 허용
  }

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "was_security_group"
  }
}

# WAS 서버를 위한 EC2 인스턴스 설정
resource "aws_instance" "was" {
  ami                         = var.ami_id                # AMI ID (Ubuntu 20.04)
  instance_type               = var.instance_type         # EC2 인스턴스 타입
  subnet_id                   = var.private_subnet_id     # 프라이빗 서브넷 ID
  vpc_security_group_ids      = [aws_security_group.was_sg.id]  # 보안 그룹 ID

  # 키 페어 설정 (SSH 접근을 위한 키 페어)
  key_name                    = var.key_name

  iam_instance_profile   = var.ssm_instance_profile_name  # SSM 접근 권한 적용

  # User data script to mount EBS volume and start Nginx
  user_data = templatefile("${path.module}/userdata.tpl", {
    custom_message = "WAS server is ready with EBS!"
  })

  # 태그
  tags = {
    Name = "was_server"
  }
}

# 추가적인 10GB EBS 볼륨 생성
resource "aws_ebs_volume" "was_ebs" {
  availability_zone = var.availability_zone  # 인스턴스와 동일한 가용 영역
  size              = 10                     # EBS 볼륨 크기 (GB)

  tags = {
    Name = "was_data_volume"
  }
}

# EBS 볼륨을 WAS 서버 인스턴스에 연결
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/xvdh"                       # EC2에 연결될 장치 이름
  volume_id   = aws_ebs_volume.was_ebs.id         # EBS 볼륨 ID
  instance_id = aws_instance.was.id               # EC2 인스턴스 ID
}
