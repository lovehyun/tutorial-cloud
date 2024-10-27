variable "environment" {
  description = "The environment to deploy (development, staging, production)."
  type        = string
  default     = "production"
}

variable "desired_server_count" {
  description = "Number of desired servers for the production environment."
  type        = number
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
