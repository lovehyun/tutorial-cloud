# 확장 정책 (예: CPU 사용률이 60% 이상일 때 확장)
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale_out"
  scaling_adjustment      = 1
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  autoscaling_group_name  = aws_autoscaling_group.web_asg.name

  metric_aggregation_type = "Average"
}

# 축소 정책 (예: CPU 사용률이 20% 이하일 때 축소)
resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale_in"
  scaling_adjustment      = -1
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  autoscaling_group_name  = aws_autoscaling_group.web_asg.name

  metric_aggregation_type = "Average"
}
