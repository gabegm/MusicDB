SELECT
    DATE(listened_at) AS listened_at
    , count(distinct(artist_id)) AS artists
    , count(distinct(user_id)) AS users
    , count(*) AS listens
    , sum(CASE WHEN time(listened_at) BETWEEN time('00:00:00') AND time('00:59:59') THEN 1 ELSE 0 END) AS h_00
    , sum(CASE WHEN time(listened_at) BETWEEN time('01:00:00') AND time('01:59:59') THEN 1 ELSE 0 END) AS h_01
    , sum(CASE WHEN time(listened_at) BETWEEN time('02:00:00') AND time('02:59:59') THEN 1 ELSE 0 END) AS h_02
    , sum(CASE WHEN time(listened_at) BETWEEN time('03:00:00') AND time('03:59:59') THEN 1 ELSE 0 END) AS h_03
    , sum(CASE WHEN time(listened_at) BETWEEN time('04:00:00') AND time('04:59:59') THEN 1 ELSE 0 END) AS h_04
    , sum(CASE WHEN time(listened_at) BETWEEN time('05:00:00') AND time('05:59:59') THEN 1 ELSE 0 END) AS h_05
    , sum(CASE WHEN time(listened_at) BETWEEN time('06:00:00') AND time('06:59:59') THEN 1 ELSE 0 END) AS h_06
    , sum(CASE WHEN time(listened_at) BETWEEN time('07:00:00') AND time('07:59:59') THEN 1 ELSE 0 END) AS h_07
    , sum(CASE WHEN time(listened_at) BETWEEN time('08:00:00') AND time('08:59:59') THEN 1 ELSE 0 END) AS h_08
    , sum(CASE WHEN time(listened_at) BETWEEN time('09:00:00') AND time('09:59:59') THEN 1 ELSE 0 END) AS h_09
    , sum(CASE WHEN time(listened_at) BETWEEN time('10:00:00') AND time('10:59:59') THEN 1 ELSE 0 END) AS h_10
    , sum(CASE WHEN time(listened_at) BETWEEN time('11:00:00') AND time('11:59:59') THEN 1 ELSE 0 END) AS h_11
    , sum(CASE WHEN time(listened_at) BETWEEN time('12:00:00') AND time('12:59:59') THEN 1 ELSE 0 END) AS h_12
    , sum(CASE WHEN time(listened_at) BETWEEN time('13:00:00') AND time('13:59:59') THEN 1 ELSE 0 END) AS h_13
    , sum(CASE WHEN time(listened_at) BETWEEN time('14:00:00') AND time('14:59:59') THEN 1 ELSE 0 END) AS h_14
    , sum(CASE WHEN time(listened_at) BETWEEN time('15:00:00') AND time('15:59:59') THEN 1 ELSE 0 END) AS h_15
    , sum(CASE WHEN time(listened_at) BETWEEN time('16:00:00') AND time('16:59:59') THEN 1 ELSE 0 END) AS h_16
    , sum(CASE WHEN time(listened_at) BETWEEN time('17:00:00') AND time('17:59:59') THEN 1 ELSE 0 END) AS h_17
    , sum(CASE WHEN time(listened_at) BETWEEN time('18:00:00') AND time('18:59:59') THEN 1 ELSE 0 END) AS h_18
    , sum(CASE WHEN time(listened_at) BETWEEN time('19:00:00') AND time('19:59:59') THEN 1 ELSE 0 END) AS h_19
    , sum(CASE WHEN time(listened_at) BETWEEN time('20:00:00') AND time('20:59:59') THEN 1 ELSE 0 END) AS h_20
    , sum(CASE WHEN time(listened_at) BETWEEN time('21:00:00') AND time('21:59:59') THEN 1 ELSE 0 END) AS h_21
    , sum(CASE WHEN time(listened_at) BETWEEN time('22:00:00') AND time('22:59:59') THEN 1 ELSE 0 END) AS h_22
    , sum(CASE WHEN time(listened_at) BETWEEN time('23:00:00') AND time('23:59:59') THEN 1 ELSE 0 END) AS h_23
FROM fact_listen
GROUP BY
    DATE(listened_at);