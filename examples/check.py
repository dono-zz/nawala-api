#!/usr/bin/env python3
"""Check Indonesian Nawala / TrustPositif blocking. Usage: python3 check.py reddit.com google.com"""
import json
import os
import sys
import urllib.parse
import urllib.request

API = "https://epiai.h80.org"
KEY = os.environ.get("NAWALA_API_KEY", "nk1234567890")  # demo key: 100 requests/day, shared


def check(domains):
    query = urllib.parse.urlencode({"api_key": KEY, "domain": ",".join(domains)})
    request = urllib.request.Request(f"{API}/check-domain?{query}", headers={"User-Agent": "nawala-api-example/1.0"})
    with urllib.request.urlopen(request, timeout=90) as response:
        return json.load(response)


if __name__ == "__main__":
    for result in check(sys.argv[1:] or ["reddit.com", "google.com"])["results"]:
        blocked = [p["provider_name"] for p in result["provider_info"] if p["readable_result"] == "BLOCKED"]
        print(f'{result["domain"]}: {result["status"].upper()}' + (f' ({", ".join(blocked)})' if blocked else ""))
