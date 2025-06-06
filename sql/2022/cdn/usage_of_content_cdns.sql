#standardSQL
# usage_ofcontent_cdns.sql: % of Pages using a library CDN Host

SELECT
  *,
  pageUseCount / totalPagesCount AS pct
FROM (
  SELECT
    client,
    IF(NET.HOST(
      url) IN (
      'unpkg.com',
      'cdn.jsdelivr.net',
      'cdnjs.cloudflare.com',
      'ajax.aspnetcdn.com',
      'ajax.googleapis.com',
      'stackpath.bootstrapcdn.com',
      'maxcdn.bootstrapcdn.com',
      'use.fontawesome.com',
      'code.jquery.com',
      'fonts.googleapis.com'
    ), NET.HOST(url
    ), 'OTHER') AS jsCDN,
    COUNT(DISTINCT page) AS pageUseCount,
    SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client) AS totalPagesCount
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01'
  GROUP BY
    client,
    jsCDN
)
WHERE
  jsCDN != 'OTHER'
ORDER BY
  client DESC,
  pageUseCount DESC
