#!/bin/bash

# 获取要import的存储,如果没有就是 local-lvm
if [ -z $1 ]; then
    w="local-lvm"
else
    w=$1
fi

# 嵌套虚拟化
modprobe -r kvm_intel
modprobe kvm_intel nested=1 
echo "options kvm_intel nested=1" >> /etc/modprobe.d/modprobe.conf

apt update -y 
apt upgrade -y

# 安装软件
apt install curl wget gnupg2 git -y 

git clone https://github.com/ISIFNET/pve-import-template.git

cd pve-import-template

bash setup.sh

./import.py $w
