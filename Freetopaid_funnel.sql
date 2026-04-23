-- ═══════════════════════════════════════════════════════════════════════════
-- Q2: Funnel — Users at each stage of the trial journey
-- ═══════════════════════════════════════════════════════════════════════════
SELECT
    stage,
    users,
    ROUND(100.0 * users / MAX(users) OVER (), 1) AS pct_of_top
FROM (
    SELECT 1 AS ord, 'Stage 1: Trial Started'        AS stage,
           COUNT(DISTINCT t.user_id)                 AS users
    FROM   fact_trials t
    UNION ALL
    SELECT 2, 'Stage 2: At Least 1 Login',
           COUNT(DISTINCT e.user_id)
    FROM   fact_events e WHERE e.event_type = 'login'
    UNION ALL
    SELECT 3, 'Stage 3: Used Core Feature',
           COUNT(DISTINCT e.user_id)
    FROM   fact_events e WHERE e.event_type = 'feature_used'
    UNION ALL
    SELECT 4, 'Stage 4: Invited Team Member',
           COUNT(DISTINCT e.user_id)
    FROM   fact_events e WHERE e.event_type = 'invite_sent'
    UNION ALL
    SELECT 5, 'Stage 5: Created Dashboard',
           COUNT(DISTINCT e.user_id)
    FROM   fact_events e WHERE e.event_type = 'dashboard_created'
    UNION ALL
    SELECT 6, 'Stage 6: Converted to Paid',
           SUM(CAST(t.converted AS INT))
    FROM   fact_trials t
) x
ORDER BY ord;
