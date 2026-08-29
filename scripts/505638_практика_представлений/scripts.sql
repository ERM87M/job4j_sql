/* 1. Представление просмотров */

CREATE VIEW v_movie_views AS
SELECT
    v.id AS view_id,
    u.full_name AS user_full_name,
    m.title AS movie_title,
    v.watched_at,
    v.watch_time_minutes
FROM views AS v
JOIN users AS u ON v.user_id = u.id
JOIN movies AS m ON v.movie_id = m.id;

SELECT * FROM v_movie_views;


/* 2. Представление для поддержки */

CREATE VIEW v_support_users AS
SELECT
    id,
    full_name,
    email,
    created_at
FROM users;

SELECT * FROM v_support_users;

/*
Безопаснее предоставить доступ к представлению,
потому что оно не содержит телефон и другие данные,
которые сотрудникам поддержки видеть не нужно.
*/


/* 3. Маскирование телефона */

CREATE VIEW v_delivery_users AS
SELECT
    id,
    full_name,
    '*******' || RIGHT(phone, 4) AS phone
FROM users;

SELECT * FROM v_delivery_users;


/* 4. Только активные подписки */

CREATE VIEW v_active_subscriptions AS
SELECT *
FROM subscriptions
WHERE is_active = TRUE
WITH CHECK OPTION;

SELECT * FROM v_active_subscriptions;

/*
UPDATE с is_active = FALSE будет отклонён.
WITH CHECK OPTION запрещает изменять строку так,
чтобы она перестала соответствовать условию view.
*/


/* 5. Материализованное представление */

CREATE MATERIALIZED VIEW mv_movie_statistics AS
SELECT
    m.id AS movie_id,
    m.title,
    COUNT(v.movie_id) AS total_views,
    SUM(v.watch_time_minutes) AS total_watch_time
FROM movies AS m
JOIN views AS v ON v.movie_id = m.id
GROUP BY m.id, m.title
WITH NO DATA;


/* Первоначальное заполнение */

REFRESH MATERIALIZED VIEW mv_movie_statistics;

SELECT * FROM mv_movie_statistics;


/*
Материализованное представление подходит здесь,
потому что статистика считается один раз,
а затем готовые данные быстро читаются.
Обновлять её можно один раз ночью.

Обычное VIEW каждый раз заново выполняло бы
тяжёлый запрос по таблице views.
*/