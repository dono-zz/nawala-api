#!/usr/bin/env bash
# Usage: NAWALA_API_KEY=your_key ./curl.sh reddit.com,google.com   (max 10 domains)
set -euo pipefail
KEY="${NAWALA_API_KEY:-nk1234567890}"   # demo key: 100 requests/day, shared
DOMAINS="${1:-reddit.com,google.com}"

curl -fsS -G -H "X-API-Key: $KEY" "https://epiai.h80.org/check-domain" --data-urlencode "domain=$DOMAINS"
echo
curl -fsS -H "X-API-Key: $KEY" "https://epiai.h80.org/my-usage"
echo
