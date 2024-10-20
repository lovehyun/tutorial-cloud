/*

# 이론1
<block> <parameter> {
	key1 = "value1"
	key2 = "value2"
}

# 이론2
resource "<리소스_타입>" "<리소스_이름>" {
  # 리소스의 속성
  key1 = "value1"
  key2 = "value2"
}

리소스 타입: 예를 들어, aws_instance, azurerm_virtual_machine처럼 어떤 종류의 인프라 리소스를 정의할지 나타냅니다.
리소스 이름: 사용자가 정의한 고유한 이름으로, 해당 리소스를 다른 곳에서 참조할 때 사용됩니다.
속성(Attributes): 리소스의 설정값이며, 리소스가 어떻게 동작할지 정의합니다.

# 이론3
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-123456"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}

output "instance_id" {
  value = aws_instance.example.id
}

provider "aws": AWS에 연결하기 위해 AWS 프로바이더를 설정하고, 리전을 지정합니다.
resource "aws_instance" "example": ami와 instance_type을 설정하여 EC2 인스턴스를 정의합니다.
ami: 사용할 Amazon Machine Image (AMI) ID를 지정합니다.
instance_type: EC2 인스턴스 유형을 t2.micro로 지정합니다.
tags: 인스턴스에 태그를 붙일 수 있습니다.
output "instance_id": 생성된 인스턴스의 ID를 출력합니다.

*/
