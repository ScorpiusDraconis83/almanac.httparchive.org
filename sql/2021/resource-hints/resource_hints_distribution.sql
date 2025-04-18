CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload INT64, prefetch INT64, preconnect INT64, prerender INT64, `dns-prefetch` INT64, `modulepreload` INT64>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch', 'modulepreload'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return hints.reduce((results, hint) => {
    // Null values are omitted from BigQuery aggregations.
    // This means only pages with at least one hint are considered.
    results[hint] = almanac['link-nodes'].nodes.filter(link => link.rel.toLowerCase() == hint).length || null;
    return results;
  }, {});
} catch (e) {
  return hints.reduce((results, hint) => {
    results[hint] = null;
    return results;
  }, {});
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(hints.preload, 1000)[OFFSET(percentile * 10)] AS preload,
  APPROX_QUANTILES(hints.prefetch, 1000)[OFFSET(percentile * 10)] AS prefetch,
  APPROX_QUANTILES(hints.preconnect, 1000)[OFFSET(percentile * 10)] AS preconnect,
  APPROX_QUANTILES(hints.prerender, 1000)[OFFSET(percentile * 10)] AS prerender,
  APPROX_QUANTILES(hints.`dns-prefetch`, 1000)[OFFSET(percentile * 10)] AS dns_prefetch,
  APPROX_QUANTILES(hints.modulepreload, 1000)[OFFSET(percentile * 10)] AS modulepreload
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getResourceHints(payload) AS hints
  FROM
    `httparchive.pages.2021_07_01_*`
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
