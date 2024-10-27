# 웹 서버 보안 그룹 생성
resource "aws_security_group" "web_sg" {
  name_prefix = "${var.environment}-web-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  # 인바운드 규칙 - 포트 80 허용
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 아웃바운드 규칙 - 모든 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # tags = { Name = "${var.environment}-web-sg" }
  tags = merge(var.tags, { Name = "${var.environment}-web-sg" })
}

# 템플릿을 사용하여 User Data 스크립트 생성
data "template_file" "user_data" {
  template = file("${path.module}/user_data.tpl")
  vars = {
    environment = var.environment
  }
}

resource "aws_instance" "web" {
  count                      = var.desired_server_count
  ami                        = var.ami_id
  instance_type              = var.instance_type
  subnet_id                  = element(var.public_subnet_ids, count.index % length(var.public_subnet_ids))
  associate_public_ip_address = true  # 퍼블릭 IP 할당
  vpc_security_group_ids     = [aws_security_group.web_sg.id]

  # 보안 그룹이 생성된 후에 인스턴스가 생성되도록 설정
  depends_on = [aws_security_group.web_sg]

  # User Data를 사용하여 Nginx 설치 및 메시지 출력
  user_data = data.template_file.user_data.rendered

#   tags = {
#     Name       = "${var.environment}-web-server-${count.index}"
#     Environment = var.environment
#   }
  tags = merge(
    var.tags, 
    { 
      Name = "${var.environment}-web-server-${count.index}" 
    }
  )
}
