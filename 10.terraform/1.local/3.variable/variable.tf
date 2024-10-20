# 파일 경로 변수 정의
variable "filepath" {
  description = "The directory path where the file will be created"
  type        = string
  default     = "./"
}

# 파일 이름 변수 정의
variable "filename" {
  description = "The name of the file to write the pet names into"
  type        = string
  default     = "pets.txt"
}

# 펫 이름 리스트 변수 정의
variable "contents" {
  description = "A list of pet names to write into the file"
  type        = list(string)
  default     = ["Bella", "Charlie", "Max"]
}
