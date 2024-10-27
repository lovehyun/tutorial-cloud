module "vpc" {
  source                  = "../../modules/vpc"
  vpc_cidr_block          = "10.1.0.0/16"
  subnet_count            = 3
  public_subnet_cidr_blocks = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  availability_zones      = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  environment             = var.environment
  tags                    = var.common_tags
}

module "web_server" {
  source               = "../../modules/web_server"
  desired_server_count = var.desired_server_count
  vpc_id               = module.vpc.vpc_id  # vpc 모듈의 vpc_id 출력값을 참조
  # ami_id               = "ami-123456"
  ami_id               = "ami-040c33c6a51fd5d96" # ap-northeast-2, ubuntu 24.04
  instance_type        = "t3.small"
  public_subnet_ids    = module.vpc.public_subnet_ids
  environment          = var.environment
  tags                 = var.common_tags
}

output "web_server_details" {
  value = module.web_server.web_server_details
}
