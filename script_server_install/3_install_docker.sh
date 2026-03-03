#!/bin/bash

# pakage download
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
# add Docker GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add 
# GPG key check (optional)
sudo apt-key fingerprint 0EBFCD88
echo "[Please check public key - (0EBF CD88)]"
read -p "Press enter to continue"
# add Docker reposiroty
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
# Active status check (optional)
echo "[Please check docker active status]"
echo -e "\033[43;31m[Press q or Ctrl + C if docker status is active]\033[0m"
sudo systemctl status docker
