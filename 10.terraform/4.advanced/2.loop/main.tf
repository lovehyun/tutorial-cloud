provider "aws" {
  region = "us-east-1"
}

# 변수 정의
variable "instance_count" {
  description = "Number of web servers to deploy"
  type        = number
  default     = 3
}

variable "ami_id" {
  description = "AMI ID for the web server instances"
  type        = string
#   default     = "ami-12345678"  # 실제 유효한 AMI ID로 교체하세요.
  default     = "ami-0ad554caf874569d2"
}

variable "instance_type" {
  description = "EC2 instance type for web servers"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
  # default     = "vpc-12345678"  # 실제 유효한 VPC ID로 교체하세요.
  default     = "vpc-91ddcfe8"
}

variable "subnet_ids" {
  description = "List of subnet IDs in different AZs for high availability"
  type        = list(string)
  # default     = ["subnet-0abcd1234efgh5678", "subnet-1abcd1234efgh5678", "subnet-2abcd1234efgh5678"]  # 실제 유효한 서브넷 ID로 교체하세요.
  default     = ["subnet-0e6f7d9bda61262b5", "subnet-c9a690e5", "subnet-06b57139"]
}

# Web 서버용 보안 그룹 생성
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# EC2 인스턴스 생성
resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index % length(var.subnet_ids))
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "web-server-${count.index + 1}"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              echo "Hello, World from server ${count.index + 1}" > /var/www/html/index.html
              systemctl start apache2
              systemctl enable apache2
              EOF
}

# 로드 밸런서 생성
resource "aws_lb" "web_lb" {
  name               = "web-load-balancer"
  internal           = false
  load_balancer_type = "application"
  # security_groups    = []  # 적절한 보안 그룹을 지정하세요.
  security_groups    = [aws_security_group.web_sg.id]

  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

# 로드 밸런서 대상 그룹 생성
resource "aws_lb_target_group" "web_tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# 로드 밸런서 리스너 생성
resource "aws_lb_listener" "web_lb_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# 인스턴스를 로드 밸런서 대상 그룹에 등록
resource "aws_lb_target_group_attachment" "web_attachment" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

# 출력
output "load_balancer_dns_name" {
  value = aws_lb.web_lb.dns_name
}
