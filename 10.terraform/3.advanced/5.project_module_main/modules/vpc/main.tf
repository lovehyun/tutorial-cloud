# VPC 생성
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
#   tags = {
#     Name = "${var.environment}-vpc"
#   }
  tags = merge(
    var.tags, 
    { 
        Name = "${var.environment}-vpc" 
    }
  )
}

# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.environment}-igw"
  }
}

# 퍼블릭 서브넷 생성 (변수에 따라 개수 조절)
resource "aws_subnet" "public" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true  # 퍼블릭 IP 자동 할당

#   tags = {
#     Name = "${var.environment}-public-subnet-${count.index}"
#   }
  tags = merge(
    var.tags, 
    { 
      Name = "${var.environment}-public-subnet-${count.index}"
    }
  )
}

# 퍼블릭 라우팅 테이블 생성 및 인터넷 게이트웨이 연결
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

#   tags = {
#     Name = "${var.environment}-public-route-table"
#   }
  tags = merge(
    var.tags, 
    { 
      Name = "${var.environment}-public-route-table"
    }
  )
}

# 퍼블릭 서브넷과 라우팅 테이블 연결
resource "aws_route_table_association" "public_subnet_association" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
