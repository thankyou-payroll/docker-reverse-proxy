#!/bin/bash

./scripts/setup.sh
cp nginx.conf /etc/nginx/nginx.conf
echo "/etc/nginx/app/conf/locations.conf"
cat /etc/nginx/app/conf/locations.conf
echo "/etc/nginx/app/conf/upstreams.conf"
cat /etc/nginx/app/conf/upstreams.conf
echo "/etc/nginx/nginx.conf"
cat /etc/nginx/nginx.conf
echo "Starting nginx"
nginx -g "daemon off;"
