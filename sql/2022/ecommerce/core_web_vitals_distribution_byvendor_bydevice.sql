#standardSQL
# Core Web Vitals distribution by Ecommerce vendor
#
# Note that this is an unweighted average of all sites per Ecommerce vendor.
# Performance of sites with millions of visitors as weighted the same as small sites.
SELECT
  client,
  ecomm,
  COUNT(DISTINCT origin) AS origins,
  SUM(fast_ttfb) / (SUM(fast_ttfb) + SUM(avg_ttfb) + SUM(slow_ttfb)) AS good_ttfb,
  SUM(avg_ttfb) / (SUM(fast_ttfb) + SUM(avg_ttfb) + SUM(slow_ttfb)) AS ni_ttfb,
  SUM(slow_ttfb) / (SUM(fast_ttfb) + SUM(avg_ttfb) + SUM(slow_ttfb)) AS poor_ttfb,
  SUM(fast_fcp) / (SUM(fast_fcp) + SUM(avg_fcp) + SUM(slow_fcp)) AS good_fcp,
  SUM(avg_fcp) / (SUM(fast_fcp) + SUM(avg_fcp) + SUM(slow_fcp)) AS ni_fcp,
  SUM(slow_fcp) / (SUM(fast_fcp) + SUM(avg_fcp) + SUM(slow_fcp)) AS poor_fcp,
  SUM(fast_lcp) / (SUM(fast_lcp) + SUM(avg_lcp) + SUM(slow_lcp)) AS good_lcp,
  SUM(avg_lcp) / (SUM(fast_lcp) + SUM(avg_lcp) + SUM(slow_lcp)) AS ni_lcp,
  SUM(slow_lcp) / (SUM(fast_lcp) + SUM(avg_lcp) + SUM(slow_lcp)) AS poor_lcp,
  SUM(fast_fid) / (SUM(fast_fid) + SUM(avg_fid) + SUM(slow_fid)) AS good_fid,
  SUM(avg_fid) / (SUM(fast_fid) + SUM(avg_fid) + SUM(slow_fid)) AS ni_fid,
  SUM(slow_fid) / (SUM(fast_fid) + SUM(avg_fid) + SUM(slow_fid)) AS poor_fid,
  SUM(small_cls) / (SUM(small_cls) + SUM(medium_cls) + SUM(large_cls)) AS good_cls,
  SUM(medium_cls) / (SUM(small_cls) + SUM(medium_cls) + SUM(large_cls)) AS ni_cls,
  SUM(large_cls) / (SUM(small_cls) + SUM(medium_cls) + SUM(large_cls)) AS poor_cls
FROM
  `chrome-ux-report.materialized.device_summary`
JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url,
    app AS ecomm
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'Ecommerce' AND (
      app != 'Cart Functionality' AND
      app != 'Google Analytics Enhanced eCommerce'
    )
)
ON
  CONCAT(origin, '/') = url AND
  IF(device = 'desktop', 'desktop', 'mobile') = client
WHERE
  date = '2022-06-01'
GROUP BY
  client,
  ecomm
ORDER BY
  origins DESC
