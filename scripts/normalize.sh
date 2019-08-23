#!/bin/bash


normalize() {
    local last_char="${1: -1}"
    if [ "$last_char" = "/" ]; then
        echo "${1}"
    else
        echo "${1}/"
    fi
}

