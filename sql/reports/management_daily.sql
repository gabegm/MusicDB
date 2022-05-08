-- KPIs
WITH avg_plays AS (
    SELECT
        round(avg(total_plays), 2) AS avg_total_daily_plays
        , round(avg(total_play_minutes), 2) AS avg_total_daily_minutes
    FROM(
        SELECT
            count(*) AS total_plays
            , count(*) * 3.28 AS total_play_minutes
        FROM fact_listen
        GROUP BY
            date(listened_at)
    )
)
SELECT
    count(*) AS total_plays
    , count(*) * 3.28 AS total_play_minuntes
    , avg_plays.avg_total_daily_plays
    , avg_plays.avg_total_daily_minutes
FROM fact_listen
INNER JOIN avg_plays ON (1=1);

-- report
SELECT
    DATE(listened_at) AS listened_at
    , count(distinct(artist_id)) AS artists
    , count(distinct(user_id)) AS users
    , count(*) AS listens
    , count(*) * 3.28 AS listen_minutes
FROM fact_listen
GROUP BY
    DATE(listened_at);