/* Товары дешевле средней цены */

SELECT
    id AS product_id,
    name AS product_name,
    price
FROM products
WHERE price < (
    SELECT AVG(price)
    FROM products
);


/* Пользователи с заказами PAID */

SELECT
    u.id AS user_id,
    u.name AS user_name,
    u.email
FROM users AS u
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.user_id = u.id
      AND o.status = 'PAID'
);


/* Пользователи без заказов */

SELECT
    u.id AS user_id,
    u.name AS user_name,
    u.email
FROM users AS u
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.user_id = u.id
);


/* Товары из заказов */

SELECT
    id AS product_id,
    name AS product_name,
    price
FROM products
WHERE id IN (
    SELECT product_id
    FROM order_items
);


/* Заказы дороже 10000 */

SELECT
    t.order_id,
    t.order_total
FROM (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS t
WHERE t.order_total > 10000;


/* Количество заказов пользователей */

SELECT
    u.id AS user_id,
    u.name AS user_name,
    (
        SELECT COUNT(*)
        FROM orders AS o
        WHERE o.user_id = u.id
    ) AS orders_count
FROM users AS u;


/* Продажи выше среднего */

SELECT
    product_id,
    SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id
HAVING SUM(quantity) > (
    SELECT AVG(total_quantity)
    FROM (
        SELECT
            product_id,
            SUM(quantity) AS total_quantity
        FROM order_items
        GROUP BY product_id
    ) AS product_totals
);


/* Заказы выше средней суммы */

SELECT
    t.order_id,
    t.order_total
FROM (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS t
WHERE t.order_total > (
    SELECT AVG(order_total)
    FROM (
        SELECT
            order_id,
            SUM(quantity * unit_price) AS order_total
        FROM order_items
        GROUP BY order_id
    ) AS order_totals
);