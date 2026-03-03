#!/bin/bash

# root 유저의 초기 패스워드 설정
sudo passwd

su -
# root 유저의 ssh 접근 권한 설정
# do some vi editting
vi /etc/ssh/sshd_config
# PermitRoolLogin yes 

service ssh restart
# restart 완료 후, ssh 연결 종료한 뒤 root 로 다시 로그인