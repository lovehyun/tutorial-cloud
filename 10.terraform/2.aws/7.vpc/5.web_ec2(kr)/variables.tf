# 리전 변수
variable "region" {
  description = "The AWS region to deploy in"
  default     = "ap-northeast-2"
}

# VPC CIDR 블록
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# 퍼블릭 서브넷 CIDR 블록
variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_az" {
  description = "The Availability Zone for the public subnet"
  default     = "ap-northeast-2a"
}

# 프라이빗 서브넷 CIDR 블록
variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "private_subnet_az" {
  description = "The Availability Zone for the private subnet"
  default     = "ap-northeast-2a"
}
