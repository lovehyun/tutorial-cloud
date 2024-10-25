# 설명: tolist를 사용해 set을 list로 변환한 후 출력합니다.
# set: 순서가 보장되지 않습니다. 따라서 set을 사용할 때 각 요소의 위치는 불확실합니다.
# list: 순서가 고정되어 있어, 순차적으로 접근할 수 있습니다.

variable "security_groups_set" {
  type    = set(string)
  default = ["sg-1", "sg-2", "sg-3"]
}

resource "null_resource" "tolist_example" {
  provisioner "local-exec" {
    command = "echo 'Security groups: ${join(", ", tolist(var.security_groups_set))}'"
  }
}
