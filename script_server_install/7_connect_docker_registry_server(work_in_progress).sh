#!/bin/bash

REGISTRY_ENDPOINT="${REGISTRY_ENDPOINT:-<registry_host>:5000}"

# /etc/docker/ 에 daemon.json이 없다면 nvidia-docker 가 설치되지 않았을 수 있다. 설치 됐는지 확인하자
# daemon.json 수정
sudo vi /etc/docker/daemon.json
# [daemon.json] 예시
# {
    # "insecure-registries" : ["<registry_host>:5000"],
    # "default-runtime" : "nvidia",
#     "runtimes": {
#         "nvidia": {
#             "path": "nvidia-container-runtime",
#             "runtimeArgs": []
#         }
#     }
# }

# 도커 재시작
sudo service docker restart

# 세팅 됐는지 확인
docker info
read -p "Press enter to continue"

# docker-registry 연결 확인
docker pull ${REGISTRY_ENDPOINT}/hello-world
docker images
read -p "Press enter to continue"

docker rmi ${REGISTRY_ENDPOINT}/hello-world