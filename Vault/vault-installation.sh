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
export VAULT_ADDR='http://127.0.0.1:8200'

Unseal Key 1: QZzy8v9OFKUCCXPeGXVWXWN7oJ5KZTsBnarjcvM8GsoU
Unseal Key 2: Fu+AW8mpmjAeq5oHY7mLaRJ8u0QIstC9xQJww0E01Yco
Unseal Key 3: IH1j6/yhOR2XuPriTvTXVu32d6vXIOXHoRqvG2QKQ+fb
Unseal Key 4: PDMM8HMNIua22x9Q1QUxEYcpdnktefO/87pt+s1isxUQ
Unseal Key 5: nRloaQ3YJVl71BQQiJRmXKXWPa2/QoP/RsYU3HV8ZQ96

Initial Root Token: hvs.Wpre7M064q8KdTazFkKSIJwm