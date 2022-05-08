SELECT
    dd.month
    , count(*) AS listens
FROM fact_listen as fl
INNER JOIN dim_date AS dd ON (date(fl.listened_at) = dd.d)
GROUP BY
    dd.month;