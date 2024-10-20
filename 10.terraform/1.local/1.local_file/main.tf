# 실습1
resource "local_file" "example" {
	filename = "./example.txt"
	content = "Hello, World!"
}

# 실습2
resource "local_file" "example" {
	filename = "./example.txt"
	content = "Hello, World!"
    file_permission = "0700"
}

# 실습 명령어
# terraform init
# terraform plan
# terraform apply
# terraform apply -auto-approve
# terraform destroy

# resource "local_file" "myfile" {
# 	filename = "./myfile.txt"
# 	content = "Hello, World!"
#   file_permission = "0700"
# }
