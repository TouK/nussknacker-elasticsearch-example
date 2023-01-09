#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"

ES_URL=http://localhost:9200
INDEX_TEMPLATE=events
INDEX_PATTERN='events-*-*'
DEFINITION=$(cat << EOF
{
  "index_patterns": ["$INDEX_PATTERN"],
  "data_stream": {}
}
EOF
)

curl -X PUT -H "Content-Type: application/json" -d "$DEFINITION" "$ES_URL/_index_template/$INDEX_TEMPLATE"
