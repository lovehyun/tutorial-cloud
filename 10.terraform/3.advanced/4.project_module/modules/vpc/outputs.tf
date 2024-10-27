output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "route_table_id" {
  description = "The ID of the public route table."
  value       = aws_route_table.public_route_table.id
}

output "subnet_count" {
  description = "The number of public subnets created in the VPC."
  value       = length(aws_subnet.public[*].id)
}
