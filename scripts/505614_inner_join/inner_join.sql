/* Заказы и пользователи */

SELECT
    o.id AS order_id,
    o.status AS статус_заказа,
    u.email AS email_пользователя
FROM orders AS o
JOIN users AS u ON u.id = o.user_id
ORDER BY o.id;

/* Строки заказов с количеством > 1 */

SELECT
    oi.id AS order_item_id,
    oi.order_id,
    p.name AS название_товара,
    oi.quantity AS количество
FROM order_items AS oi
JOIN products AS p ON p.id = oi.product_id
WHERE oi.quantity > 1;

/* Товары в заказах пользователя */

SELECT
    o.id AS order_id,
    p.name AS название_товара,
    oi.quantity AS количество,
    oi.unit_price AS цена_на_момент_покупки
FROM orders AS o
JOIN order_items AS oi ON oi.order_id = o.id
JOIN products AS p ON p.id = oi.product_id
WHERE o.user_id = 1;

/* Заказы со статусом NEW */

SELECT
    o.id AS order_id,
    o.status,
    u.name AS user_name
FROM orders AS o
JOIN users AS u ON u.id = o.user_id
WHERE o.status = 'NEW'
ORDER BY o.id;

/* Стоимость строки заказа */

SELECT
    oi.id AS order_item_id,
    p.name AS название_товара,
    oi.quantity AS количество,
    oi.quantity * oi.unit_price AS line_total
FROM order_items AS oi
JOIN products AS p ON p.id = oi.product_id
ORDER BY oi.id;