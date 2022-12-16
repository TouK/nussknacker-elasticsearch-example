#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"

ES_URL=http://localhost:9200
INDEX_NAME=logs-business_events-default
EVENT_FILE=$1
DOC=$(cat << EOF
{
  "@timestamp": "$(date -Iseconds)",
  "event": $(cat "$EVENT_FILE")
}
EOF
)

curl -X POST -H "Content-Type: application/json" -d "$DOC"  $ES_URL/$INDEX_NAME/_doc
