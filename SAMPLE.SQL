WITH vars AS (
  SELECT
    'v1'::text AS model,                              -- 'v1' = TradePredict, 'v2' = TradeSense
    ARRAY['BTC','ETH','SOL']::text[] AS tokens,       -- Set specific tokens or NULL for all
    NOW() - INTERVAL '30 days' AS start_time,         -- Change window as needed
    NOW() AS end_time,                                -- End timestamp
    'price'::text AS metric                           -- 'price' or 'direction'
),

tf AS (
  SELECT UNNEST(ARRAY[1,2,4,12,24]) AS h
),

-- Base rows in the window
base AS (
  SELECT
    t.token,
    (EXTRACT(EPOCH FROM t.prediction_timeframe)/3600)::int AS h,
    t.prediction_made_time,
    t.current_price,
    t.target_price,
    t.prediction_result,
    t.direction_result,
    t.confidence_level                         -- expected 0..1
  FROM public.trade_analytics t, vars
  WHERE t.model_version = vars.model
    AND (vars.tokens IS NULL OR t.token = ANY(vars.tokens))
    AND t.prediction_made_time BETWEEN vars.start_time AND vars.end_time
    AND t.current_price IS NOT NULL
    AND t.current_price <> 0
),

-- Keep only evaluated rows for the chosen metric
filtered AS (
  SELECT
    *,
    CASE
      WHEN vars.metric = 'price'     THEN (prediction_result  IN ('hit','miss'))
      WHEN vars.metric = 'direction' THEN (direction_result   IN ('hit','miss'))
      ELSE FALSE
    END AS is_eval,
    CASE
      WHEN vars.metric = 'price'     THEN (prediction_result  = 'hit')
      WHEN vars.metric = 'direction' THEN (direction_result   = 'hit')
      ELSE FALSE
    END AS is_hit,
    -- planned move % as PF proxy (use your pnl column if you have one)
    100.0 * ABS(target_price - current_price) / current_price AS planned_move_pct
  FROM base, vars
),

evald AS (
  SELECT *
  FROM filtered
  WHERE is_eval AND h IN (1,2,4,12,24)
),

-- Compute streaks: longest run of consecutive hits per timeframe
streaks AS (
  SELECT
    h,
    prediction_made_time,
    is_hit::int AS is_hit_int,
    -- Group id increments on every miss; consecutive hits share the same grp
    SUM(CASE WHEN NOT is_hit THEN 1 ELSE 0 END)
      OVER (PARTITION BY h ORDER BY prediction_made_time
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS grp
  FROM evald
),

hit_runs AS (
  SELECT
    h,
    grp,
    COUNT(*) AS run_len        -- length of each run of hits
  FROM (
    SELECT h, grp
    FROM streaks
    WHERE is_hit_int = 1
  ) x
  GROUP BY h, grp
),

best_streak AS (
  SELECT
    h,
    COALESCE(MAX(run_len), 0) AS best_streak
  FROM hit_runs
  GROUP BY h
),

-- Aggregate per timeframe
agg AS (
  SELECT
    h,
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE is_hit) AS hits,
    AVG(confidence_level)::float AS avg_conf,                     -- 0..1
    SUM(CASE WHEN is_hit THEN planned_move_pct ELSE 0 END) AS gross_profit_proxy,
    SUM(CASE WHEN NOT is_hit THEN planned_move_pct ELSE 0 END) AS gross_loss_proxy
  FROM evald
  GROUP BY h
)

-- Final output
SELECT
  tf.h AS timeframe_hours,
  COALESCE( (a.hits::numeric / NULLIF(a.total,0)) * 100, 0 )      AS accuracy_pct,
  COALESCE(a.total, 0)                                            AS predictions,
  COALESCE(a.avg_conf * 100, 0)::numeric(6,2)                     AS avg_confidence_pct,
  COALESCE(bs.best_streak, 0)                                     AS best_streak,
  CASE
    WHEN COALESCE(a.gross_loss_proxy, 0) = 0 THEN NULL            -- undefined / perfect
    ELSE ROUND(a.gross_profit_proxy / a.gross_loss_proxy, 2)
  END                                                             AS profit_factor
FROM tf
LEFT JOIN agg a       ON a.h = tf.h
LEFT JOIN best_streak bs ON bs.h = tf.h
ORDER BY tf.h;