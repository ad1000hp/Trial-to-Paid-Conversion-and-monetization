-- ═══════════════════════════════════════════════════════════════════════════
-- Q6: A/B Test — Onboarding variant conversion comparison
-- ═══════════════════════════════════════════════════════════════════════════
SELECT
    group_name,
    COUNT(*)                                        AS total_users,
    SUM(CAST(completed_onboarding AS INT))          AS completed_onboarding,
    SUM(CAST(converted AS INT))                     AS converted,
    ROUND(100.0 * SUM(CAST(completed_onboarding AS INT)) / COUNT(*), 2)
                                                    AS onboarding_completion_pct,
    ROUND(100.0 * SUM(CAST(converted AS INT)) / COUNT(*), 2)
                                                    AS conversion_rate_pct
FROM   fact_ab_test
GROUP  BY group_name;
