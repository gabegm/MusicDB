SELECT
    ROW_NUMBER() OVER () as rnk
    , track_name
    , n_listens
FROM (
    SELECT
        dt.track_name
        , count(*) as n_listens
    FROM fact_listen AS fl
    INNER JOIN dim_track AS dt ON (fl.track_id = dt.id)
    GROUP BY
        fl.track_id
    ORDER BY
        n_listens DESC
    LIMIT 10
);