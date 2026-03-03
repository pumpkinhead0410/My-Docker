#!/bin/bash

while :
do
    read -p "Enter login id:" MY_NAME
    read -p "Enter target ip address:" IP_ADDR
    echo "ssh "${MY_NAME}"@"${IP_ADDR}
    read -p "Do you want to continue? [Y/n]" answer
    if [[ $answer = "Y" ]]
    then
        break
    fi
done

echo 'PARAM:' $0
RELATIVE_DIR=`dirname "$0"`
echo 'Dir:' $RELATIVE_DIR

cd $RELATIVE_DIR
SHELL_PATH=`pwd -P`
echo 'shell : ' $SHELL_PATH

DIR="$( cd "$( dirname "$0" )" && pwd -P )"
echo $DIR