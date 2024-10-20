# 모듈 설명
이 모듈은 AWS의 기본 VPC에 EC2 인스턴스를 생성하고, 포트 80을 허용하는 보안 그룹을 설정합니다. 인스턴스는 Amazon Linux 2 AMI를 사용하며, User Data 스크립트를 통해 웹 서버(httpd)를 자동으로 설치하고 시작합니다.

## 사용 방법

### 변수 정의
- **name**: 인스턴스에서 출력할 사용자 이름 (기본값: `Terraform User`)
- **environment**: 인스턴스가 실행되는 환경 이름 (기본값: `production`)

### 템플릿 파일 (`userdata.tpl`)
- `userdata.tpl` 파일은 EC2 인스턴스에서 실행될 초기화 스크립트를 정의합니다.
- 웹 서버를 설치하고, 인스턴스에 접속하면 `Hello, ${name}! Welcome to the ${environment} environment.`라는 메시지가 표시됩니다.

### 보안 그룹
- 포트 80(HTTP)을 허용하는 보안 그룹이 자동으로 생성되어 인스턴스에 연결됩니다.

## Terraform 명령어
- `terraform init`: Terraform 모듈 초기화
- `terraform plan`: 인프라 배포 계획 확인
- `terraform apply`: 인프라를 실제로 배포

## 출력 값
- **instance_public_ip**: 생성된 EC2 인스턴스의 퍼블릭 IP 주소
- **security_group_id**: 생성된 보안 그룹의 ID

## 유지보수 방법
- **변수 조정**: `variables.tf` 파일을 수정하여 인스턴스의 이름이나 환경을 쉽게 변경할 수 있습니다.
- **템플릿 변경**: `userdata.tpl` 파일에서 초기화 스크립트를 수정하여 인스턴스 설정을 유연하게 변경할 수 있습니다.
