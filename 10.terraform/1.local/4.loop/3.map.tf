# 설명: map을 사용해 컴퓨팅, 스토리지, 컨테이너 서비스와 관련된 클라우드 자원 정보를 출력합니다.

# 1. 기본 예제
variable "service_regions" {
  type = map(string)
  default = {
    ec2     = "us-west-1"
    s3      = "us-east-1"
    rds     = "eu-central-1"
  }
}

resource "null_resource" "map_example" {
  provisioner "local-exec" {
    command = "echo 'EC2 region: ${var.service_regions["ec2"]}, S3 region: ${var.service_regions["s3"]}, RDS region: ${var.service_regions["rds"]}'"
  }
}


# 2. 추가 예제

# variables.tf
variable "instance_ids" {
  type = map(string)
  default = {
    ec2_main     = "i-1234567890"
    ec2_backup   = "i-4567890123"
    ec2_testing  = "i-7890123456"
  }
}

# main.tf
resource "null_resource" "map_example2" {
  provisioner "local-exec" {
    command = "echo 'Primary EC2 ID: ${var.instance_ids["ec2_main"]}, Backup EC2 ID: ${var.instance_ids["ec2_backup"]}, Testing EC2 ID: ${var.instance_ids["ec2_testing"]}'"
  }
}
