# 기본 환경 변수
environment          = "staging"
desired_server_count = 3

# VPC 및 네트워크 설정
vpc_cidr_block          = "10.1.0.0/16"
subnet_count            = 3
public_subnet_cidr_blocks = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
availability_zones      = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]

# 공통 태그
common_tags = {
  Project     = "MyProject"
  Environment = "staging"
}
