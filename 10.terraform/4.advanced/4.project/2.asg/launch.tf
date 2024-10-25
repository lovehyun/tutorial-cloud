# Launch Template 생성 (EC2 인스턴스 배포 설정)
resource "aws_launch_template" "web_launch_template" {
  name_prefix   = "web-server"
  image_id      = "ami-123456"  # 실제 AMI ID로 변경
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.subnet_ids[0]  # 첫 번째 서브넷 사용
    security_groups             = [aws_security_group.web_sg.id]  # 보안 그룹 설정
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "WebServer"
    }
  }
}
