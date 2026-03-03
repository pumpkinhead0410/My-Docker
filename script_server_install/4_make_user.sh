#!/bin/bash

# <"useradd" 명령어 option 설명>
# -m : create the user`s home directory (/home/[user])
# -U : create a group with the same name as ther user (추가로, primary group 으로 설정됨)
# -G : list of supplementary groups of the new account
# -u : user ID of the new account
# -g : name or ID of the primary group of the new account

# 제대로 유저 추가 됐는지 확인용함수
ask_to_keep_process(){
    cat /etc/passwd | grep /bin/bash
    read -p "Press enter to continue"
}

ask_to_keep_process

ADMIN="admin"
# develop 의 UID 를 1000으로 맞추기 위해 ADMIN UID 변경
sudo usermod -u 9999 ${ADMIN}
# 초기 어드민 유저의 그룹에 docker 추가
sudo usermod -aG docker ${ADMIN}

ask_to_keep_process

# 기본으로 사용하는 sub group
GRLIST="docker,sudo"

# default admin user
USER_NAME="core_user"
USER_UID="1000"
DEFAULT_PASSWD="ChangeMe123!"
sudo useradd -m -U -G ${GRLIST} -u ${USER_UID} -s /bin/bash  ${USER_NAME};
echo ${USER_NAME}:${DEFAULT_PASSWD} |sudo chpasswd;

ask_to_keep_process

OTEHR_USERS="unit_user01:1024 unit_user02:1025 unit_user03:1026"
# Other unit
for i in $OTEHR_USERS 
do
    # ":" 를 구분자로 하여 string split.
    # -d : delimeter
    # -t : 문자 끝에 오는 delimeter도 제거
    readarray -d : -t strarr <<< "$i"
    USER_NAME=${strarr[0]}
    USER_UID=${strarr[1]}
    DEFAULT_PASSWD=${USER_NAME}

	sudo useradd -m -U -G ${GRLIST} -u ${USER_UID} -s /bin/bash ${USER_NAME};
    echo ${USER_NAME}:${DEFAULT_PASSWD} |sudo chpasswd;
    
    # 추가된 그룹 확인
    groups ${USER_NAME}
done

ask_to_keep_process

# project unit
# 프로젝트 사용자 계정은 모두 admin 을 primary group 으로 설정하기 때문에 -U 옵션 제거, -g 옵션 사용
MA_USERS="proj_user01:1001 proj_user02:1009 proj_user03:1010 proj_user04:1012 proj_user05:1013 proj_user06:1023"
DEFAULT_GROUP="admin"
for i in $MA_USERS 
do
    readarray -d : -t strarr <<< "$i"
    USER_NAME=${strarr[0]}
    USER_UID=${strarr[1]}
    DEFAULT_PASSWD=${USER_NAME}

	sudo useradd -m -g ${DEFAULT_GROUP} -G ${GRLIST} -u ${USER_UID} -s /bin/bash ${USER_NAME};
	echo ${USER_NAME}:${DEFAULT_PASSWD} |sudo chpasswd;
    
    # 추가된 그룹 확인
    groups ${USER_NAME}
done

# 추가된 유저 확인
cat /etc/passwd | grep /bin/bash

