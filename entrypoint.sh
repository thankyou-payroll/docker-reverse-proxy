#!/bin/bash

./scripts/setup.sh
cp nginx.conf /etc/nginx/nginx.conf
echo "/etc/nginx/app/config/locations.conf"
cat /etc/nginx/app/config/locations.conf
echo "/etc/nginx/app/config/upstreams.conf"
cat /etc/nginx/app/config/upstreams.conf
echo "/etc/nginx/nginx.conf"
cat /etc/nginx/nginx.conf
echo "Starting nginx"
nginx -g "daemon off;"
