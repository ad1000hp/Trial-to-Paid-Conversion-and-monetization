-- Q1: Overall & Segmented Trial Conversion Rates
-- ═══════════════════════════════════════════════════════════════════════════
SELECT
    u.industry,
    u.company_size,
    COUNT(*)                                       AS total_trials,
    SUM(CAST(t.converted AS INT))                  AS converted_users,
    ROUND(
      100.0 * SUM(CAST(t.converted AS INT)) / COUNT(*), 2
    )                                              AS conversion_rate_pct
FROM   fact_trials   t
JOIN   dim_users     u ON t.user_id = u.user_id
GROUP  BY u.industry, u.company_size
ORDER  BY conversion_rate_pct DESC;
