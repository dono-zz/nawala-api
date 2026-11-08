# Nawala API: cek domain diblokir Komdigi (Kominfo) & operator

> Dokumentasi resmi: **[nawacek.id/api-nawala](https://nawacek.id/api-nawala)**. Repo ini berisi ringkasan, key demo, contoh kode, dan skill AI.

API untuk mengecek apakah domain **diblokir di Indonesia** (Nawala / Internet Positif / TrustPositif) oleh Komdigi (dulu Kominfo) dan 11 provider: Telkomsel, Indosat Ooredoo, XL Axiata, Axis, Three, Smartfren, IDNIC, iForte, Lintasarta, dan lainnya. Cocok untuk bot Telegram, panel hosting, dan monitoring domain.

[English below](#english)

## Coba gratis: akun demo

| | |
|---|---|
| **URL API** | `https://epiai.h80.org` |
| **API key demo** | `nk1234567890` |
| **Limit demo** | 100 request per hari (dipakai bersama semua pengguna demo) |

```bash
curl -H "X-API-Key: nk1234567890" "https://epiai.h80.org/check-domain?domain=reddit.com"
```

Kirim key lewat header `X-API-Key` supaya tidak tercatat di log URL. Parameter `api_key=` di query juga diterima.

Key demo dipakai bersama, jadi limitnya bisa habis sebelum hari berganti. Untuk produksi, pakai paket berbayar.

## Paket berbayar

**Rp 7.500.000 / bulan**: 10.000 request per hari, maksimal 10 domain per request, key pribadi.
Order lewat Telegram **[@gembels](https://t.me/gembels)** atau [nawacek.id](https://nawacek.id/?utm_source=github&utm_medium=referral&utm_campaign=nawala-api).

## Endpoint

### 1. Cek satu domain

```
GET https://epiai.h80.org/check-domain?domain=reddit.com
X-API-Key: API_KEY
```

### 2. Cek banyak domain sekaligus

Pisahkan dengan koma, **maksimal 10 domain** per request. Satu panggilan dihitung 1 request.

```
GET https://epiai.h80.org/check-domain?domain=reddit.com,google.com,contoh.id
X-API-Key: API_KEY
```

### 3. Cek sisa limit

```
GET https://epiai.h80.org/my-usage
X-API-Key: API_KEY
```

```json
{"api_key":"nk1234567890","limit":100,"used":4,"remaining":96,"percentage_used":4,"reset_in_hours":22,"reset_in_secs":81206,"window_days":1}
```

## Contoh hasil

```json
{
  "results": [
    {
      "domain": "reddit.com",
      "status": "blocked",
      "readable_result": "BLOCKED",
      "check_info": {"date": "03/03/2026", "time": "14:30:00", "location": "Indonesia"},
      "provider_info": [
        {"provider_name": "Kominfo", "readable_result": "ALLOWED"},
        {"provider_name": "Telkomsel", "readable_result": "BLOCKED"},
        {"provider_name": "XL Axiata", "readable_result": "BLOCKED"},
        {"provider_name": "Indosat Ooredoo", "readable_result": "BLOCKED"},
        {"provider_name": "Trustpositif DONO", "readable_result": "BLOCKED"}
      ],
      "cache_hit": false
    }
  ]
}
```

| `status` | Arti |
|---|---|
| `blocked` | Domain **diblokir** minimal oleh satu provider |
| `allowed` | Domain **bebas** di semua provider yang dicek |

| `provider_info[].readable_result` | Arti |
|---|---|
| `BLOCKED` | Diblokir provider tersebut |
| `ALLOWED` | Bisa diakses lewat provider tersebut |

Error, misalnya key salah:

```json
{"error": "Invalid API key", "message": "Contact @gembels at Telegram"}
```

## Catatan

- `http://`, `https://` dan path dibersihkan otomatis: `https://contoh.id/halaman` dicek sebagai `contoh.id`.
- Hasil di-cache 5 menit (`cache_hit: true`).
- Contoh kode siap pakai: [curl](examples/curl.sh) · [Python](examples/check.py) · [PHP](examples/check.php) · [Node.js](examples/check.mjs).

## Pakai dari AI (Claude, Cursor, Codex, Gemini CLI)

Repo ini juga berisi skill [`nawala-check`](skills/nawala-check/SKILL.md), sehingga AI bisa mengecek blokir domain langsung dari chat.

```bash
npx skills add dono-zz/nawala-api
```

Claude Code: `/plugin marketplace add dono-zz/indomaret-skills` lalu `/plugin install nawala-check@indomaret-skills`. Pakai key sendiri dengan mengisi environment variable `NAWALA_API_KEY`.

## Tanpa API

- Cek beberapa domain gratis di browser: [indomaret.org/tool/cek-nawala](https://indomaret.org/tool/cek-nawala)
- Monitoring, alert Telegram, cek massal: [nawacek.id](https://nawacek.id/?utm_source=github&utm_medium=referral&utm_campaign=nawala-api)
- Hosting anti-DDoS dengan cek Nawala otomatis: [indomaret.org/hosting-anti-ddos](https://indomaret.org/hosting-anti-ddos)

---

## English

Official docs: **[nawacek.id/api-nawala](https://nawacek.id/api-nawala)**.

An API that checks whether a domain is **blocked in Indonesia** (Nawala / Internet Positif / TrustPositif) by Komdigi (formerly Kominfo) and 11 providers: Telkomsel, Indosat Ooredoo, XL Axiata, Axis, Three, Smartfren, IDNIC, iForte, Lintasarta and more.

**Free demo:** API URL `https://epiai.h80.org`, key `nk1234567890`, 100 requests per day shared by every demo user.

```bash
curl -H "X-API-Key: nk1234567890" "https://epiai.h80.org/check-domain?domain=reddit.com,google.com"
```

| Endpoint | Purpose |
|---|---|
| `GET /check-domain?domain=a.com,b.com` | Check up to 10 domains (comma-separated). One call = 1 request. |
| `GET /my-usage` | Remaining quota and reset time. |

Send the key in the `X-API-Key` header (the `api_key=` query parameter also works).

`status` is `blocked` when at least one provider blocks the domain, otherwise `allowed`; `provider_info` lists each provider's `BLOCKED` / `ALLOWED` result. Results are cached for 5 minutes; schemes and paths are stripped automatically (`www` is kept).

**Paid plan:** Rp 7,500,000 per month, 10,000 requests per day, up to 10 domains per request, private key. Order on Telegram **[@gembels](https://t.me/gembels)** or at [nawacek.id](https://nawacek.id/?utm_source=github&utm_medium=referral&utm_campaign=nawala-api).

AI agents: `npx skills add dono-zz/nawala-api` installs the `nawala-check` skill; set `NAWALA_API_KEY` to use your own key.

MIT licensed (docs and example code).
