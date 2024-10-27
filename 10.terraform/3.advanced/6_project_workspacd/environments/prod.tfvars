# 기본 환경 변수
environment          = "production"
desired_server_count = 4

# VPC 및 네트워크 설정
vpc_cidr_block          = "10.2.0.0/16"
subnet_count            = 4
public_subnet_cidr_blocks = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24", "10.2.4.0/24"]
availability_zones      = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"]

# 공통 태그
common_tags = {
  Project     = "MyProject"
  Environment = "production"
}
