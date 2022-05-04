WITH favourite_artist AS (
    SELECT
        user_name
        , artist_name
        , count(*) as n_listens
        , ROW_NUMBER() OVER (PARTITION BY user_name ORDER BY n_listens DESC) as rnk
    FROM fact_listen
    WHERE rnk = 1
    GROUP BY
        user_name
        , artist_name
)
SELECT
    user_name
    , count(*) AS n_listens
    , count(distinct(artist_name)) as n_artists
    , CAST(julianday(DATE()) - julianday(MIN(listened_at)) AS INTEGER) AS account_age
    --, MAX(count(*)) OVER (PARTITION BY DATE(listened_at)))
FROM fact_listen
GROUP BY
    user_name
ORDER BY
    user_name;