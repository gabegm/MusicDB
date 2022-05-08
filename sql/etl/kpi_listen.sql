-- DROP TABLE IF EXISTS kpi_listen;

CREATE TABLE IF NOT EXISTS kpi_listen (
    id integer primary key autoincrement
    , listened_at DATE
    , artists INTEGER
    , users INTEGER
    , listens INTEGER
    , listen_minutes NUMERIC
);

INSERT INTO kpi_listen (
    listened_at
    , artists
    , users
    , listens
    , listen_minutes
)
SELECT
    DATE(listened_at) AS listened_at
    , count(distinct(artist_id)) AS artists
    , count(distinct(user_id)) AS users
    , count(*) AS listens
    , count(*) * 3.28 AS listen_minutes
FROM fact_listen
GROUP BY
    DATE(listened_at);