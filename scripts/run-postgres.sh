#!/bin/bash

docker run \
  --name postgres \
  --restart always \
  -e POSTGRES_PASSWORD=postgres \
  -p 5432:5432 \
	-v /var/lib/postgresql/data:/var/lib/postgresql/data \
  -d postgres:15.3
