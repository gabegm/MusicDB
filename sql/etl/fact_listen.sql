-- DROP TABLE IF EXISTS fact_listen;

CREATE TABLE IF NOT EXISTS fact_listen (
    id integer primary key autoincrement
    , listened_at DATETIME
    , user_id INTEGER
    , artist_id INTEGER
    , track_id INTEGER
    , recording_msid TEXT
);

INSERT INTO fact_listen (
    listened_at
    , user_id
    , artist_id
    , track_id
    , recording_msid
)
SELECT
    l.listened_at
    , du.id AS user_id
    , da.id AS artist_id
    , dt.id AS track_id
    , l.recording_msid
FROM listens AS l
LEFT JOIN dim_user AS du ON (l.user_name = du.user_name)
LEFT JOIN dim_artist AS da ON (l.artist_name = da.artist_name)
LEFT JOIN dim_track AS dt ON (l.track_name = dt.track_name AND l.release_name = dt.release_name AND da.id = dt.artist_id);

CREATE INDEX IF NOT EXISTS idx_user_id ON fact_listen (user_id);