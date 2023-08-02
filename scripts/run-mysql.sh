#!/bin/bash

docker run \
  --name mariadb \
  --restart always \
  -e MARIADB_ROOT_PASSWORD=secretpassword \
  -p 3306:3306 \
	-v /var/lib/mysql:/var/lib/mysql \
  -d mariadb:11.0
