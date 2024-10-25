# VPC ID 출력
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# 서브넷 ID 출력
output "subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.subnet_1.id
}
