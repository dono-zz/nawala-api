#!/usr/bin/env bash
# Usage: NAWALA_API_KEY=your_key ./curl.sh reddit.com,google.com
set -euo pipefail
KEY="${NAWALA_API_KEY:-nk1234567890}"   # demo key: 100 requests/day, shared
DOMAINS="${1:-reddit.com,google.com}"

curl -fsS -G "https://epiai.h80.org/check-domain" --data-urlencode "api_key=$KEY" --data-urlencode "domain=$DOMAINS"
echo
curl -fsS -G "https://epiai.h80.org/my-usage" --data-urlencode "api_key=$KEY"
echo
