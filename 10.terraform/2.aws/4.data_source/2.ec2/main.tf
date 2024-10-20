# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instances

provider "aws" {
  region = "ap-northeast-2"
}

# ----------------------------------
# 1. 특정 인스턴스 조회
data "aws_instance" "example" {
  instance_id = "i-055d49dac40e51644"
}

# 인스턴스의 상태를 출력
output "instance_state" {
  value = data.aws_instance.example.instance_state
}

# 인스턴스의 'Name' 태그 값을 출력
output "instance_name_tag" {
  value = lookup(data.aws_instance.example.tags, "Name", "No Name Tag")
}

# ----------------------------------
# aws ec2 describe-instances --filters "Name=tag:Name,Values=MyWEB" --region ap-northeast-2
# 2. 특정 태그 인스턴스 조회

# 특정 태그를 가진 EC2 인스턴스를 조회
data "aws_instances" "example2" {
  filter {
    name   = "tag:Name"
    values = ["MyWEB"] # EC2 인스턴스에 설정된 태그 값
  }
  instance_state_names = ["running", "stopped"] # 기본값이 running 임
}

# 여러 인스턴스가 조회될 수 있기 때문에, 개별 인스턴스를 출력
output "ec2_instance_list" {
    value = data.aws_instances.example2.ids
}

# 추가로, 개별 인스턴스의 이름을 태그에서 가져와 출력하려면 aws_instance를 반복해서 사용
data "aws_instance" "details" {
  for_each = toset(data.aws_instances.example2.ids)

  instance_id = each.key
}

output "ec2_instance_details" {
  value = [
    for instance in data.aws_instance.details :
    {
      id   = instance.id,
      name = lookup(instance.tags, "Name", "No Name")
    }
  ]
}
