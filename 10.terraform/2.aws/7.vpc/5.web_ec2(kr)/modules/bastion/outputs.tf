output "bastion_public_ip" {
  description = "The public IP of the Bastion Host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_instance_id" {
  description = "The instance ID of the Bastion Host"
  value       = aws_instance.bastion.id
}
