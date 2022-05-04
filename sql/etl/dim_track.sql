DROP TABLE IF EXISTS dim_track;

CREATE TABLE IF NOT EXISTS dim_track (id integer primary key autoincrement, track_name TEXT, release_name TEXT,artist_id INTEGER);

INSERT INTO dim_track (track_name, release_name, artist_id)
WITH tracks AS (
    SELECT DISTINCT
        track_name
        , release_name
        , artist_name
    FROM listens
)
SELECT
    t.track_name
    , t.release_name
    , da.id AS artist_id
FROM tracks AS t
LEFT JOIN dim_artist AS da ON (t.artist_name = da.artist_name);