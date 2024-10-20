#!/bin/bash
mkdir -p /var/www/html
echo "Hello, ${name}! Welcome to the ${environment} environment." > /var/www/html/index.html
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
