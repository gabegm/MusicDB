-- DROP TABLE IF EXISTS dim_user;

CREATE TABLE IF NOT EXISTS dim_user (id integer primary key autoincrement, user_name TEXT);

INSERT INTO dim_user (user_name)
SELECT DISTINCT user_name
FROM listens;

CREATE UNIQUE INDEX IF NOT EXISTS idx_user_name ON dim_user (user_name);