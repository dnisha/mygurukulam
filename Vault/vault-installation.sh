#!/bin/bash


apt update
apt install wget -y
apt install unzip -y
mkdir -p ~/Hashicorp/Vault

cd ~/Hashicorp/Vault

wget https://releases.hashicorp.com/vault/1.14.0/vault_1.14.0_linux_arm64.zip
unzip vault_1.14.0_linux_arm64.zip
rm -rf vault_1.14.0_linux_arm64.zip

echo "export PATH='$PATH:/root/Hashicorp/Vault'" >> ~/.bashrc 
