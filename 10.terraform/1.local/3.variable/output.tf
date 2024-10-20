# 변수 출력 예시
output "file_name" {
  description = "The name of the created file"
  value       = local_file.pets.filename
}

output "file_permissions" {
  description = "The permission of the created file"
  value       = local_file.pets.file_permission
}

output "file_id" {
  description = "The id of the created file"
  value       = local_file.pets.id
}
