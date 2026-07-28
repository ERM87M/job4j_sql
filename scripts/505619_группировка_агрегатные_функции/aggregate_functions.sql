/* Заказы по статусам */

SELECT
    status,
    COUNT(*) AS orders_count
FROM orders
GROUP BY status;


/* Сумма заказов пользователей */

SELECT
    u.id AS user_id,
    u.name AS user_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM users AS u
JOIN orders AS o
    ON o.user_id = u.id
JOIN order_items AS oi
    ON oi.order_id = o.id
GROUP BY u.id, u.name
ORDER BY u.id;


/* Статистика по товарам */

SELECT
    p.id AS product_id,
    p.name AS product_name,
    COUNT(oi.id) AS order_items_count,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity
FROM products AS p
LEFT JOIN order_items AS oi
    ON oi.product_id = p.id
GROUP BY p.id, p.name
ORDER BY p.id;


/* Итоги по заказам */

SELECT
    o.id AS order_id,
    COUNT(oi.id) AS items_count,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS order_total
FROM orders AS o
LEFT JOIN order_items AS oi
    ON oi.order_id = o.id
GROUP BY o.id
ORDER BY o.id;


/* Заказы пользователей по статусам */

SELECT
    u.id AS user_id,
    u.name AS user_name,
    o.status,
    COUNT(o.id) AS orders_count
FROM users AS u
LEFT JOIN orders AS o
    ON o.user_id = u.id
GROUP BY u.id, u.name, o.status
ORDER BY u.id, o.status;


/* Минимальная, максимальная и средняя цена */

SELECT
    p.id AS product_id,
    p.name AS product_name,
    MIN(oi.unit_price) AS min_unit_price,
    MAX(oi.unit_price) AS max_unit_price,
    AVG(oi.unit_price) AS avg_unit_price
FROM products AS p
JOIN order_items AS oi
    ON oi.product_id = p.id
GROUP BY p.id, p.name
ORDER BY p.id;


/* Пользователи и количество заказов */

SELECT
    u.id AS user_id,
    u.name AS user_name,
    COUNT(o.id) AS orders_count
FROM users AS u
LEFT JOIN orders AS o
    ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY u.id;