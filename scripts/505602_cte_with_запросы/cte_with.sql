/* Стоимость заказов */

WITH order_item_cost AS (
    SELECT
        order_id,
        quantity * unit_price AS item_cost
    FROM order_items
),
order_total AS (
    SELECT
        order_id,
        SUM(item_cost) AS total_amount
    FROM order_item_cost
    GROUP BY order_id
)
SELECT
    order_id,
    total_amount
FROM order_total;


/* Пользователи выше среднего */

WITH user_totals AS (
    SELECT
        o.user_id,
        SUM(oi.quantity * oi.unit_price) AS total_amount
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.id
    WHERE o.status = 'PAID'
    GROUP BY o.user_id
),
average_total AS (
    SELECT
        AVG(total_amount) AS avg_total
    FROM user_totals
)
SELECT
    u.id AS user_id,
    u.name AS user_name,
    ut.total_amount
FROM users AS u
JOIN user_totals AS ut
    ON ut.user_id = u.id
CROSS JOIN average_total AS at
WHERE ut.total_amount > at.avg_total;


/* Товары без заказов */

WITH ordered_products AS (
    SELECT DISTINCT
        product_id
    FROM order_items
)
SELECT
    p.id AS product_id,
    p.name AS product_name
FROM products AS p
LEFT JOIN ordered_products AS op
    ON op.product_id = p.id
WHERE op.product_id IS NULL;


/* ТОП-5 товаров */

WITH product_sales AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity
    FROM order_items
    GROUP BY product_id
)
SELECT
    p.id AS product_id,
    p.name AS product_name,
    ps.total_quantity
FROM products AS p
JOIN product_sales AS ps
    ON ps.product_id = p.id
ORDER BY ps.total_quantity DESC
LIMIT 5;