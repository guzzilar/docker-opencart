#!/bin/sh

docker-compose -f ./src/opencart-1.5.6.4/docker-compose.yml stop

docker-compose -f ./src/opencart-1.5.6.4/docker-compose.yml rm -f opencart1564
docker-compose -f ./src/opencart-1.5.6.4/docker-compose.yml rm -f opencart1564_db

docker-compose -f ./src/opencart-1.5.6.4/docker-compose.yml up --build