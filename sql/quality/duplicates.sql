SELECT
    *
FROM (
    SELECT
        user_name
        , count(*) AS n
    FROM dim_user
    GROUP BY
        user_name
) WHERE n > 1;

SELECT
    *
FROM (
    SELECT
        artist_name
        , count(*) AS n
    FROM dim_artist
    GROUP BY
        artist_name
) WHERE n > 1;

SELECT
    *
FROM (
    SELECT
        track_name
        , release_name
        , artist_id
        , count(*) AS n
    FROM dim_track
    GROUP BY
        track_name
        , release_name
        , artist_id
) WHERE n > 1
ORDER BY
    n DESC;