<?php
// Check Indonesian Nawala / TrustPositif blocking. Usage: php check.php reddit.com google.com

$key = getenv('NAWALA_API_KEY') ?: 'nk1234567890'; // demo key: 100 requests/day, shared
$domains = array_slice($argv, 1) ?: ['reddit.com', 'google.com'];

$url = 'https://epiai.h80.org/check-domain?'.http_build_query(['domain' => implode(',', array_slice($domains, 0, 10))]); // max 10 per request
$context = stream_context_create(['http' => ['timeout' => 90, 'header' => "X-API-Key: $key\r\nUser-Agent: nawala-api-example/1.0\r\n"]]);
$data = json_decode(file_get_contents($url, false, $context), true);

foreach ($data['results'] ?? [] as $result) {
    $blocked = array_column(array_filter($result['provider_info'], fn ($p) => $p['readable_result'] === 'BLOCKED'), 'provider_name');
    echo $result['domain'].': '.strtoupper($result['status']).($blocked ? ' ('.implode(', ', $blocked).')' : '').PHP_EOL;
}
