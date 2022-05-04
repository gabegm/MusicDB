-- For every user, what was the first song they listened to?
WITH users AS (
    SELECT
        user_id
        , min(listened_at) AS listened_at
    FROM fact_listen
    GROUP BY
        user_id
)
SELECT
    fl.listened_at
    , fl.user_id
    , dt.track_name
FROM fact_listen AS fl
INNER JOIN users AS u ON (fl.user_id = u.user_id AND fl.listened_at = u.listened_at)
INNER JOIN dim_track AS dt ON (fl.track_id = dt.id)
ORDER BY
    fl.listened_at ASC;