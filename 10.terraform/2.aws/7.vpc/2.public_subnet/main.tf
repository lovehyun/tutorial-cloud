provider "aws" {
  region = "us-east-1"  # 리전 변경
}

# --------------------
# 1. VPC 설계

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  # VPC 이름 태그 설정
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  # 서브넷 이름 태그 설정
  tags = {
    Name = "MyPublicSubnet1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  # 인터넷 게이트웨이 이름 태그 설정
  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.main.id

  # 라우트 테이블 이름 태그 설정
  tags = {
    Name = "MyRouteTable"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.routetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.routetable.id
}


# --------------------
# 2. SG 추가

# 보안 그룹 생성
resource "aws_security_group" "instance_sg" {
  name        = "instance_security_group"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  # 인바운드 규칙 (SSH 허용)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 특정 IP 주소 범위로 수정
  }

  # 아웃바운드 규칙 (모든 트래픽 허용)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 태그 설정
  tags = {
    Name = "instance_security_group"
  }
}

