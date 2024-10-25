provider "aws" {
  region = var.region  # 리전 변수를 사용
}

# VPC 생성
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr  # VPC CIDR 변수를 사용
  
  # VPC 이름 태그
  tags = {
    Name = "MyVPC222"
  }
}

# --------------------
# 7. 퍼블릭 서브넷 공인IP 자동 할당 기능 추가 (GUI 에서 선확인 후 변경)

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

# --------------------
# 6. NAT-GW 추가

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

# VPC 기반 EIP: VPC 내에서 인스턴스 또는 NAT 게이트웨이와 같은 리소스에 할당되는 퍼블릭 IP입니다. 
# 예를 들어, NAT 게이트웨이에 할당된 VPC 기반 EIP는 VPC 내에서 프라이빗 서브넷이 인터넷에 접근할 수 있도록 합니다.


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

# --------------------
# 6. NAT-GW 연결

# 프라이빗 서브넷 라우트 설정 (NAT 게이트웨이 사용)
resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private_routetable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}


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

# 설명:
# - Elastic IP (EIP): aws_eip 리소스를 사용하여 NAT 게이트웨이를 위한 퍼블릭 IP 주소(EIP)를 생성했습니다.
# - NAT 게이트웨이: 퍼블릭 서브넷에 NAT 게이트웨이를 생성하여 프라이빗 서브넷에서 외부 인터넷으로 나가는 트래픽을 처리합니다.
# - 프라이빗 서브넷 라우트 테이블: NAT 게이트웨이를 통해 프라이빗 서브넷이 외부로 통신할 수 있도록 프라이빗 서브넷 전용 라우트 테이블을 생성하고 NAT 게이트웨이를 경유하는 라우트를 추가했습니다.
# - 프라이빗 서브넷 라우트 테이블과 서브넷 연결: aws_route_table_association을 사용하여 프라이빗 서브넷과 프라이빗 라우트 테이블을 연결했습니다.
