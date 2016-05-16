#!/bin/sh

docker-compose -f ./src/opencart-2.0.1.1/docker-compose.yml stop

docker-compose -f ./src/opencart-2.0.1.1/docker-compose.yml rm -f opencart2011
docker-compose -f ./src/opencart-2.0.1.1/docker-compose.yml rm -f opencart2011_db

docker-compose -f ./src/opencart-2.0.1.1/docker-compose.yml up --build