#!bin/bash

# DEPRECATED

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt update
sudo apt install -y nvidia-docker2
read -p "Press enter to restart docker"
sudo systemctl restart docker

# test
echo "[Docker run test..]"
docker run --rm hello-world
read -p "Press enter to continue"
echo "[Docker nvidia runtime test..]"
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
read -p "Press enter to continue"

docker rmi hello-world nvidia/cuda:11.0-base