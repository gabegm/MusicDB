-- DROP TABLE IF EXISTS kpi_track;

CREATE TABLE IF NOT EXISTS kpi_track (
    id integer primary key autoincrement
    , listened_at DATE
    , track_id INTEGER
    , listens INTEGER
    , users INTEGER
);

-- https://ucladatares.medium.com/spotify-trends-analysis-129c8a31cf04
INSERT INTO kpi_track (
    listened_at
    , track_id
    , listens
    , users
)
SELECT
    DATE(listened_at) AS listened_at
    , track_id
    , count(*) AS listens
    , count(distinct(user_id)) as users
FROM fact_listen
GROUP BY
    track_id
    , DATE(listened_at);

-- CREATE UNIQUE INDEX IF NOT EXISTS idx_track_id ON kpi_track (track_id);