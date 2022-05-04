DROP TABLE IF EXISTS kpi_listen;

CREATE TABLE IF NOT EXISTS kpi_listen (
    id integer primary key autoincrement
    , listened_at DATE
    , artists INTEGER
    , users INTEGER
    , listens INTEGER
);

INSERT INTO kpi_listen (
    listened_at
    , artists
    , users
    , listens
)
SELECT
    DATE(listened_at) AS listened_at
    , count(distinct(artist_id)) AS artists
    , count(distinct(user_id)) AS users
    , count(*) AS listens
FROM fact_listen
GROUP BY
    DATE(listened_at);