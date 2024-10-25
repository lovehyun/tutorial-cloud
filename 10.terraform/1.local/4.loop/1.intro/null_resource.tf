# null_resource는 Terraform에서 제공하는 리소스 유형 중 하나로, 실제 리소스를 생성하지 않고도 Terraform의 리소스 생성을 흉내낼 수 있는 가상의 리소스입니다. 
# 즉, 클라우드 리소스와 같은 외부 시스템과 상호작용하지 않으면서도, Terraform의 상태 파일에서 리소스처럼 다뤄집니다.

# null_resource는 다음과 같은 상황에서 유용합니다:
# 1. 로컬 스크립트 실행: 특정 스크립트를 실행하고 싶지만, 실제로 리소스를 생성할 필요가 없을 때 사용합니다. 예를 들어, 서버를 설정하거나 환경에 따라 동적으로 값을 계산해야 할 때 provisioner 블록과 함께 사용할 수 있습니다.
# 2. 트리거로 사용: null_resource는 triggers라는 특수 필드를 사용해, 특정 값이 변경될 때마다 리소스를 다시 생성하게 만들 수 있습니다. 이는 Terraform의 의존성 그래프에서 리소스 간의 관계를 설정할 때 유용합니다.
# 3. 단순 논리 흐름 관리: 반복문이나 조건문에서 리소스 자체가 필요하지 않은데도 해당 구조를 테스트하고 싶을 때 사용됩니다.

# null_resource의 주요 구성 요소
# - provisioner: local-exec 또는 remote-exec을 통해 쉘 스크립트를 실행하거나 명령어를 실행할 수 있습니다.
# - triggers: 특정 값이나 조건이 변경되었을 때 null_resource가 다시 실행되도록 만듭니다.


# 기본
resource "null_resource" "null_example" {
  # 트리거 정의
  triggers = {
    custom_key = "custom-key"
  }

  # 프로비저너 사용 예시
  provisioner "local-exec" {
    command = "echo 'Triggered with custom_key = ${self.triggers.custom_key}'"
  }
}



# terraform apply -var="custom_key=new_value"

variable "custom_key" {
  type    = string
  default = "initial_value"
}

resource "null_resource" "null_example2" {
  # 트리거 정의
  triggers = {
    custom_key = var.custom_key
  }

  # 프로비저너 사용 예시
  provisioner "local-exec" {
    command = "echo 'Triggered with custom_key = ${var.custom_key}'"
  }
}
