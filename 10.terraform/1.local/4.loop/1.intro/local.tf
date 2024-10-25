variable "instance_ids" {
  type    = list(string)
  default = ["i-1234567890", "i-456789012", "i-789012345"]
}

# locals는 Terraform에서 반복 사용하거나 계산이 필요한 값을 정의하고 재사용할 때 유용한 블록입니다. locals 블록 내에 변수를 정의하여 해당 값이 필요한 곳에서 간결하게 참조할 수 있으며, 여러 리소스에서 동일한 계산 결과나 값을 사용해야 할 때 편리합니다.
# locals 사용 예시 및 특징
# - 계산된 값 저장: 반복해서 사용할 계산 결과나 조합된 값을 저장합니다.
# - 코드의 가독성 향상: 복잡한 표현식을 간결하게 관리할 수 있어, 가독성이 향상됩니다.
# - 유지보수 용이성: 자주 사용되는 값들을 한 곳에서 정의하여 코드 유지보수를 쉽게 합니다.

locals {
  primary_instance_id = local.instance_ids[0]
  all_instance_count  = length(var.instance_ids)
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Primary instance: ${local.primary_instance_id}, Total instances: ${local.all_instance_count}'"
  }
}
