# EC2 인스턴스의 타입을 출력
output "instance_type" {
    description = "The instance type of the EC2 instance"
    value       = var.instance_type
}

# 디스크 크기 (instance_settings에서 두 번째 값) 출력
output "disk_size" {
    description = "The disk size of the EC2 instance"
    value       = var.instance_settings[1]
}

# 보안 그룹에서 허용된 IP 주소 리스트 출력
output "security_group_allowed_ips" {
    description = "Allowed IPs in the security group"
    value       = var.allowed_ip_addresses
}

# 인스턴스 ID 출력
output "instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.example.id
}

# 인스턴스 퍼블릭 IP 출력
output "instance_public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = aws_instance.example.public_ip
}

# 보안 그룹 ID 출력
output "security_group_id" {
    description = "The ID of the security group"
    value       = aws_security_group.example.id
}
