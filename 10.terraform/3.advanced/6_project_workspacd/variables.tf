# variables.tf 파일에 추가

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for public subnets"
  type        = list(string)
}

variable "subnet_count" {
  description = "Number of public subnets"
  type        = number
}

variable "environment" {
  description = "The environment to deploy (development, staging, production)."
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "desired_server_count" {
  description = "Number of desired servers for the environment."
  type        = number
}
