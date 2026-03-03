#!/bin/bash

cat /etc/passwd | grep /bin/bash

USERS="core_user proj_user03 proj_user01 proj_user05 proj_user04 proj_user02 proj_user06 unit_user01 unit_user02 unit_user03"

for i in $USERS
do
    sudo userdel -r $i
done

cat /etc/passwd | grep /bin/bash