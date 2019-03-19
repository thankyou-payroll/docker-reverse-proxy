#!/bin/bash

# Root Directory
DIR=$(dirname "${BASH_SOURCE[0]}")  # get the directory name
DIR=$(realpath "${DIR}/../")

# Helper Scripts
YAML_SCRIPT="$DIR/scripts/yaml.sh"
TEXT_REPLACE_SCRIPT="$DIR/scripts/text_replace.sh"

# Templates
LOCATION_TEMPLATE="$DIR/templates/location.conf"
UPSTREAM_TEMPLATE="$DIR/templates/upstream.conf"
CONFIG_TEMPLATE="$DIR/templates/template.conf"

# Outputs
LOCATIONS="$DIR/conf/locations.conf"
UPSTREAMS="$DIR/conf/upstreams.conf"
CONFIG="$DIR/nginx.conf"

# Cleanup
[ -f "$LOCATIONS" ] && rm "$LOCATIONS"
[ -f "$UPSTREAMS" ] && rm "$UPSTREAMS"
[ -f "$CONFIG" ] && rm "$CONFIG"

touch "$LOCATIONS"

# include scripts
source "$YAML_SCRIPT"
source "$TEXT_REPLACE_SCRIPT"

create_variables "$DIR/config/setup.yml";

echo "Setting up configuration file for port $port"
# for i in "${!entries__upstream[@]}"; do 
for ((i=${#entries__upstream[@]}-1; i>=0; i--)); do
    
    cat "$LOCATION_TEMPLATE" >> "$LOCATIONS";
    location=${entries__location[$i]}
    text_replace "$LOCATIONS" "appName" "node-$i"
    text_replace "$LOCATIONS" "location" "$location"

    cat "$UPSTREAM_TEMPLATE" >> "$UPSTREAMS";
    upstream=${entries__upstream[$i]}
    text_replace "$UPSTREAMS" "appName" "node-$i"
    text_replace "$UPSTREAMS" "upstream" "$upstream"
    echo "[ $location | $upstream ] ---> Created!"
done

cat "$CONFIG_TEMPLATE" >> "$CONFIG";
text_replace "$CONFIG" "port" "$port"

echo "nginx.conf Created!"

