# 설명: count를 사용해 동일한 null_resource 인스턴스를 3개 생성합니다. 
# count.index를 통해 각 인스턴스의 번호를 출력합니다.

# Terraform에서 count는 특별한 예약 변수로, 특정 리소스 블록이 여러 인스턴스로 복제되도록 제어하는 고유 변수입니다. 
# count는 리소스 블록의 인스턴스 개수를 결정하며, 인스턴스마다 고유한 count.index 값을 제공합니다.

# 1. 기본 예제
resource "null_resource" "count_example" {
  count = 3

  provisioner "local-exec" {
    command = "echo 'Creating cloud resource instance ${count.index}'"
  }
}

# Terraform에서 count를 사용하여 리소스를 여러 개 생성할 때, 각 리소스의 생성 순서는 보장되지 않습니다. 
# 특히 provisioner는 Terraform의 리소스 생성을 통한 인프라 프로비저닝이 완료된 후 명령을 비동기로 실행할 수 있습니다. 이로 인해 count를 사용하여 리소스를 동시에 여러 개 생성할 경우, 각 인스턴스에 대한 provisioner 명령은 병렬로 실행될 수 있습니다.


# 2. 활용 예제
# 기본 2개가 있는데, 숫자를 5로 늘리면 3개 추가
# terraform apply -var="num_instances=5" --auto-approve
# 5개에서 다시 3개로 줄이면 2개 삭제됨
# terraform apply -var="num_instances=3" --auto-approve

variable "num_instances" {
  type    = number
  default = 2
}

resource "null_resource" "count_example2" {
  count = var.num_instances

  provisioner "local-exec" {
    command = "echo 'Creating instance ${count.index + 1}'"
  }
}
