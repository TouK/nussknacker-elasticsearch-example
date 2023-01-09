#!/usr/bin/bash

set -e
cd "$(dirname "$0")"

CONNECTORS_URL=http://localhost:8083/connectors
CONNECTOR_NAME=es-business-events
CONNECTOR_CONFIG_FILE=es-business-events-connector.json
CONNECTOR_CONFIG=$(cat "$CONNECTOR_CONFIG_FILE")

if curl $CONNECTORS_URL/$CONNECTOR_NAME > /dev/null ; then
  curl -X PUT -H "Content-Type: application/json" -H "Accept: application/json" -d "$CONNECTOR_CONFIG" $CONNECTORS_URL/$CONNECTOR_NAME/config
else
  curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "{\"name\": \"$CONNECTOR_NAME\", \"config\": $CONNECTOR_CONFIG}" $CONNECTORS_URL
fi

