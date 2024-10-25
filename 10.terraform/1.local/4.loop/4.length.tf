# 설명: length 함수를 사용해 클라우드 리전의 개수를 출력합니다.

# 1. 기본 예제
variable "cloud_zones" {
  type    = list(string)
  default = ["us-east-1", "us-west-1", "ap-northeast-2"]
}

resource "null_resource" "length_example" {
  provisioner "local-exec" {
    command = "echo 'Number of cloud zones: ${length(var.cloud_zones)}'"
  }
}


# 2. 응용 예제
# 보안 그룹 규칙 개수 세기: 
# - security_rule_count_example 리소스는 보안 그룹 규칙의 총 개수를 출력합니다.
# 서브넷 리스트 반복: 
# - subnet_iteration_example 리소스는 count를 사용해 network_subnets 리스트의 길이만큼 반복하여 각 서브넷 이름을 출력합니다.

variable "security_group_rules" {
  type    = list(string)
  default = ["allow_http", "allow_https", "allow_ssh"]
}

variable "network_subnets" {
  type    = list(string)
  default = ["subnet-a", "subnet-b", "subnet-c"]
}

# 예제 1: 보안 그룹 규칙 개수 세기
resource "null_resource" "security_rule_count_example" {
  provisioner "local-exec" {
    command = "echo 'Total security group rules: ${length(var.security_group_rules)}'"
  }
}

# 예제 2: 네트워크 서브넷 개수만큼 반복
resource "null_resource" "subnet_iteration_example" {
  count = length(var.network_subnets)

  provisioner "local-exec" {
    command = "echo 'Configuring subnet: ${var.network_subnets[count.index]}'"
  }
}
