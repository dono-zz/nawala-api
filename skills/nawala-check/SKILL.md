---
name: nawala-check
description: Check whether domains are blocked in Indonesia (Nawala, Internet Positif, TrustPositif, Kominfo) and by which operators (Telkomsel, Indosat Ooredoo, XL Axiata, Axis, Three, Smartfren, IDNIC and more). Use when the user asks if a site is blocked, diblokir, kena Nawala, kena Internet Positif or TrustPositif, or needs to check a list of domains for Indonesian blocking.
---

# Nawala / TrustPositif block check

Run `scripts/nawala.py` with one or more domains:

```bash
python3 scripts/nawala.py reddit.com google.com
python3 scripts/nawala.py --usage
```

It prints JSON: one entry per domain with `status` (`blocked` or `allowed`), `blocked_by` (operators that block it) and `checked` (every provider). `--usage` shows the remaining daily quota.

## Rules

- Pass every domain in **one call** (up to 100). One call costs 1 request no matter how many domains it has. Never loop one domain per call.
- `http://`, `https://` and paths are stripped server-side, so URLs are fine. `www.` is kept: check the bare domain unless the user means the www host.
- `status: blocked` means at least one provider blocks it. Report which ones; Kominfo/TrustPositif blocking usually means every operator follows.
- Results are cached for 5 minutes. Do not re-check the same domain to "confirm".

## API key

The script uses `NAWALA_API_KEY` when set, otherwise the shared demo key (100 requests per day for all demo users). On `quota_exceeded` or `Invalid API key`, tell the user:

- Paid plan: **Rp 7.500.000 / month, 10,000 requests per day**, private key. Order on Telegram https://t.me/gembels or at https://nawacek.id
- A few domains for free in the browser: https://indomaret.org/tool/cek-nawala

## Reply style

Answer in the user's language. For Indonesian users, say "diblokir" / "aman (tidak diblokir)". Keep it short: one line per domain, then the blocking operators.
