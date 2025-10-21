WITH base AS (
  SELECT
    token,
    model_version,
    prediction_made_time,
    current_price,
    target_price,
    actual_price,
    confidence_level,
    CASE
      WHEN target_price > current_price THEN 'bullish'
      WHEN target_price < current_price THEN 'bearish'
      ELSE 'flat'
    END AS direction
  FROM public.trade_analytics
  WHERE model_version = 'v1'
    AND token = 'BTC'
    AND prediction_made_time >= NOW() AT TIME ZONE 'UTC' - ('24' || ' hours')::interval
    AND actual_price IS NOT NULL
),
dir_only AS (
  SELECT *
  FROM base
  WHERE direction IN ('bullish','bearish')
),
agg AS (
  SELECT
    direction,
    COUNT(*)                     AS predictions,
    AVG(confidence_level)::float AS avg_confidence
  FROM dir_only
  GROUP BY direction
)
SELECT
  a.direction,
  a.predictions,
  ROUND(100.0 * a.predictions / NULLIF(SUM(a.predictions) OVER (), 0), 2) AS pct_of_total,
  a.avg_confidence
FROM agg a
ORDER BY a.direction;

WITH base AS (
  SELECT
    token,
    prediction_made_time,
    current_price,
    target_price,
    prediction_result
  FROM public.trade_analytics
  WHERE model_version = 'v1'
    AND token = 'BTC'
    AND prediction_made_time >= NOW() AT TIME ZONE 'UTC' - ('24' || ' hours')::interval
    AND prediction_result IN ('hit','miss')        -- evaluated only (needed for accuracy)
    AND current_price IS NOT NULL
    AND current_price <> 0
),
moves AS (
  SELECT
    100.0 * (target_price - current_price) / current_price AS movement_pct,
    prediction_result
  FROM base
),
binned AS (
  SELECT
    CASE
      WHEN movement_pct >=   5 AND movement_pct < 10 THEN 'Bullish 5% to 10%'
      WHEN movement_pct >=   2 AND movement_pct <  5 THEN 'Bullish 2% to 5%'
      WHEN movement_pct >=   0 AND movement_pct <  2 THEN 'Neutral 0% to +2%'
      WHEN movement_pct >   -2 AND movement_pct <  0 THEN 'Neutral 0% to -2%'
      WHEN movement_pct <=  -2 AND movement_pct >  -5 THEN 'Bearish 2% to 5%'
      WHEN movement_pct <=  -5 AND movement_pct > -10 THEN 'Bearish 5% to 10%'
      ELSE NULL  -- outside +/-10% → drop from this visual
    END AS bucket_label,
    CASE
      WHEN movement_pct >=   5 AND movement_pct < 10 THEN 1
      WHEN movement_pct >=   2 AND movement_pct <  5 THEN 2
      WHEN movement_pct >=   0 AND movement_pct <  2 THEN 3
      WHEN movement_pct >   -2 AND movement_pct <  0 THEN 4
      WHEN movement_pct <=  -2 AND movement_pct >  -5 THEN 5
      WHEN movement_pct <=  -5 AND movement_pct > -10 THEN 6
      ELSE 99
    END AS bucket_order,
    prediction_result
  FROM moves
),
filtered AS (
  SELECT * FROM binned WHERE bucket_label IS NOT NULL
)
SELECT
  bucket_label AS range,
  COUNT(*) AS calls,
  ROUND(100.0 * COUNT(*) / NULLIF(SUM(COUNT(*)) OVER (), 0), 2) AS pct_of_total,
  AVG((prediction_result = 'hit')::int)::float AS accuracy  -- 0..1 (×100 for % in UI)
FROM filtered
GROUP BY bucket_label, bucket_order
ORDER BY bucket_order;

WITH base AS (
  SELECT
    token,
    model_version,
    prediction_made_time,
    confidence_level,           -- numeric(0..1)
    prediction_result
  FROM public.trade_analytics
  WHERE model_version = 'v1'
    AND token = 'BTC'
    AND prediction_result IN ('hit','miss')
    AND prediction_made_time >= NOW() AT TIME ZONE 'UTC' - (24 || ' hours')::interval
    AND confidence_level IS NOT NULL
),
binned AS (
  SELECT
    CASE
      WHEN confidence_level >= 0.95 THEN 'Very High (95–100%)'
      WHEN confidence_level >= 0.85 THEN 'High (85–95%)'
      WHEN confidence_level >= 0.75 THEN 'Medium (75–85%)'
      ELSE 'Low (<75%)'
    END AS confidence_band,
    CASE
      WHEN confidence_level >= 0.95 THEN 1
      WHEN confidence_level >= 0.85 THEN 2
      WHEN confidence_level >= 0.75 THEN 3
      ELSE 4
    END AS band_order,
    prediction_result
  FROM base
)
SELECT
  confidence_band,
  COUNT(*) AS predictions,
  ROUND(100.0 * COUNT(*) / NULLIF(SUM(COUNT(*)) OVER (), 0), 2) AS pct_of_total,
  ROUND(100.0 * AVG((prediction_result = 'hit')::int), 2) AS accuracy
FROM binned
GROUP BY confidence_band, band_order
ORDER BY band_order;