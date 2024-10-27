# 로드 밸런서 생성
resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = var.subnet_ids
}

# 타겟 그룹 생성
resource "aws_lb_target_group" "web_target_group" {
  name     = "web-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-123456"  # 실제 VPC ID로 변경

  health_check {
    protocol = "HTTP"
    path     = "/"
    port     = "traffic-port"
  }
}

# 로드 밸런서 리스너 생성
resource "aws_lb_listener" "web_lb_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_group.arn
  }
}
