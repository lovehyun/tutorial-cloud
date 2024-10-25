# VPC ID 출력
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# 퍼블릭 서브넷 ID 출력
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

# 퍼블릭 서브넷 CIDR 출력
output "public_subnet_cidr_block" {
  description = "The CIDR block of the public subnet"
  value       = module.vpc.public_subnet_cidr_block
}

# 프라이빗 서브넷 ID 출력
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.vpc.private_subnet_id
}

# 프라이빗 서브넷 CIDR 출력
output "private_subnet_cidr_block" {
  description = "The CIDR block of the private subnet"
  value       = module.vpc.private_subnet_cidr_block
}

# Elastic IP (EIP) 출력
output "nat_gateway_eip" {
  description = "The Elastic IP associated with the NAT Gateway"
  value       = module.vpc.nat_gateway_eip
}

# NAT 게이트웨이 ID 출력
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_id
}


# 2. Web Server
# 퍼블릭 웹서버 서버의 인스턴스 ID 출력
output "web_instance_id" {
  description = "The ID of the Web EC2 instance"
  value       = module.webserver.web_instance_id
}

# 퍼블릭 웹서버 공인IP 주소 출력
output "web_instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = module.webserver.web_instance_public_ip
}


# 3. WAS Server
# WAS 서버의 인스턴스 ID 출력
output "was_instance_id" {
  description = "The ID of the WAS EC2 instance"
  value       = module.was.was_instance_id
}

# WAS 서버의 Private IP 출력
output "was_instance_private_ip" {
  description = "The private IP address of the WAS EC2 instance"
  value       = module.was.was_instance_private_ip
}

# WAS 서버에 연결된 EBS 볼륨의 ID 출력
output "was_ebs_volume_id" {
  description = "The ID of the attached EBS volume for the WAS server"
  value       = module.was.was_ebs_volume_id
}


# 4. Bastion
# Bastion Host 퍼블릭 IP 출력
output "bastion_public_ip" {
  description = "The public IP of the Bastion Host"
  value       = module.bastion.bastion_public_ip
}

# Bastion Host 인스턴스 ID 출력
output "bastion_instance_id" {
  description = "The instance ID of the Bastion Host"
  value       = module.bastion.bastion_instance_id
}
