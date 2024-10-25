# 설명: for를 사용해 각 인스턴스 카운트를 2배로 만든 후 리스트로 출력합니다.

# 1. 기본 예제
variable "instance_counts" {
  type    = list(number)
  default = [1, 2, 3]
}

resource "null_resource" "for_example" {
  provisioner "local-exec" {
    command = "echo 'Doubled instance counts: ${join(", ", [for count in var.instance_counts : count * 2])}'"
  }
}


# 2. 응용 예제 #1
# 각 서버의 이름 뒤에 접미사 추가하기 (리스트 변환)
variable "server_names" {
  type    = list(string)
  default = ["app-server", "db-server", "cache-server"]
}

locals {
  server_names_with_suffix = [for server in var.server_names : "${server}-prod"]
}

resource "null_resource" "server_suffix_example" {
  provisioner "local-exec" {
    command = "echo 'Servers with suffix: ${join(", ", local.server_names_with_suffix)}'"
  }
}


# 3. 응용 예제 #2
# 특정 조건에 맞는 값만 포함하기 (리스트 필터링)
# 포트 리스트 중 1000 이상인 포트만 포함하는 예제입니다.

variable "ports" {
  type    = list(number)
  default = [22, 80, 443, 8080, 3306]
}

locals {
  high_ports = [for port in var.ports : port if port >= 1000]
}

resource "null_resource" "high_ports_example" {
  provisioner "local-exec" {
    command = "echo 'High ports: ${join(", ", local.high_ports)}'"
  }
}
