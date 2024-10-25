# 설명: tomap을 사용해 리스트를 맵으로 변환하여 서비스 정보를 출력합니다.

variable "service_pairs" {
  type    = list(string)
  default = ["compute=EC2", "storage=S3", "function=Lambda"]
}

# 리스트를 map으로 변환
locals {
  service_map = tomap({
    for pair in var.service_pairs :
    split("=", pair)[0] => split("=", pair)[1]
  })
}

resource "null_resource" "tomap_example" {
  provisioner "local-exec" {
    command = "echo 'Service map: Compute=${local.service_map["compute"]}, Storage=${local.service_map["storage"]}, Function=${local.service_map["function"]}'"
  }
}
