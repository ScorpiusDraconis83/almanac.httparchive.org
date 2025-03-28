#standardSQL
# 13_10b: Top analytics provides on eCommerce Sites by device
# REMOVE GA Enhanced ??? not needed Cart Functionality

SELECT
  _TABLE_SUFFIX AS client,
  app,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2022_06_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    url
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'Ecommerce'
)
USING (_TABLE_SUFFIX, url)
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'Ecommerce'
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  category = 'Analytics'
GROUP BY
  client,
  app,
  total
ORDER BY
  client DESC,
  pct DESC
