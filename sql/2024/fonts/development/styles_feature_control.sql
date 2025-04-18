-- Section: Development
-- Question: How are features used in CSS?
-- Normalization: Pages

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
function compute(tree) {
  const result = {};
  walkDeclarations(tree, ({ property, value }) => {
    const name = property.toLowerCase();
    if (
      name.startsWith('font-variant-') &&
      value.toLowerCase() !== 'none' &&
      value.toLowerCase() !== 'normal'
    ) {
      incrementByKey(result, 'font-variant');
    } else if (
      name === 'font-feature-settings' &&
      value.toLowerCase() !== 'normal'
    ) {
      incrementByKey(result, 'font-feature-settings');
    }
  });
  return sortObject(result);
}

try {
  const properties = compute(JSON.parse(json));
  return Object.entries(properties).flatMap(([name, count]) => {
    return Array(count).fill(name);
  });
} catch (e) {
  return [];
}
''';

WITH
properties AS (
  SELECT
    client,
    property,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property
  WHERE
    date = '2024-07-01' AND
    is_root_page
  GROUP BY
    client,
    property
),

pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  property,
  count,
  total,
  count / total AS proportion
FROM
  properties
JOIN
  pages
USING (client)
ORDER BY
  client,
  proportion DESC
