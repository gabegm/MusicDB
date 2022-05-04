-- Who are the 10 most active users?
SELECT
    ROW_NUMBER() OVER () as rnk
    , user_name
    , n_listens
FROM (
    SELECT
        du.user_name
        , sum(ku.listens) as n_listens
    FROM kpi_user AS ku
    INNER JOIN dim_user AS du ON (ku.user_id = du.id)
    GROUP BY
        ku.user_id
    ORDER BY
        n_listens DESC
    LIMIT 10
);