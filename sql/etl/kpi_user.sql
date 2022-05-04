DROP TABLE IF EXISTS kpi_user;

CREATE TABLE IF NOT EXISTS kpi_user (
    id integer primary key autoincrement
    , listened_at DATE
    , user_id INTEGER
    , listens INTEGER
);

INSERT INTO kpi_user (listened_at, user_id, listens)
SELECT
    DATE(listened_at) AS listened_at
    , user_id
    , count(*) AS listens
FROM fact_listen
GROUP BY
    user_id
    , listened_at;

CREATE UNIQUE INDEX idx_user_id ON kpi_listen (user_id);