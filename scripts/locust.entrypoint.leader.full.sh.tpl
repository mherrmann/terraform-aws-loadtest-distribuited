#!/bin/bash
set -ex

# Install dependencies (AL2023 compatible)
sudo dnf install -y python3 python3-devel python3-pip gcc tzdata unzip htop iptables-nft

# LOCUST - use --ignore-installed to avoid setuptools conflict
export LOCUST_VERSION="2.9.0"
sudo python3 -m pip install --ignore-installed locust==$LOCUST_VERSION

export PRIVATE_IP=$(hostname -I | awk '{print $1}')
echo "PRIVATE_IP=$PRIVATE_IP" | sudo tee -a /etc/environment

mkdir -p ~/.ssh
echo 'Host *' > ~/.ssh/config
echo 'StrictHostKeyChecking no' >> ~/.ssh/config

sudo iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -i eth0 -p tcp --dport 8080 -j ACCEPT
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080

touch /tmp/finished-setup
