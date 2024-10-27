variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "subnet_count" {
  description = "The number of public subnets to create."
  type        = number
}

variable "availability_zones" {
  description = "The list of availability zones for the public subnets."
  type        = list(string)
}

variable "public_subnet_cidr_blocks" {
  description = "The list of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "environment" {
  description = "The environment this VPC is deployed in (development, staging, production)."
  type        = string
}

variable "tags" {
  description = "Common tags for all resources in the VPC module."
  type        = map(string)
  default     = {}
}
