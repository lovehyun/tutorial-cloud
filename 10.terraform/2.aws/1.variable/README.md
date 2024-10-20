1. 변수의 기본 개념

변수는 Terraform 구성에서 동적으로 사용될 수 있는 값을 정의하는 방법입니다. 이를 통해 코드의 하드코딩을 줄이고, 외부 입력을 받아 코드의 동작을 제어할 수 있습니다.

```
variable "<variable_name>" {
  description = "설명"
  type        = <data_type>
  default     = <default_value>
}
```

- <variable_name>: 변수를 참조할 때 사용할 이름.
- description: 변수에 대한 설명을 추가할 수 있습니다. 이는 선택 사항입니다.
- type: 변수의 데이터 타입을 지정합니다. 예: string, number, list, map 등.
- default: 변수가 주어지지 않았을 때 사용할 기본값을 정의합니다.


2. 변수 타입
변수는 다양한 데이터 타입을 가질 수 있습니다:

- string: 문자열 값. 예: "hello", "us-west-2"
- number: 숫자 값. 예: 10, 3.14
- bool: true 또는 false의 불리언 값.
- list: 리스트(배열) 값. 예: ["item1", "item2", "item3"]
- map: 키-값 쌍을 갖는 해시 맵. 예: { key1 = "value1", key2 = "value2" }
- object: 복잡한 구조를 가진 객체를 정의할 수 있습니다.

3. 변수 사용 방법
Terraform에서 변수를 사용하려면, 변수 이름을 ${} 구문으로 참조합니다.

==========

# 입력 인자를 통한 변수 설정
terraform plan -var="instance_type=t3.medium" -var="instance_settings=[\"t3.medium\", 50, false]" -var="allowed_ip_addresses=[\"192.168.1.3/32\", \"192.168.1.4/32\"]"

terraform apply -var="instance_type=t3.medium" -var="instance_settings=[\"t3.medium\", 50, false]" -var="allowed_ip_addresses=[\"192.168.1.3/32\", \"192.168.1.4/32\"]"


# 환경 변수 파일을 통한 변수값 설정
terraform plan -var-file="dev.tfvars"    # 개발 환경 계획
terraform plan -var-file="prod.tfvars"   # 프로덕션 환경 계획

----------

# Output 변수 선언
output "<output_name>" {
    value = <expression>
}

<output_name>: 출력 변수의 이름 (예: instance_id, instance_ip 등).
value: 출력할 값, 그리고 표현식 (예: aws_instance.example.id, aws_instance.example.public_ip).

