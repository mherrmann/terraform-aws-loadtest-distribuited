#!/bin/bash

sudo dnf update -y
sudo dnf install -y pcre2-devel.x86_64 python3 gcc python3-devel python3-pip tzdata curl unzip bash htop

# LOCUST
export LOCUST_VERSION="2.9.0"
sudo pip3 install locust==$LOCUST_VERSION

export PRIVATE_IP=$(hostname -I | awk '{print $1}')
echo "PRIVATE_IP=$PRIVATE_IP" >> /etc/environment

source ~/.bashrc

mkdir -p ~/.ssh
echo 'Host *' > ~/.ssh/config
echo 'StrictHostKeyChecking no' >> ~/.ssh/config

touch /tmp/finished-setup
