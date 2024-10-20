resource "random_pet" "my-pets" {
    prefix = "Mr"
    separator = "."
    length = "5"
}

resource "random_integer" "my_number" {
    min = 100
    max = 1000
}

output "my_number" {
    value = random_integer.my_number.result
}

resource "random_string" "my_string" {
    length = 16
    special = false
}

resource "random_id" "my_id" {
    byte_length = 8
}

resource "random_password" "my_password" {
    length = 16
    special = true
}

resource "random_shuffle" "my_list" {
    input = ["one", "two", "three", "four", "five"]
}

output "shuffled_list" {
    value = random_shuffle.my_list.result
}
