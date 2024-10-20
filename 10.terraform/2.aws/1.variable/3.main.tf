provider "aws" {
    region = "us-east-1"  # AWS 리전 설정
}

resource "aws_instance" "example" {
    instance_type = var.instance_type  # 변수로 인스턴스 타입 설정

    root_block_device {
        volume_size = var.instance_settings[1]  # 디스크 크기 설정
    }

    monitoring = var.instance_settings[2]  # 모니터링 설정

    ami = "ami-123456"  # AMI ID 설정
}

resource "aws_security_group" "example" {
    name        = "example_security_group"
    description = "Allow SSH inbound traffic"  # 보안 그룹 설명

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.allowed_ip_addresses  # 허용된 IP 주소 리스트
    }
}
