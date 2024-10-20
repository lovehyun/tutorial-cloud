# 문자열 타입의 변수 'instance_type' 선언
variable "instance_type" {
    type    = string            # 변수의 타입은 문자열(string)
    default = "t2.micro"        # 외부에서 값이 주어지지 않으면 "t2.micro"가 기본값으로 사용
}

# 튜플 타입의 변수 'instance_settings' 선언
variable "instance_settings" {
    type    = tuple([string, number, bool])  # 튜플의 각 요소 타입은 문자열, 숫자, 불리언
    default = ["t2.micro", 30, true]         # 기본값: "t2.micro" 인스턴스, 30GB 디스크, 모니터링 활성화
}

# 문자열 리스트 타입의 변수 'allowed_ip_addresses' 선언
variable "allowed_ip_addresses" {
    type    = list(string)                   # 문자열로 이루어진 리스트 타입
    default = ["192.168.1.1/32", "192.168.1.2/32"] # 기본적으로 허용할 IP 주소 목록
}
