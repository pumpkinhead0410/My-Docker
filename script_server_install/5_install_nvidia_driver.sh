#!/bin/bash

# add repositor
sudo apt-add-repository -y ppa:graphics-drivers/ppa
sudo apt update

# check recommended driver
sudo apt install -y ubuntu-drivers-common
echo -e "\033[43;31m[Searching recommended drivers... it takes some time]\033[0m"
ubuntu-drivers devices
echo "[Please enter recommended driver exectly]"
read nvidia_driver
read -p "Do you want to continue? [Y/n]" answer
if [ $answer != "Y" ]
then
    echo Abort
    exit
fi

# install
# NVIDIA_DRIVER="nvidia-driver-470" 
NVIDIA_DRIVER=$nvidia_driver
sudo apt install -y ${NVIDIA_DRIVER}

sudo apt update
sudo apt upgrade
read -p "Press enter to reboot"
sudo reboot

# 재부팅 후 nvidia-driver 버전 확인
# cat /proc/driver/nvidia/version