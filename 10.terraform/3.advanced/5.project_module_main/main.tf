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
  region = "ap-northeast-2"
}

# Development 환경 모듈 호출 (environment가 'development'일 때만 생성)
module "dev_vpc" {
  source                   = "./modules/vpc"
  count                    = var.environment == "development" ? 1 : 0
  vpc_cidr_block           = "10.0.0.0/16"
  subnet_count             = 2
  public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones       = ["ap-northeast-2a", "ap-northeast-2c"]
  environment              = "development"
  tags                     = var.common_tags
}

module "dev_web_server" {
  source               = "./modules/web_server"
  count                = var.environment == "development" ? 1 : 0
  vpc_id               = module.dev_vpc[0].vpc_id
  desired_server_count = 2
  ami_id               = "ami-123456"
  instance_type        = "t3.micro"
  public_subnet_ids    = module.dev_vpc[0].public_subnet_ids
  environment          = "development"
  tags                 = var.common_tags
}

# Staging 환경 모듈 호출 (environment가 'staging'일 때만 생성)
module "staging_vpc" {
  source                   = "./modules/vpc"
  count                    = var.environment == "staging" ? 1 : 0
  vpc_cidr_block           = "10.1.0.0/16"
  subnet_count             = 3
  public_subnet_cidr_blocks = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  availability_zones       = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  environment              = "staging"
  tags                     = var.common_tags
}

module "staging_web_server" {
  source               = "./modules/web_server"
  count                = var.environment == "staging" ? 1 : 0
  vpc_id               = module.staging_vpc[0].vpc_id
  desired_server_count = 3
  ami_id               = "ami-123456"
  instance_type        = "t2.micro"
  public_subnet_ids    = module.staging_vpc[0].public_subnet_ids
  environment          = "staging"
  tags                 = var.common_tags
}

# Production 환경 모듈 호출 (environment가 'production'일 때만 생성)
module "prod_vpc" {
  source                   = "./modules/vpc"
  count                    = var.environment == "production" ? 1 : 0
  vpc_cidr_block           = "10.2.0.0/16"
  subnet_count             = 4
  public_subnet_cidr_blocks = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24", "10.2.4.0/24"]
  availability_zones       = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"]
  environment              = "production"
  tags                     = var.common_tags
}

module "prod_web_server" {
  source               = "./modules/web_server"
  count                = var.environment == "production" ? 1 : 0
  vpc_id               = module.prod_vpc[0].vpc_id
  desired_server_count = 4
  ami_id               = "ami-123456"
  instance_type        = "t2.micro"
  public_subnet_ids    = module.prod_vpc[0].public_subnet_ids
  environment          = "production"
  tags                 = var.common_tags
}
