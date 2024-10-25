variable "vpc_id" {
  description = "The ID of the VPC where the Bastion Host will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet where the Bastion Host will be deployed"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID for Ubuntu 24.04"
  type        = string
  default     = "ami-040c33c6a51fd5d96"  # ap-northeast-2 지역의 Ubuntu 24.04 AMI ID
  # default     = "ami-0866a3c8686eaeeba"  # us-east-1 지역의 Ubuntu 24.04 AMI ID
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}
