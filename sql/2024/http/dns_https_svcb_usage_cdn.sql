SELECT
  client,
  COUNT(0) AS total_pages,
  JSON_EXTRACT_SCALAR(r.summary, '$._cdn_provider') AS cdn,
  COUNTIF(JSON_EXTRACT(p.payload, '$._origin_dns.https') != '[]') AS dns_https,
  COUNTIF(JSON_EXTRACT(p.payload, '$._origin_dns.https') != '[]') / COUNT(0) AS pct_dns_https,
  COUNTIF(REGEXP_EXTRACT(JSON_EXTRACT(p.payload, '$._origin_dns.https'), r'alpn=\\"[^"]*h3[^"]*\\"') IS NOT NULL) AS dns_https_alpn,
  COUNTIF(REGEXP_EXTRACT(JSON_EXTRACT(p.payload, '$._origin_dns.https'), r'alpn=\\"[^"]*h3[^"]*\\"') IS NOT NULL) / COUNT(0) AS pct_dns_https_alpn,
  COUNTIF(JSON_EXTRACT(p.payload, '$._origin_dns.svcb') != '[]') AS dns_svcb,
  COUNTIF(JSON_EXTRACT(p.payload, '$._origin_dns.svcb') != '[]') / COUNT(0) AS pct_dns_svcb,
  COUNTIF(REGEXP_EXTRACT(JSON_EXTRACT(p.payload, '$._origin_dns.svcb'), r'alpn=\\"[^"]*h3[^"]*\\"') IS NOT NULL) AS dns_svcb_alpn,
  COUNTIF(REGEXP_EXTRACT(JSON_EXTRACT(p.payload, '$._origin_dns.svcb'), r'alpn=\\"[^"]*h3[^"]*\\"') IS NOT NULL) / COUNT(0) AS pct_dns_svcb_alpn,
  COUNTIF(JSON_EXTRACT(p.payload, '$._origin_dns.https') != '[]' OR JSON_EXTRACT(p.payload, '$._origin_dns.svcb') != '[]') AS dns_https_or_svcb,
  COUNTIF(JSON_EXTRACT(p.payload, '$._origin_dns.https') != '[]' OR JSON_EXTRACT(p.payload, '$._origin_dns.svcb') != '[]') / COUNT(0) AS pct_dns_https_or_svcb,
  COUNTIF(REGEXP_EXTRACT(JSON_EXTRACT(p.payload, '$._origin_dns.https'), r'alpn=\\"[^"]*h3[^"]*\\"') IS NOT NULL OR REGEXP_EXTRACT(JSON_EXTRACT(p.payload, '$._origin_dns.svcb'), r'alpn=\\"[^"]*h3[^"]*\\"') IS NOT NULL) AS dns_https_or_svcb_alpn,
  COUNTIF(REGEXP_EXTRACT(JSON_EXTRACT(p.payload, '$._origin_dns.https'), r'alpn=\\"[^"]*h3[^"]*\\"') IS NOT NULL OR REGEXP_EXTRACT(JSON_EXTRACT(p.payload, '$._origin_dns.svcb'), r'alpn=\\"[^"]*h3[^"]*\\"') IS NOT NULL) / COUNT(0) AS pct_dns_https_or_svcb_alpn
FROM
  `httparchive.all.pages` p
INNER JOIN
  `httparchive.all.requests` r
USING (client, date, page, is_root_page)
WHERE
  date = '2024-06-01' AND
  is_root_page AND
  is_main_document
GROUP BY
  client,
  cdn
ORDER BY
  client,
  cdn
