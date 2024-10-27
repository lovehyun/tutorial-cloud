# 기본 환경 변수
environment          = "development"
desired_server_count = 2

# VPC 및 네트워크 설정
vpc_cidr_block          = "10.0.0.0/16"
subnet_count            = 2
public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones      = ["ap-northeast-2a", "ap-northeast-2b"]

# 공통 태그
common_tags = {
  Project     = "MyProject"
  Environment = "development"
}
