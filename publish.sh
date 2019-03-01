#!/bin/bash

docker build -t docker-easy-proxy .
docker tag docker-easy-proxy thankyoupayroll/docker-easy-proxy:latest
docker push thankyoupayroll/docker-easy-proxy:latest