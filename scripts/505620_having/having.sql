/* Статусы с количеством заказов >= 3 */

SELECT
    status,
    COUNT(*) AS orders_count
FROM orders
GROUP BY status
HAVING COUNT(*) >= 3;


/* Пользователи с суммой заказов > 10000 */

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
HAVING SUM(oi.quantity * oi.unit_price) > 10000;


/* Продано >= 5 единиц при цене >= 1000 */

SELECT
    p.id AS product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_quantity
FROM products AS p
JOIN order_items AS oi
    ON oi.product_id = p.id
WHERE oi.unit_price >= 1000
GROUP BY p.id, p.name
HAVING SUM(oi.quantity) >= 5;


/* Заказы пользователей по статусам (> 1) */

SELECT
    u.id AS user_id,
    u.name AS user_name,
    o.status,
    COUNT(*) AS orders_count
FROM users AS u
JOIN orders AS o
    ON o.user_id = u.id
GROUP BY u.id, u.name, o.status
HAVING COUNT(*) > 1;


/* Заказы с количеством товаров >= 4 */

SELECT
    order_id,
    SUM(quantity) AS total_quantity
FROM order_items
GROUP BY order_id
HAVING SUM(quantity) >= 4;


/* Пользователи с >= 2 заказами PAID */

SELECT
    u.id AS user_id,
    u.name AS user_name,
    COUNT(*) AS paid_orders_count
FROM users AS u
JOIN orders AS o
    ON o.user_id = u.id
WHERE o.status = 'PAID'
GROUP BY u.id, u.name
HAVING COUNT(*) >= 2;


/* Товары с максимальной ценой > 5000 */

SELECT
    p.id AS product_id,
    p.name AS product_name,
    MIN(oi.unit_price) AS min_unit_price,
    MAX(oi.unit_price) AS max_unit_price
FROM products AS p
JOIN order_items AS oi
    ON oi.product_id = p.id
GROUP BY p.id, p.name
HAVING MAX(oi.unit_price) > 5000;


/* Статусы со средней суммой строки > 2000 */

SELECT
    o.status,
    AVG(oi.quantity * oi.unit_price) AS avg_line_total
FROM orders AS o
JOIN order_items AS oi
    ON oi.order_id = o.id
WHERE o.created_at >= DATE '2025-01-01'
GROUP BY o.status
HAVING AVG(oi.quantity * oi.unit_price) > 2000;