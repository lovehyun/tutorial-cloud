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

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  # 서브넷 이름 태그 설정
  tags = {
    Name = "MySubnet1"
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

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.routetable.id
}
