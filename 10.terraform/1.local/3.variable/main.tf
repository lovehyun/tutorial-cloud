provider "local" {}

# local_file 리소스를 사용하여 pets.txt 파일을 생성
resource "local_file" "pets" {
  filename = var.filename

  # content 변수로 펫 이름을 리스트 형태로 받아와서 파일에 기록
  #   content  = var.contents
  content  = join("\n", var.contents)
}
