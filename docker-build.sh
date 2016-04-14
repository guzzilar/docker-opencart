#!/bin/sh

echo "*** Remove Docker's container"
docker rm -f docker-opencart;

echo "*** Build Docker's container"
docker build --no-cache -t guzzilar/docker-opencart .;

echo "*** Run Docker's container"
docker run --name docker-opencart -d -p 80:80 -it guzzilar/docker-opencart;