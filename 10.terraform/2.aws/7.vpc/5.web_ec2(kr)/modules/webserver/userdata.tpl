#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Custom message
echo "${custom_message}" | sudo tee /var/www/html/index.html
