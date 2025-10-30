WITH streaks AS (
    SELECT 
        *,
        SUM(CASE WHEN result <> 'hit' THEN 1 ELSE 0 END) OVER(PARTITION BY team ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) grp
    FROM game_predictions
),
agg_streaks AS (
	SELECT team, COUNT(*) streak FROM streaks WHERE result = 'hit' GROUP BY team, grp ORDER BY streak DESC
)
SELECT team, MAX(streak) longest_running_streak FROM agg_streaks GROUP BY team;