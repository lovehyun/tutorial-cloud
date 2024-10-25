output "web_instance_id" {
  description = "The ID of the Web EC2 instance"
  value       = aws_instance.web.id
}

output "web_instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}
