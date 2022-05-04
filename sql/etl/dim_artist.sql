DROP TABLE IF EXISTS dim_artist;

CREATE TABLE IF NOT EXISTS dim_artist (id integer primary key autoincrement, artist_name TEXT);

INSERT INTO dim_artist (artist_name)
SELECT DISTINCT artist_name
FROM listens;

CREATE UNIQUE INDEX idx_user_name ON dim_user (artist_name);