# terraform apply -var="desired_server_count=2" --auto-approve

provider "aws" {
  region = "ap-northeast-2"  # 실제 사용할 AWS 리전으로 변경
}

# 서브넷 ID와 IP 주소 풀 변수 설정
variable "subnet_ids" {
  description = "웹 서버를 배포할 서브넷 ID 리스트"
  type        = list(string)
  default     = ["subnet-12345", "subnet-67890", "subnet-abcde", "subnet-xyz"]  # 실제 서브넷 ID로 변경
}

variable "ip_address_pool" {
  description = "웹 서버에 할당할 IP 주소 풀"
  type        = list(string)
  default     = ["10.0.1.10", "10.0.1.11", "10.0.1.12", "10.0.1.13"]
}

# 원하는 서버 개수 (초기에는 CLI 또는 tfvars 파일에서 설정)
variable "desired_server_count" {
  description = "배포할 웹 서버의 개수"
  type        = number
}

# 각 서브넷에 원하는 수만큼 웹 서버 배포
resource "aws_instance" "web" {
  count         = var.desired_server_count  # 사용자가 설정한 서버 개수만큼 배포
  ami           = "ami-123456"              # 실제 AMI로 변경
  instance_type = "t2.micro"
  subnet_id     = element(var.subnet_ids, count.index)  # 각 서브넷에 배포
  private_ip    = element(var.ip_address_pool, count.index)

  tags = {
    Name = "WebServer-${count.index}"
  }
}

# 보안 그룹 생성
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "웹 서버 보안 그룹"
  vpc_id      = "vpc-123456"  # 실제 VPC ID로 변경

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [for ip in slice(var.ip_address_pool, 0, var.desired_server_count) : "${ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 선택한 IP 주소 출력
output "allocated_ips" {
  value = join(", ", slice(var.ip_address_pool, 0, var.desired_server_count))
}

# 공인 IP 주소 출력
output "public_ips" {
  description = "배포된 웹 서버의 공인 IP 주소"
  value       = aws_instance.web[*].public_ip
}

# 서버 이름, 사설 IP, 공인 IP를 함께 출력
output "server_details" {
  description = "서버 이름, 사설 IP, 공인 IP 주소 리스트"
  value = [
    for instance in aws_instance.web : {
      name       = instance.tags["Name"]
      private_ip = instance.private_ip
      public_ip  = instance.public_ip
    }
  ]
}
