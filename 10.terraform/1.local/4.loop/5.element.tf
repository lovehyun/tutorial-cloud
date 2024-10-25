# 설명: element를 사용해 첫 번째 데이터베이스 인스턴스를 출력합니다.

variable "db_instances" {
  type    = list(string)
  default = ["db-instance1", "db-instance2", "db-instance3"]
}

resource "null_resource" "element_example" {
  provisioner "local-exec" {
    command = "echo 'Primary DB instance: ${element(var.db_instances, 0)}'"
  }
}

resource "null_resource" "element_loop_example" {
  count = length(var.db_instances)
  provisioner "local-exec" {
    command = "echo 'DB instance ${count.index}: ${element(var.db_instances, count.index)}'"
  }
}
