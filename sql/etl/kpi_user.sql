-- DROP TABLE IF EXISTS kpi_user;

CREATE TABLE IF NOT EXISTS kpi_user (
    id integer primary key autoincrement
    , listened_at DATE
    , user_id INTEGER
    , listens INTEGER
    , unique_artists
    , unique_tracks INTEGER
    , listen_seconds INTEGER
    , replays INTEGER
);

-- https://ucladatares.medium.com/spotify-trends-analysis-129c8a31cf04
INSERT INTO kpi_user (
    listened_at
    , user_id
    , listens
    , unique_artists
    , unique_tracks
    , listen_seconds
    , replays
)
SELECT
    DATE(listened_at) AS listened_at
    , user_id
    , count(*) AS listens
    , count(distinct(artist_id)) AS unique_artists
    , count(distinct(track_id)) AS unique_tracks
    , count(*) * 3.28 AS listen_seconds
    , count(*) - count(distinct(track_id)) AS replays
FROM fact_listen
GROUP BY
    user_id
    , DATE(listened_at);

-- CREATE UNIQUE INDEX IF NOT EXISTS idx_user_id ON kpi_user (user_id);