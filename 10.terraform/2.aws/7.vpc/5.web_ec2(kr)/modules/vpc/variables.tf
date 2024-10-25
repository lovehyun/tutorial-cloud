# VPC CIDR 블록
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

# 퍼블릭 서브넷 CIDR 블록
variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
}

variable "public_subnet_az" {
  description = "The Availability Zone for the public subnet"
}

# 프라이빗 서브넷 CIDR 블록
variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
}

variable "private_subnet_az" {
  description = "The Availability Zone for the private subnet"
}
