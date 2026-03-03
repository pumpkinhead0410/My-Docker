#!/bin/bash

NFS_SERVER_IP="${NFS_SERVER_IP:-<nfs_server_ip>}"

su -

mkdir /mnt/user
mkdir /mnt/contents
mkdir /mnt/DataSet
mkdir /mnt/public

# do some vi editting
vi /etc/fstab
${NFS_SERVER_IP}:/export/Users /mnt/user nfs rsize=8192,wsize=8192,timeo=14,intr
${NFS_SERVER_IP}:/export/Contents /mnt/contents nfs rsize=8192,wsize=8192,timeo=14,intr
${NFS_SERVER_IP}:/export/DataSet /mnt/DataSet nfs rsize=8192,wsize=8192,timeo=14,intr
${NFS_SERVER_IP}:/export/Public /mnt/public nfs rsize=8192,wsize=8192,timeo=14,intr

# package install
apt install -y nfs-common
# moutning
mount -a 
