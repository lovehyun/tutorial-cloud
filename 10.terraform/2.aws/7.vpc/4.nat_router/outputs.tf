# VPC ID 출력
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# 퍼블릭 서브넷 ID 출력
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet_1.id
}

# 퍼블릭 서브넷 CIDR 출력
output "public_subnet_cidr_block" {
  description = "The CIDR block of the public subnet"
  value       = aws_subnet.public_subnet_1.cidr_block
}

# 프라이빗 서브넷 ID 출력
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private_subnet_1.id
}

# 프라이빗 서브넷 CIDR 출력
output "private_subnet_cidr_block" {
  description = "The CIDR block of the private subnet"
  value       = aws_subnet.private_subnet_1.cidr_block
}

# 퍼블릭 라우트 테이블 ID 출력
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_routetable.id
}

# 프라이빗 라우트 테이블 ID 출력
output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_routetable.id
}

# Elastic IP (EIP) 출력
output "nat_gateway_eip" {
  description = "The Elastic IP associated with the NAT Gateway"
  value       = aws_eip.nat_eip.public_ip
}

# NAT 게이트웨이 ID 출력
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat_gw.id
}
