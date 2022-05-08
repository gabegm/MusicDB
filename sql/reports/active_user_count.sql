-- How many users were active on the 1st of March 2019?
SELECT
    count(distinct(user_id)) as n
FROM fact_listen
WHERE date(listened_at) = DATE('2019-03-01');

--or
SELECT
    users
FROM kpi_listen
WHERE listened_at = DATE('2019-03-01');