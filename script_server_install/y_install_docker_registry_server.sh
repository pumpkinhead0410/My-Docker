docker pull registry:2.8.1
docker pull konradkleine/docker-registry-frontend:v2

REGISTRY_BASE_DIR="${REGISTRY_BASE_DIR:-/mnt/user/<shared_storage>/docker_server}"
ADMIN_CFG_DIR="${ADMIN_CFG_DIR:-/admin_cfg/docker_server}"

cd  ${REGISTRY_BASE_DIR}/scripts4admin/
sudo bash ${REGISTRY_BASE_DIR}/scripts4admin/server_start.sh

# crontab 설정 (자동 gc)
sudo crontab -e
# 0 0 1,15 * * nohup ${ADMIN_CFG_DIR}/call_gc_in_server.sh > ${REGISTRY_BASE_DIR}/log/run_gc.out

sudo mkdir -p ${ADMIN_CFG_DIR}
sudo cp ${REGISTRY_BASE_DIR}/scripts4admin/server_start.sh ${ADMIN_CFG_DIR}/call_gc_in_server.sh
