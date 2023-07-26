#!/bin/bash

docker restart vault
docker exec -it vault /bin/bash

docker run -it -p 8200:8200 -v ~/vault_data:/data --name vault ubuntu:20.04
