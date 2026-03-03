# script 실행 허가명령어 (관리자로 실행 필요)
# Set-ExecutionPolicy AllSigned

# ssh 키 등록
# while :
# do
#     read -p "Enter login id:" MY_NAME
#     read -p "Enter target ip address:" IP_ADDR
#     echo "ssh "${MY_NAME}"@"${IP_ADDR}
#     read -p "Do you want to continue? [Y/n]" answer
#     if [[ $answer = "Y" ]]
#     then
#         break
#     fi
# done

cat ./.ssh/id_rsa.pub | ssh <target_user>@<target_ip> "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys"
