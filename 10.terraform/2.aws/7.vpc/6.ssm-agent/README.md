# SSM-Agent 설치

## 아래는 없다고 나옴 (24.04 기준)

```bash
sudo apt-get install -y amazon-ssm-agent

systemctl status amazon-ssm-agent

curl "https://s3.amazonaws.com/amazon-ssm-us-east-1/latest/debian_amd64/amazon-ssm-agent.deb" -o "amazon-ssm-agent.deb"

sudo dpkg -i amazon-ssm-agent.deb
```

## 아래 방식으로 추가 및 설정 (24.04 기준)

```bash
sudo snap install amazon-ssm-agent --classic
snap "amazon-ssm-agent" is already installed, see 'snap help refresh'

sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service

sudo systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service

systemctl status snap.amazon-ssm-agent.amazon-ssm-agent.service
```

# 테라폼 설정

## Web/WAS 에 IAM 권한 추가

resource "aws_instance" "web" {
  ami                         = var.ami_id                # Ubuntu AMI ID
  instance_type               = var.instance_type         # Instance type
  subnet_id                   = var.public_subnet_id      # Public subnet ID
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name  # SSM 접근 권한 적용

  tags = {
    Name = "web_server"
  }
}
