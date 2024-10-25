# 최상위 디렉토리에 있는 iam.tf 파일
resource "aws_iam_role" "ssm_role" {
  name = "SSMAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "SSMInstanceProfile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

output "ssm_instance_profile_name" {
  value       = aws_iam_instance_profile.ssm_instance_profile.name
  description = "SSM instance profile name for EC2 instances"
}
