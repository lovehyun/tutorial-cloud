# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group

provider "aws" {
  region = "ap-northeast-2"
}

# 모든 VPC 목록을 조회
data "aws_vpcs" "all_vpcs" {}

# 조회된 VPC 목록의 ID를 출력
output "vpc_ids" {
  value = data.aws_vpcs.all_vpcs.ids
}


# ----------------
# 2. 상세 정보 추가로 출력
# 각 VPC의 정보를 개별적으로 조회
data "aws_vpc" "details" {
  for_each = toset(data.aws_vpcs.all_vpcs.ids)
  id       = each.key
}

# VPC ID와 이름을 함께 출력
output "vpc_details" {
  value = [
    for vpc in data.aws_vpc.details :
    {
      id   = vpc.id,
      name = lookup(vpc.tags, "Name", "No Name")
    }
  ]
}
