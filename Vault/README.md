wget https://releases.hashicorp.com/vault/1.14.0/vault_1.14.0_linux_arm64.zip

export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN='hvs.vVjQVk5Lhhmy6NPUGlj4dpON'

vault kv put my/path key1=value1
vault kv get my/path
vault kv delete my/path


Enable secret engin path :-
vault secrets enable -path=my kv

Disable secret engin path :-
vault secrets disable aws

Unseal command:-
vault operator init