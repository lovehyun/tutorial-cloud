# EC2 인스턴스의 퍼블릭 IP 출력
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}

# 보안 그룹 ID 출력
output "security_group_id" {
  description = "The ID of the created Security Group"
  value       = aws_security_group.allow_http.id
}
