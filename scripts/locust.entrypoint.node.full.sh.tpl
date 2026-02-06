#!/bin/bash
set -ex

# Install dependencies (AL2023 compatible)
sudo dnf install -y python3 python3-devel python3-pip gcc tzdata unzip htop

# LOCUST - use --ignore-installed to avoid setuptools conflict
export LOCUST_VERSION="2.9.0"
sudo python3 -m pip install --ignore-installed locust==$LOCUST_VERSION

export PRIVATE_IP=$(hostname -I | awk '{print $1}')
echo "PRIVATE_IP=$PRIVATE_IP" | sudo tee -a /etc/environment

mkdir -p ~/.ssh
echo 'Host *' > ~/.ssh/config
echo 'StrictHostKeyChecking no' >> ~/.ssh/config

touch /tmp/finished-setup
