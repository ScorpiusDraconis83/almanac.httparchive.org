CREATE TEMPORARY FUNCTION get_almanac_attribute_info(almanac_string STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>> LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac.attributes_used_on_elements) {
      return Object.entries(almanac.attributes_used_on_elements).filter(([name, freq]) => name.startsWith('data-')).map(([name, freq]) => ({name, freq}));
    }

} catch (e) {}
return [];
''';

WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
),

data_attrs AS (
  SELECT
    client,
    almanac_attribute_info.name,
    COUNT(DISTINCT page) AS pages,
    ANY_VALUE(total_pages) AS total_pages,
    COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
    SUM(almanac_attribute_info.freq) AS freq, # total count from all pages
    SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY client) AS total,
    SUM(almanac_attribute_info.freq) / SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY client) AS pct_ratio
  FROM
    `httparchive.all.pages`
  JOIN
    totals
  USING (client),
    UNNEST(get_almanac_attribute_info(JSON_EXTRACT(custom_metrics, '$.almanac'))) AS almanac_attribute_info
  WHERE
    date = '2024-06-01'
  GROUP BY
    client,
    almanac_attribute_info.name
)

SELECT
  *
FROM
  data_attrs
ORDER BY
  pct_ratio DESC
LIMIT
  1000
