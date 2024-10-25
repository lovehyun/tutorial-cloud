# 설명: toset을 사용해 중복이 제거된 고유한 서비스 목록을 출력합니다.

variable "duplicate_services" {
  type    = list(string)
  default = ["EC2", "S3", "S3", "Lambda", "Lambda"]
}

resource "null_resource" "toset_example" {
  provisioner "local-exec" {
    command = "echo 'Unique services: ${join(", ", toset(var.duplicate_services))}'"
  }
}
