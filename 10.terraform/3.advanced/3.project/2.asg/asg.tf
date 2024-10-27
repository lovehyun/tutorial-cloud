# Auto Scaling Group 생성
resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

  min_size = 2  # 최소 서버 개수
  max_size = 4  # 최대 서버 개수
  desired_capacity = 2  # 처음에 배포할 서버 개수

  vpc_zone_identifier = var.subnet_ids  # 사용할 서브넷 목록
  target_group_arns   = [aws_lb_target_group.web_target_group.arn]  # (선택적) 로드 밸런서와 연동 가능

  tag {
    key                 = "Name"
    value               = "WebServer"
    propagate_at_launch = true
  }

  health_check_type = "EC2"
  health_check_grace_period = 300

  lifecycle {
    ignore_changes = [desired_capacity]  # ASG가 자동으로 조정할 수 있도록 설정
  }
}
