#!/bin/bash

# Root Directory
DIR=$(dirname "${BASH_SOURCE[0]}") # get the directory name
DIR=$(realpath "${DIR}/../")

# Helper Scripts
YAML_SCRIPT="$DIR/scripts/yaml.sh"
TEXT_REPLACE_SCRIPT="$DIR/scripts/text_replace.sh"
NORMALIZE_SCRIPT="$DIR/scripts/normalize.sh"

# Templates
LOCATION_TEMPLATE="$DIR/templates/location.conf"
AUTH_TEMPLATE="$DIR/templates/auth.conf"
UPSTREAM_TEMPLATE="$DIR/templates/upstream.conf"
CONFIG_TEMPLATE="$DIR/templates/template.conf"

# Outputs
LOCATIONS="$DIR/config/locations.conf"
UPSTREAMS="$DIR/config/upstreams.conf"
CONFIG="$DIR/nginx.conf"

# Cleanup
[ -f "$LOCATIONS" ] && rm "$LOCATIONS"
[ -f "$UPSTREAMS" ] && rm "$UPSTREAMS"
[ -f "$CONFIG" ] && rm "$CONFIG"

touch "$LOCATIONS"

# include scripts
source "$YAML_SCRIPT"
source "$TEXT_REPLACE_SCRIPT"
source "$NORMALIZE_SCRIPT"

create_variables "$DIR/config/setup.yml"

echo "Setting up configuration file for port $port"
# for i in "${!entries__upstream[@]}"; do
for ((i = ${#entries__upstream[@]} - 1; i >= 0; i--)); do

  location=$(normalize ${entries__location[$i]})
  cat "$LOCATION_TEMPLATE" >>"$LOCATIONS"
  text_replace "$LOCATIONS" "appName" "node-$i"
  text_replace "$LOCATIONS" "location" "$location"
  auth=${entries__auth[$i]}
  if [ -z "$auth" ]; then
    authConfig=$(cat "$AUTH_TEMPLATE")
    text_replace "$LOCATIONS" "auth" "$authConfig"
  else
    text_replace "$LOCATIONS" "auth" ""
  fi

  upstream=${entries__upstream[$i]}
  cat "$UPSTREAM_TEMPLATE" >>"$UPSTREAMS"
  text_replace "$UPSTREAMS" "appName" "node-$i"
  text_replace "$UPSTREAMS" "upstream" "$upstream"

  echo "[ $location | $upstream ] ---> Created!"
done

cat "$CONFIG_TEMPLATE" >>"$CONFIG"
text_replace "$CONFIG" "port" "$port"

echo "nginx.conf Created!"
