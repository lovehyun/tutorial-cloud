provider "aws" {
  region = "us-east-1"
}

# 기본 VPC 가져오기
data "aws_vpc" "selected" {
  default = true
}

# 선택된 VPC의 모든 서브넷 ID 가져오기
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# 각 서브넷의 정보를 가져오기 위해 for_each를 사용하여 데이터 소스를 설정
data "aws_subnet" "selected" {
  for_each = toset(data.aws_subnets.selected.ids)
  id       = each.key
}

# 각 서브넷의 ID와 이름을 매핑하는 로컬 변수 정의
locals {
  subnet_info = { for s in data.aws_subnet.selected : s.id => lookup(s.tags, "Name", "No Name") }
  subnet_names_sorted = sort([for s in data.aws_subnet.selected : lookup(s.tags, "Name", "No Name")])
}

output "subnet_info" {
  value = local.subnet_info
}

output "subnet_ids" {
  value = data.aws_subnets.selected.ids
}

output "subnet_names" {
  value = local.subnet_names_sorted
}
