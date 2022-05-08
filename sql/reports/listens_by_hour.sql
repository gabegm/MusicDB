SELECT
    strftime('%H', listened_at) AS listened_at
    , count(*) AS listens
FROM fact_listen
GROUP BY
    strftime('%H', listened_at);