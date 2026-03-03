#!/bin/sh

REGISTRY_HOST="${REGISTRY_HOST:-<registry_host>}"
REGISTRY_PORT="${REGISTRY_PORT:-5000}"
REGISTRY_DATA_DIR="${REGISTRY_DATA_DIR:-/mnt/user/<shared_storage>/docker_server/volume/}"

docker run -d -p ${REGISTRY_PORT}:5000 --name registry-srv --restart=always -v $(pwd)/config.yml:/etc/docker/registry/config.yml:ro -v ${REGISTRY_DATA_DIR}:/var/lib/registry/docker/registry/v2 -e REGISTRY_HTTP_ADDR=0.0.0.0:5000 -e REGISTRY_STORAGE_DELETE_ENABLED=true registry:2.8.1

docker run -d --restart=always -e ENV_DOCKER_REGISTRY_HOST=${REGISTRY_HOST} -e ENV_DOCKER_REGISTRY_PORT=${REGISTRY_PORT} -e ENV_MODE_BROWSE_ONLY=true -p 8080:80 --name registry-web konradkleine/docker-registry-frontend:v2
