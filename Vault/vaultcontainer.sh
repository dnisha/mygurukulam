#!/bin/bash
export VAULT_ADDR='http://localhost:8200'
docker run -d --rm --name vault-server --cap-add=IPC_LOCK -p 8200:8200 -e 'VAULT_DEV_ROOT_TOKEN_ID=123' -e 'VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200' vault:1.13.3