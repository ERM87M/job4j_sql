/* Сумма каждого заказа и общая сумма пользователя */

SELECT
    o.id AS order_id,
    o.user_id,
    SUM(oi.quantity * oi.unit_price) AS total_amount,
    SUM(SUM(oi.quantity * oi.unit_price)) OVER (PARTITION BY o.user_id) AS user_total
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id, o.user_id;


/* Сумма заказа и средний чек пользователя */

SELECT
    o.id AS order_id,
    o.user_id,
    SUM(oi.quantity * oi.unit_price) AS total_amount,
    AVG(SUM(oi.quantity * oi.unit_price)) OVER (PARTITION BY o.user_id) AS average_order_amount
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id, o.user_id;


/* Порядковый номер заказа пользователя */

SELECT
    o.id AS order_id,
    o.user_id,
    o.created_at,
    ROW_NUMBER() OVER (PARTITION BY o.user_id ORDER BY o.created_at) AS row_number
FROM orders o;


/* Рейтинг заказов по стоимости (RANK) */

SELECT
    o.id AS order_id,
    SUM(oi.quantity * oi.unit_price) AS total_amount,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS order_rank
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id;


/* Рейтинг заказов по стоимости (DENSE_RANK) */

SELECT
    o.id AS order_id,
    SUM(oi.quantity * oi.unit_price) AS total_amount,
    DENSE_RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS order_rank
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id;


/* Разделить заказы на 4 группы */

SELECT
    o.id AS order_id,
    SUM(oi.quantity * oi.unit_price) AS total_amount,
    NTILE(4) OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS group_number
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id;


/* Статистика заказов пользователя (WINDOW) */

SELECT
    o.id AS order_id,
    o.user_id,
    SUM(oi.quantity * oi.unit_price) AS total_amount,
    SUM(SUM(oi.quantity * oi.unit_price)) OVER w AS user_total,
    AVG(SUM(oi.quantity * oi.unit_price)) OVER w AS average_order_amount,
    COUNT(*) OVER w AS orders_count
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id, o.user_id
WINDOW w AS (PARTITION BY o.user_id);