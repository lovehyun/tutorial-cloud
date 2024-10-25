output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.public_subnet_1.cidr_block
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_cidr_block" {
  value = aws_subnet.private_subnet_1.cidr_block
}

output "nat_gateway_eip" {
  value = aws_eip.nat_eip.public_ip
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}
