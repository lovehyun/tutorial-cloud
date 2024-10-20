variable "example_variable" {
    description = "This is an example variable"
    type        = string
    default     = "default_value"
}

variable "instance_type" {
    type    = string
    default = "t2.micro"
}


# 1. string: 문자열 변수
# string 타입은 일반적인 문자열 데이터를 처리할 때 사용합니다.
variable "name" {
    type = string
}

variable "environment" {
    type    = string
    default = "development"
}

# 2. number: 숫자 변수
# number 타입은 숫자 데이터를 처리할 때 사용합니다.
variable "instance_count" {
    type = number
}

variable "instance_count" {
    type    = number
    default = 2
}

# 3. bool: 불리언 변수 (참/거짓)
# bool 타입은 참(true) 또는 거짓(false)을 처리할 때 사용합니다.
variable "is_enabled" {
    type = bool
}

variable "enable_monitoring" {
    type    = bool
    default = true
}

# 4. list: 리스트(배열) 변수
# list 타입은 여러 개의 값을 배열 형태로 처리할 때 사용합니다.
variable "instance_types" {
    type = list(string)
}

variable "allowed_ip_addresses" {
    type    = list(string)
    default = ["192.168.1.1", "192.168.1.2"]
}

# 5. map: 맵(키-값) 변수
# map 타입은 키-값 쌍을 처리할 때 사용합니다.
variable "region_map" {
    type = map(string)
}

variable "region_map" {
    type    = map(string)
    default = {
        "us-east-1" = "ami-123456"
        "us-west-1" = "ami-789012"
    }
}

# 6. object: 객체형 변수
# object 타입은 더 복잡한 데이터 구조를 처리할 때 사용합니다.
variable "instance_details" {
    type = object({
        instance_type = string
        instance_size = number
    })
}

variable "instance_details" {
    type = object({
        instance_type = string
        instance_size = number
    })
    default = {
        instance_type = "t2.micro"
        instance_size = 30
    }
}

# 7. tuple 타입 선언
# tuple 타입은 고정된 길이와 각 요소에 대해 서로 다른 타입을 가질 수 있는 배열을 정의할 때 사용합니다. tuple은 리스트와 유사하지만, 리스트는 같은 타입의 요소들로 구성되며, tuple은 서로 다른 타입의 요소들이 함께 있을 수 있다는 점이 다릅니다.
variable "example_tuple" {
    type = tuple([string, number, bool])
    default = ["t2.micro", 30, true]
}
