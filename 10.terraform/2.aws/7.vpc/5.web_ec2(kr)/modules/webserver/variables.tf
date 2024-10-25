variable "vpc_id" {
  description = "The ID of the VPC where the web server will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet where the web server will be deployed"
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
  description = "The name of the key pair to use for EC2 instances"
  type        = string
  default     = "my-nginx"
}

variable "ssm_instance_profile_name" {
  description = "The SSM instance profile name for the EC2 instance"
  type        = string
}
