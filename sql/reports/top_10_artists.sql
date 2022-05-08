-- Who are the 10 most active users?
SELECT
    ROW_NUMBER() OVER () as rnk
    , artist_name
    , n_listens
FROM (
    SELECT
        da.artist_name
        , count(*) as n_listens
    FROM fact_listen AS fl
    INNER JOIN dim_artist AS da ON (fl.artist_id = da.id)
    GROUP BY
        fl.artist_id
    ORDER BY
        n_listens DESC
    LIMIT 10
);