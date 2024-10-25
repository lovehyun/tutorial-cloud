# WAS EC2 인스턴스의 ID 출력
output "was_instance_id" {
  description = "The ID of the WAS EC2 instance"
  value       = aws_instance.was.id
}

# WAS EC2 인스턴스의 Private IP 출력
output "was_instance_private_ip" {
  description = "The private IP address of the WAS EC2 instance"
  value       = aws_instance.was.private_ip
}

# WAS 서버에 연결된 EBS 볼륨의 ID 출력
output "was_ebs_volume_id" {
  description = "The ID of the attached EBS volume for the WAS server"
  value       = aws_ebs_volume.was_ebs.id
}
