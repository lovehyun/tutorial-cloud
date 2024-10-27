output "instance_ids" {
  description = "The IDs of the web server instances."
  value       = aws_instance.web[*].id
}

output "public_ips" {
  description = "The public IPs of the web server instances."
  value       = aws_instance.web[*].public_ip
}

output "private_ips" {
  description = "The private IPs of the web server instances."
  value       = aws_instance.web[*].private_ip
}

output "subnet_ids" {
  description = "The list of subnet IDs where web servers are deployed."
  value       = [for instance in aws_instance.web : instance.subnet_id]
}

output "web_server_details" {
  description = "Details of each web server instance, including ID, public IP, private IP, and subnet ID."
  value = [
    for instance in aws_instance.web : {
      instance_id = instance.id
      public_ip   = instance.public_ip
      private_ip  = instance.private_ip
      subnet_id   = instance.subnet_id
      availability_zone  = instance.availability_zone
    }
  ]
}
