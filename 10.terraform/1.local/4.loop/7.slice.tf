# 설명: slice를 사용해 리스트에서 두 번째와 세 번째 서비스만 잘라서 출력합니다.

variable "cloud_services_list" {
  type    = list(string)
  default = ["IAM", "EC2", "S3", "Lambda", "RDS"]
}

resource "null_resource" "slice_example" {
  provisioner "local-exec" {
    command = "echo 'Selected services: ${join(", ", slice(var.cloud_services_list, 1, 3))}'"
  }
}

resource "null_resource" "slice_example2" {
  provisioner "local-exec" {
    command = "echo 'Selected services: ${join(", ", slice(var.cloud_services_list, 0, 2))}'"
  }
}
