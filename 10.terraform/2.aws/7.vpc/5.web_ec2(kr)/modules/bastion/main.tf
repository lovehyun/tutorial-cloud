# Bastion Host 보안 그룹 설정
resource "aws_security_group" "bastion_sg" {
  name        = "bastion_security_group"
  description = "Allow SSH access from the internet"
  vpc_id      = var.vpc_id

  # 인그레스 규칙: SSH 접근 허용
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 모든 IP에서 SSH 접속 허용 (실제 환경에서는 제한할 것을 권장)
  }

  # 이그레스 규칙: 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion_security_group"
  }
}

# Bastion Host 인스턴스 생성
resource "aws_instance" "bastion" {
  ami                         = var.ami_id                # 사용할 AMI ID (Ubuntu 24.04)
  instance_type               = var.instance_type         # EC2 인스턴스 타입 (예: t2.micro)
  subnet_id                   = var.public_subnet_id      # 퍼블릭 서브넷 ID
  key_name                    = var.key_name              # SSH 키 페어
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]  # 보안 그룹

  associate_public_ip_address = true                     # 퍼블릭 IP 할당

  tags = {
    Name = "bastion_host"
  }
}
