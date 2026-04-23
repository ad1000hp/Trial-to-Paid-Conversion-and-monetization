-- ═══════════════════════════════════════════════════════════════════════════
-- Q4: Monthly cohort — conversion rate by signup month
-- ═══════════════════════════════════════════════════════════════════════════
SELECT
    FORMAT(u.signup_date, 'yyyy-MM')           AS signup_cohort,
    COUNT(*)                                   AS cohort_size,
    SUM(CAST(t.converted AS INT))              AS conversions,
    ROUND(100.0 * SUM(CAST(t.converted AS INT)) / COUNT(*), 2) AS conv_rate_pct,
    ROUND(AVG(CAST(
        DATEDIFF(day, u.signup_date, t.conversion_date) AS FLOAT)),1) AS avg_ttv_days
FROM   fact_trials  t
JOIN   dim_users    u ON t.user_id = u.user_id
GROUP  BY FORMAT(u.signup_date, 'yyyy-MM')
ORDER  BY signup_cohort
