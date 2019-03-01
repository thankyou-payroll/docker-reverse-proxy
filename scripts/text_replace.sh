#!/bin/bash

text_replace() {
    local file=$1
    local old=$2
    local new=$3
    local REGEX="s~\${$old}~$new~g" 
    sed -i $REGEX "$file"
}