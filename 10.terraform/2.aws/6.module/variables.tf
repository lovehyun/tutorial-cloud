# 변수 정의
variable "name" {
  description = "The name to use in the User Data script"
  default     = "Terraform User"
}

variable "environment" {
  description = "The environment in which the instance is running"
  default     = "production"
}
