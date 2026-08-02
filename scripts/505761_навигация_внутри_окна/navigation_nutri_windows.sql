/* Стоимость заказов пользователя */

WITH order_totals AS (
    SELECT
        o.id,
        o.user_id,
        o.created_at,
        SUM(oi.quantity * oi.unit_price) AS order_amount
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.id
    GROUP BY
        o.id,
        o.user_id,
        o.created_at
)

SELECT
    user_id,
    id AS order_id,
    created_at,
    order_amount,
    FIRST_VALUE(order_amount) OVER user_orders AS first_order_amount,
    LAST_VALUE(order_amount) OVER user_orders AS last_order_amount,
    NTH_VALUE(order_amount, 2) OVER user_orders AS second_order_amount
FROM order_totals

WINDOW user_orders AS (
    PARTITION BY user_id
    ORDER BY created_at
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)

ORDER BY
    user_id,
    created_at;