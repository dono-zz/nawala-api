// Check Indonesian Nawala / TrustPositif blocking. Usage: node check.mjs reddit.com google.com (Node 18+)
const key = process.env.NAWALA_API_KEY ?? 'nk1234567890'; // demo key: 100 requests/day, shared
const domains = process.argv.slice(2).length ? process.argv.slice(2) : ['reddit.com', 'google.com'];

const url = new URL('https://epiai.h80.org/check-domain');
url.search = new URLSearchParams({ domain: domains.slice(0, 10).join(',') }); // max 10 per request
const data = await (await fetch(url, { headers: { 'X-API-Key': key, 'User-Agent': 'nawala-api-example/1.0' } })).json();

for (const result of data.results ?? []) {
  const blocked = result.provider_info.filter((p) => p.readable_result === 'BLOCKED').map((p) => p.provider_name);
  console.log(`${result.domain}: ${result.status.toUpperCase()}${blocked.length ? ` (${blocked.join(', ')})` : ''}`);
}
