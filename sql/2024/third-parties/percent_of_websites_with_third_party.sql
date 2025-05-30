#standardSQL
# Percent of websites with third parties

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    respBodySize
  FROM
    `httparchive.summary_requests.2024_06_01_*`
),

third_party AS (
  SELECT
    domain,
    category,
    COUNT(DISTINCT page) AS page_usage,
    COUNT(0) AS request_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2024-06-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    category
  HAVING
    page_usage > 50
)

SELECT
  client,
  COUNT(DISTINCT IF(domain IS NOT NULL, page, NULL)) AS pages_with_third_party,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT IF(domain IS NOT NULL, page, NULL)) / COUNT(DISTINCT page) AS pct_pages_with_third_party,
  COUNTIF(domain IS NOT NULL) AS third_party_requests,
  COUNT(0) AS total_requests,
  COUNTIF(domain IS NOT NULL) / COUNT(0) AS pct_third_party_requests,
  SUM(IF(domain IS NOT NULL, respBodySize, 0)) AS third_party_body_size,
  SUM(respBodySize) AS total_body_size,
  SUM(IF(domain IS NOT NULL, respBodySize, 0)) / SUM(respBodySize) AS pct_body_size
FROM
  requests
LEFT JOIN third_party
ON NET.HOST(requests.url) = NET.HOST(third_party.domain)
GROUP BY
  client
