#!/bin/bash
# 시스템 업데이트 및 Nginx 설치
apt-get update -y
apt-get install -y nginx

# Nginx 기본 웹 페이지에 환경별 메시지 추가
echo "Welcome to '${environment}' web server" > /var/www/html/index.html

# Nginx 서비스 시작 및 부팅 시 자동 시작 설정
systemctl start nginx
systemctl enable nginx
