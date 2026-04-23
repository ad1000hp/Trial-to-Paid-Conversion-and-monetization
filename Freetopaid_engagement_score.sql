--Q3: Engagement Score per trial user (precursor to ML features)
-- ═══════════════════════════════════════════════════════════════════════════
WITH engagement AS (
    SELECT
        e.user_id,
        COUNT(DISTINCT e.event_date)                  AS active_days,
        SUM(CASE WHEN e.event_type='login'            THEN e.event_count ELSE 0 END) AS logins,
        SUM(CASE WHEN e.event_type='feature_used'     THEN e.event_count ELSE 0 END) AS features,
        SUM(CASE WHEN e.event_type='invite_sent'      THEN e.event_count ELSE 0 END) AS invites,
        SUM(CASE WHEN e.event_type='dashboard_created'THEN e.event_count ELSE 0 END) AS dashboards,
        SUM(CASE WHEN e.event_type='support_ticket'   THEN e.event_count ELSE 0 END) AS tickets
    FROM fact_events e
    GROUP BY e.user_id
)
SELECT
    e.*,
    t.converted,
    (e.active_days * 3 + e.features * 2 + e.invites * 4
     + e.dashboards * 3 + e.logins)                   AS engagement_score
FROM   engagement e
JOIN   fact_trials t ON e.user_id = t.user_id
ORDER  BY engagement_score DESC;
