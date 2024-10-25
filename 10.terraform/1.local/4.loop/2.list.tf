# 설명: list와 count를 활용해 리스트의 각 요소를 개별 리소스로 다룰 수 있게 하며, 리스트 길이에 따라 유연하게 확장 가능하도록 설정할 수 있습니다.

variable "cloud_services" {
  type    = list(string)
  default = ["EC2", "S3", "Lambda"]
}

resource "null_resource" "list_example" {
  count = 3  # 리스트의 길이를 직접 설정

  provisioner "local-exec" {
    command = "echo 'Cloud service: ${var.cloud_services[count.index]}'"
  }
}
