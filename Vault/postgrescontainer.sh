#!/bin/bash
docker run -d --rm \
    -p 5432:5432    \
	--name some-postgres \
    -e POSTGRES_USER=postgres \
	-e POSTGRES_PASSWORD=mysecretpassword \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	postgres

docker exec -it some-postgres bash

#psql -U postgres
#\du