terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"  # 사용할 AWS 리전
}

# main.tf에서 vpc 모듈 호출 시 추가

module "vpc" {
  source                  = "./modules/vpc"
  vpc_cidr_block          = var.vpc_cidr_block
  subnet_count            = var.subnet_count
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  availability_zones      = var.availability_zones
  environment             = var.environment
  tags                    = var.common_tags
}

module "web_server" {
  source               = "./modules/web_server"
  desired_server_count = var.desired_server_count
  vpc_id               = module.vpc.vpc_id        # VPC 모듈의 vpc_id 출력값을 참조
  ami_id               = "ami-040c33c6a51fd5d96"  # 적절한 AMI ID로 변경
  instance_type        = "t3.micro"               # 원하는 인스턴스 타입으로 설정
  public_subnet_ids    = module.vpc.public_subnet_ids
  environment          = var.environment
  tags                 = var.common_tags
}
