-- Q5: MRR breakdown by plan and churn status
-- ═══════════════════════════════════════════════════════════════════════════
SELECT
    s.[plan],
    COUNT(*)                                        AS subscribers,
    SUM(s.mrr)                                      AS total_mrr,
    SUM(CASE WHEN s.churn_date IS NULL THEN s.mrr ELSE 0 END) AS active_mrr,
    SUM(CASE WHEN s.churn_date IS NOT NULL THEN s.mrr ELSE 0 END) AS churned_mrr,
    ROUND(100.0 * COUNT(CASE WHEN s.churn_date IS NOT NULL THEN 1 END) / COUNT(*), 2)
                                                    AS churn_rate_pct
FROM   fact_subscriptions s
GROUP  BY s.[plan]
ORDER  BY total_mrr DESC;
