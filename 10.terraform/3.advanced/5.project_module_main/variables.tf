# 공통 태그 및 환경 설정
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "MyProject"
}

variable "environment" {
  description = "The environment to deploy (development, staging, production)"
  type        = string
  default     = "development"
}
