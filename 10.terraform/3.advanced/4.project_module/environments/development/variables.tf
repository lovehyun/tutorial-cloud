# 이 환경의 기본 설정
variable "environment" {
  description = "The environment to deploy (development, staging, production)."
  type        = string
  default     = "development"
}

variable "desired_server_count" {
  description = "Number of desired servers for the development environment."
  type        = number
}

## 공통 태그 추가시
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
