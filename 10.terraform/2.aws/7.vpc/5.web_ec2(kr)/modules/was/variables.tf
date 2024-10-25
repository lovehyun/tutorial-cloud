variable "vpc_id" {
  description = "The ID of the VPC where the WAS server will be deployed"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet where the WAS server will be deployed"
  type        = string
}

variable "web_subnet_cidr_block" {
  description = "The CIDR block of the web server subnet"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type for the WAS server"
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

variable "availability_zone" {
  description = "The availability zone for the WAS server"
  type        = string
}

variable "ebs_size" {
  description = "The size of the EBS volume in GB"
  type        = number
  default     = 10
}

variable "ssm_instance_profile_name" {
  description = "The SSM instance profile name for the EC2 instance"
  type        = string
}
