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
│   ├── dev.tfvars                 # 개발 환경별 변수 파일
│   ├── staging.tfvars             # 스테이징 환경별 변수 파일
│   └── prod.tfvars                # 프로덕션 환경별 변수 파일
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

# 워크스페이스(workspace) 생성

```bash
terraform workspace new development
terraform workspace new staging
terraform workspace new production
```


# 워크스페이스(workspace) 변경

```bash
terraform workspace select development  # 개발 환경
terraform workspace select staging      # 스테이징 환경
terraform workspace select production   # 프로덕션 환경
```


# 실제 적용
```bash
terraform init                             # 초기화
terraform workspace new development        # 'development' 워크스페이스 생성
terraform workspace select development     # 'development' 워크스페이스 선택
terraform apply -var-file="environments/dev.tfvars"     # 개발 환경에 맞게 인프라 적용
terraform destroy -var-file="environments/dev.tfvars"
```
