#!/bin/bash

# 시스템 업데이트
sudo apt update -y

# EBS 볼륨 포맷 (XFS 파일 시스템으로 포맷)
sudo mkfs -t xfs /dev/xvdh

# /data 디렉토리 생성
sudo mkdir -p /data

# EBS 볼륨을 /data에 마운트 (배포판마다 /dev/xxxx 경로가 다름으로 확인 필요)
#sudo mount /dev/xvdh /data
sudo mount /dev/nvme1n1 /data

# fstab에 추가하여 인스턴스 재부팅 시 자동으로 마운트되도록 설정
#echo "/dev/xvdh /data xfs defaults,nofail 0 2" | sudo tee -a /etc/fstab
echo "/dev/nvme1n1 /data xfs defaults,nofail 0 2" | sudo tee -a /etc/fstab


# 사용자 정의 메시지를 홈 디렉토리의 README.txt 파일에 작성
echo "${custom_message}" | sudo tee /home/ubuntu/README.txt
