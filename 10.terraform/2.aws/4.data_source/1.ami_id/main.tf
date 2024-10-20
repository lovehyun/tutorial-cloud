# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami_ids

# -----------------------
# 1. 최신 아마존 리눅스 id 조회
provider "aws" {
  region = "ap-northeast-2"
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

output "ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

# terraform plan / apply
# 이 명령을 실행하면 최신 Amazon Linux 2 AMI의 ID가 출력됩니다.

# -----------------------
# 2. Ubuntu 이미지를 조회
data "aws_ami" "all_ubuntu_ami" {
  owners = ["099720109477"] # Canonical(우분투 제공자)의 AWS ID

  filter {
    name   = "name"
    values = ["ubuntu/images/*"]
  }

  most_recent = true # 최근 하나만 가져옴
}

output "recent_ubuntu_ami_id" {
  value = data.aws_ami.all_ubuntu_ami.id
}

output "recent_ubuntu_ami_name" {
  value = data.aws_ami.all_ubuntu_ami.name
}

# -----------------------
# 3. 여러개의 Ubuntu 이미지를 조회
# AMI를 여러 개 조회할 수 있도록 필터 조건을 설정
data "aws_ami" "ubuntu_ami" {
  for_each = toset(["22.04", "22.10", "23.04"]) # 원하는 Ubuntu 버전

  owners = ["099720109477"] # Canonical의 AWS ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-${each.value}-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  most_recent = true
}

# AMI ID 리스트 출력
output "ubuntu_ami_list" {
  value = [for ami in data.aws_ami.ubuntu_ami : ami.id]
}

output "ubuntu_ami_list2" {
  value = [
    for ami in data.aws_ami.ubuntu_ami :
    {
      id   = ami.id,
      name = ami.name
    }
  ]
}
