# 설명: for_each를 사용해 각 서비스 이름과 포트를 출력합니다.

variable "service_ports" {
  type = map(number)
  default = {
    http  = 80
    https = 443
    ssh   = 22
  }
}

resource "null_resource" "for_each_example" {
  for_each = var.service_ports

  provisioner "local-exec" {
    command = "echo 'Service ${each.key} runs on port ${each.value}'"
  }
}
