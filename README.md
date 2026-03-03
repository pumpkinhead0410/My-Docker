# My-Docker
참조용 Docker 세팅

---
# 🐧 리눅스 서버 구축 및 Docker 레지스트리 운영 매뉴얼

> **문서 정보**
> 
> - **최종 수정:** 2022년
> - **버전:** v1.0 (통합본)
> - **목적:** 표준 리눅스 서버 환경 구축 및 사내 Docker 이미지 서버(Registry) 관리 표준화

## 1. 운영체제 설치 및 네트워크 구성

### 1.1 사전 환경 확인

설치 전 할당된 네트워크 정보를 확인하여 충돌을 방지합니다.

- **IP Address:** `<Target_Server_IP>` (예: 172.16.x.x)
- **Gateway:** `<Gateway_IP>`
- **Netmask:** `255.255.0.0`

### 1.2 계정 및 보안 설정

1. **팀원 공용 계정 생성:** `sudo adduser <username>` 명령어를 통해 개인별 계정을 할당합니다.
2. **권한 관리:** `/etc/sudoers` 설정을 통해 필요한 인원에게만 관리자 권한을 부여합니다.
    
    ```
    sudo usermod -aG sudo <username>
    ```
    
3. **SSH 설정:** 외부 접속 보안을 위해 필요한 경우에만 루트 로그인을 제한하고 SSH 포트를 관리합니다.

### 1.3 네트워크 스토리지(NAS) 마운트

대용량 데이터 저장을 위해 NFS 스토리지를 연동합니다.

- **설정:** `/etc/fstab`에 마운트 정보 추가
- **경로:** `<NAS_IP>:/volume/data` → `/mnt/storage`

## 2. GPU 가속 환경 구성 (NVIDIA)

### 2.1 드라이버 설치

머신러닝 및 영상 처리 가속을 위해 서버 사양에 맞는 NVIDIA 드라이버를 설치합니다.

```
sudo apt-get update
sudo apt-get install nvidia-driver-<version_number>
```

### 2.2 트러블슈팅: Driver/Library Version Mismatch

OS 업데이트 후 `nvidia-smi` 오류 발생 시 조치 방법:

1. 기존 드라이버 제거: `sudo apt remove nvidia-driver-*`
2. 드라이버 재설치 및 시스템 재부팅: `sudo reboot now`

## 3. Docker 엔진 및 사내 레지스트리 구축

### 3.1 Docker Engine 설치

공식 레포지토리를 사용하여 최신 Docker 엔진을 설치하고 사용자 권한을 부여합니다.

```
sudo usermod -aG docker ${USER}
```

### 3.2 사내 Docker Registry 정보

- **Registry 주소:** `<Registry_IP>:5000`
- **관리 웹 UI:** `http://<Registry_IP>:8080`
- **데이터 저장소:** `/data/docker_storage/repositories`

## 4. Docker 이미지 및 저장소 관리

### 4.1 이미지 삭제 프로세스

저장 공간 확보를 위해 불필요한 이미지와 태그를 주기적으로 정리합니다.

1. **특정 태그 삭제:** 자체 제작한 `image_delete.sh` 스크립트를 활용합니다.
    
    ```
    ./image_delete.sh <프로젝트명>/<이미지명> <태그명>
    ```
    
2. **레포지토리 전체 삭제:** 물리적 폴더 삭제 시 팀 내 사전 공유가 필수적입니다.
    
    ```
    rm -rf /data/docker_storage/repositories/<target_repo>
    ```
    

### 4.2 가비지 컬렉션 (Garbage Collection)

이미지 삭제 후 실제 물리 용량을 확보하기 위해 GC를 호출합니다.

- **실행 명령:**
    
    ```
    docker exec registry-srv bin/registry garbage-collect /etc/docker/registry/config.yml
    ```
    
- **자동화:** `crontab`을 활용하여 매일 새벽 시간대에 주기적으로 실행되도록 설정합니다.

## 5. 자동화 스크립트 리스트

- `install_server_env.sh`: 서버 초기 환경 일괄 구축
- `install_docker_registry_server.sh`: 레지스트리 서버 자동 설치
- `call_gc_in_server.sh`: 도커 저장소 가비지 컬렉션 호출
- `delete_users.sh`: 퇴사자 등 미사용 계정 일괄 삭제

## ⚠️ 주의사항

1. **공동 작업 공간:** 도커 레지스트리는 전 팀원이 공유하므로 삭제 작업 시 반드시 영향 범위를 확인해야 합니다.
2. **버전 관리:** 운영체제나 드라이버 업데이트 시 기존 라이브러리와의 호환성을 우선 검토합니다.
