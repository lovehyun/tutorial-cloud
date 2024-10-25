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
