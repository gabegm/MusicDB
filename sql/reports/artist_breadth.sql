SELECT
    ROW_NUMBER() OVER () as rnk
    , artist_name
    , breadth
FROM (
    SELECT
        da.artist_name
        , count(distinct(fl.user_id)) AS breadth
    FROM fact_listen as fl
    LEFT JOIN dim_artist AS da ON (fl.artist_id = da.id)
    GROUP BY
        da.artist_name
    ORDER BY
        breadth DESC
    LIMIT 15
);