# 프로젝트 개발 순서
Root -> Module -> Environment

```bash
project_module/
├── main.tf                  # 프로바이더 설정 파일
├── variables.tf             # 공통 변수 선언 파일
├── common_tags.tfvars       # 공통 태그 및 환경 변수 값 파일
```

1. main.tf: 프로바이더 설정 파일
main.tf 파일은 프로젝트에서 사용될 Terraform 버전과 AWS 프로바이더 버전을 지정하며, **프로바이더에 필요한 기본 설정(리전)**을 정의합니다. 이 파일은 모든 환경에서 공통으로 적용됩니다.

2. variables.tf: 공통 변수 선언 파일
variables.tf 파일은 공통 변수와 태그를 정의합니다. common_tags와 같은 공통 변수를 선언하여 각 환경에서 참조할 수 있도록 합니다.

3. common_tags.tfvars: 공통 태그 및 환경 변수 값 파일
common_tags.tfvars 파일은 공통 태그의 실제 값을 정의하여 각 환경에서 일관되게 사용할 수 있도록 합니다.


```bash
project_module/
├── main.tf                        # 최상위 프로바이더 설정 파일
├── variables.tf                   # 공통 변수 선언 파일
├── common_tags.tfvars             # 공통 태그 및 환경 변수 값 파일
├── environments/                  # 환경별 디렉터리
│   ├── development/
│   │   ├── main.tf                # 개발 환경 설정 파일
│   │   └── dev.tfvars             # 개발 환경별 변수 파일
│   ├── staging/
│   │   ├── main.tf                # 스테이징 환경 설정 파일
│   │   └── staging.tfvars         # 스테이징 환경별 변수 파일
│   └── production/
│       ├── main.tf                # 프로덕션 환경 설정 파일
│       └── prod.tfvars            # 프로덕션 환경별 변수 파일
└── modules/                       # 모듈 디렉터리
    ├── vpc/
    │   ├── main.tf                # VPC 모듈 설정 파일
    │   ├── variables.tf           # VPC 모듈 변수 파일
    │   └── outputs.tf             # VPC 모듈 출력 파일
    └── web_server/
        ├── main.tf                # 웹 서버 모듈 설정 파일
        ├── variables.tf           # 웹 서버 모듈 변수 파일
        └── outputs.tf             # 웹 서버 모듈 출력 파일
```

# 개발 환경 (Development)에서 실행하는 명령어

```bash
# 1. 개발 환경 디렉터리로 이동
cd project_module/environments/development

# 2. Terraform 초기화
terraform init

# 3. 실행 계획 확인 (plan)
terraform plan -var-file="../../common_tags.tfvars" -var-file="dev.tfvars"

# 4. 구성 적용 (apply)
terraform apply -var-file="../../common_tags.tfvars" -var-file="dev.tfvars" --auto-approve

# 5. 인프라 삭제 (destroy)
terraform destroy -var-file="../../common_tags.tfvars" -var-file="dev.tfvars" --auto-approve
```


# 스테이징 환경 (Staging)에서 실행하는 명령어

```bash
# 1. 스테이징 환경 디렉터리로 이동
cd project_module/environments/staging

# 2. Terraform 초기화
terraform init

# 3. 실행 계획 확인 (plan)
terraform plan -var-file="../../common_tags.tfvars" -var-file="staging.tfvars"

# 4. 구성 적용 (apply)
terraform apply -var-file="../../common_tags.tfvars" -var-file="staging.tfvars" --auto-approve

# 5. 인프라 삭제 (destroy)
terraform destroy -var-file="../../common_tags.tfvars" -var-file="staging.tfvars" --auto-approve
```
