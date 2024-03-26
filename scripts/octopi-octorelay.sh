#!/usr/bin/env bash

if [[ $# != 2 ]]; then
    echo "Usage: $0 <on|off|status>"
    exit 1
fi

if [[ $2 == "on" ]]; then
    JSON_PAYLOAD="{\"command\": \"update\", \"subject\": \"$1\", \"target\": true}"
elif [[ $2 == "off" ]]; then
    JSON_PAYLOAD="{\"command\": \"update\", \"subject\": \"$1\", \"target\": false}"
elif [[ $2 == "status" ]]; then
    JSON_PAYLOAD="{\"command\": \"getStatus\", \"subject\": \"$1\"}"
fi

curl \
    --silent \
    --location "$OCTOPI_HOST/api/plugin/octorelay" \
    --header "X-Api-Key: $OCTOPI_API_KEY" \
    --header 'Content-Type: application/json' \
    --data "$JSON_PAYLOAD" \
       | grep -q "true" && echo "on" || echo "off"
