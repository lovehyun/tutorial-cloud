# 설명: join을 사용해 서버 유형 리스트를 콤마로 연결하여 출력합니다.

variable "server_types" {
  type    = list(string)
  default = ["WebServer", "AppServer", "Database"]
}

resource "null_resource" "join_example" {
  provisioner "local-exec" {
    command = "echo 'Server types: ${join(", ", var.server_types)}'"
  }
}
