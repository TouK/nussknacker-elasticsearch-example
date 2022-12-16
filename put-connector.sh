#!/usr/bin/bash

set -e
cd "$(dirname "$0")"

CONNECTOR_NAME=$1
CONNECTOR_CONFIG_FILE=$2

CONNECTOR_CONFIG=$(cat "$CONNECTOR_CONFIG_FILE" | eval "$(cat .env)" envsubst)

if curl http://localhost:8083/connectors/$CONNECTOR_NAME > /dev/null ; then
  curl -X PUT -H "Content-Type: application/json" -H "Accept: application/json" -d "$CONNECTOR_CONFIG" http://localhost:8083/connectors/$CONNECTOR_NAME/config
else
  curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "{\"name\": \"$CONNECTOR_NAME\", \"config\": $CONNECTOR_CONFIG}" http://localhost:8083/connectors
fi

