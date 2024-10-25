# VPC 생성
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr  # VPC CIDR 변수를 사용
  
  # VPC 이름 태그
  tags = {
    Name = "MyVPC2"
  }
}

# 퍼블릭 서브넷 생성 (개별 가용 영역 설정)
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr  # 퍼블릭 서브넷 CIDR 변수를 사용
  availability_zone = var.public_subnet_az    # 퍼블릭 서브넷 가용 영역 변수 사용
  map_public_ip_on_launch = true  # 인스턴스 시작 시 공인 IP 자동 할당

  # 서브넷 이름 태그
  tags = {
    Name = "MyPublicSubnet1"
  }
}

# 프라이빗 서브넷 생성 (개별 가용 영역 설정)
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr  # 프라이빗 서브넷 CIDR 변수를 사용
  availability_zone = var.private_subnet_az    # 프라이빗 서브넷 가용 영역 변수 사용

  # 서브넷 이름 태그
  tags = {
    Name = "MyPrivateSubnet1"
  }
}

# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  # 인터넷 게이트웨이 이름 태그
  tags = {
    Name = "MyInternetGateway"
  }
}

# 라우트 테이블 생성 (퍼블릭 서브넷용)
resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.main.id

  # 라우트 테이블 이름 태그
  tags = {
    Name = "MyPublicRouteTable"
  }
}

# 라우트 설정 (퍼블릭 서브넷에서 인터넷 연결)
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_routetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# 퍼블릭 서브넷과 라우트 테이블 연결
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_routetable.id
}

# NAT 게이트웨이 생성 (퍼블릭 서브넷에 NAT 게이트웨이 생성)
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id  # 퍼블릭 서브넷에 NAT 게이트웨이 생성

  # NAT 게이트웨이 이름 태그
  tags = {
    Name = "MyNATGateway"
  }
}

# NAT 게이트웨이를 위한 Elastic IP (EIP) 생성
resource "aws_eip" "nat_eip" {
  domain = "vpc"  # VPC 기반 EIP 생성
}

# 라우트 테이블 생성 (프라이빗 서브넷용)
resource "aws_route_table" "private_routetable" {
  vpc_id = aws_vpc.main.id

  # 라우트 테이블 이름 태그
  tags = {
    Name = "MyPrivateRouteTable"
  }
}

# 프라이빗 서브넷과 라우트 테이블 연결
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_routetable.id
}

# 프라이빗 서브넷 라우트 설정 (NAT 게이트웨이 사용)
resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private_routetable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

# 보안 그룹 생성
# VPC 에서 삭제하고 추후 EC2 에 생성
