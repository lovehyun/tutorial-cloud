provider "aws" {
  region = var.region  # 리전 변수를 사용
}

# --------------------
# 1. VPC 설계

# VPC 생성
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr  # VPC CIDR 변수를 사용
  
  # VPC 이름 태그
  tags = {
    Name = "MyVPC"
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

# --------------------
# 4. 프라이빗 서브넷 추가

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

# 라우트 테이블 생성
resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.main.id

  # 라우트 테이블 이름 태그
  tags = {
    Name = "MyRouteTable"
  }
}

# 라우트 설정
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.routetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# 퍼블릭 서브넷과 라우트 테이블 연결
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.routetable.id
}

# --------------------
# 5. 프라이빗 라우터 추가

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
# 2. SG 보안 그룹 추가

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
    cidr_blocks = ["0.0.0.0/24"]  # 특정 IP 주소 범위로 수정
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
# - 가용 영역별 서브넷: 각 서브넷의 가용 영역을 따로 설정하기 위해 public_subnet_az와 private_subnet_az 변수를 사용하였습니다. 
#   이를 통해 퍼블릭 서브넷은 us-east-1a, 프라이빗 서브넷은 us-east-1a에 배포됩니다. (필요시 us-east-1b등으로 변경)
# - 변수 일관성: 각 서브넷에 가용 영역을 변수로 정의하면 향후 가용 영역을 변경하거나 확장할 때 수정이 용이합니다.
