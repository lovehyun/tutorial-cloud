provider "aws" {
  region = var.region # 리전 변수를 사용
}

module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_az    = var.public_subnet_az
  private_subnet_az   = var.private_subnet_az
}

module "webserver" {
  source = "./modules/webserver"

  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id

  ssm_instance_profile_name = aws_iam_instance_profile.ssm_instance_profile.name
}

module "was" {
  source = "./modules/was"

  # VPC 및 서브넷 관련 변수 전달
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id

  # Web 서버 서브넷 CIDR 전달 (Web 서버에서 WAS 서버로 SSH 접근 허용)
  web_subnet_cidr_block = var.public_subnet_cidr

  # 가용 영역 및 EBS 크기 설정
  availability_zone = var.private_subnet_az
  ebs_size          = "10"

  ssm_instance_profile_name = aws_iam_instance_profile.ssm_instance_profile.name
}

module "bastion" {
  source = "./modules/bastion"

  vpc_id           = module.vpc.vpc_id           # VPC ID
  public_subnet_id = module.vpc.public_subnet_id  # 퍼블릭 서브넷 ID
  key_name         = "my-nginx"                # SSH 키 페어
}

