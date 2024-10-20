# 변수의 참조
# var.<variable_name>

variable "instance_type" {
    type    = string
    default = "t2.micro"
}

variable "disk_size" {
    type    = number
    default = 30
}

resource "aws_instance" "example" {
    instance_type = var.instance_type  # var.instance_type 참조
    ami           = "ami-123456"

    root_block_device {
        volume_size = var.disk_size  # var.disk_size 참조
    }
}

