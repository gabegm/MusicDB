CREATE TABLE ds_user AS
WITH favourite_artist AS (
    SELECT
        user_id
        , artist_id
        , n_listens
        , ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY n_listens DESC) AS rnk
    FROM (
        SELECT
            user_id
            , artist_id
            , count(*) as n_listens
        FROM fact_listen
        GROUP BY
            user_id
            , artist_id
    )
)
, favourite_track AS (
    SELECT
        user_id
        , track_id
        , n_listens
        , ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY n_listens DESC) AS rnk
    FROM (
        SELECT
            user_id
            , track_id
            , count(*) as n_listens
        FROM fact_listen
        GROUP BY
            user_id
            , track_id
    )
)
SELECT
    du.user_name
    , count(*) AS n_listens
    , count(distinct(fl.artist_id)) as n_artists
    , count(distinct(fl.track_id)) AS n_tracks
    , CAST(julianday(DATE()) - julianday(MIN(fl.listened_at)) AS INTEGER) AS account_age
    , count(*) + 197 AS listen_seconds
    , count(*) - count(distinct(fl.track_id)) AS replays
    , da.artist_name AS favourite_artist
    , dt.track_name AS favourite_track
    , MAX(count(*)) OVER (PARTITION BY fl.user_id, DATE(listened_at)) AS peak_day
FROM fact_listen as fl
INNER JOIN favourite_artist AS fa ON (fl.user_id = fa.user_id and fa.rnk = 1)
INNER JOIN favourite_track AS ft ON (fl.user_id = ft.user_id and ft.rnk = 1)
LEFT JOIN dim_user AS du ON (fl.user_id = du.id)
LEFT JOIN dim_artist AS da ON (fa.artist_id = da.id)
LEFT JOIN dim_track AS dt ON (ft.track_id = dt.id)
GROUP BY
    du.user_name
ORDER BY
    du.user_name;