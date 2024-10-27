variable "desired_server_count" {
  description = "The number of web servers to create."
  type        = number
}

variable "ami_id" {
  description = "The AMI ID for the web server instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the web server."
  type        = string
}

variable "public_subnet_ids" {
  description = "The list of public subnet IDs to place instances in."
  type        = list(string)
}

variable "environment" {
  description = "The environment this server is deployed in (development, staging, production)."
  type        = string
}

# security_group 에서 필요
variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

# 공통 태그 메인으로부터 전달
variable "tags" {
  description = "Common tags for all resources in the VPC module."
  type        = map(string)
  default     = {}
}
