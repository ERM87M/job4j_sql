/* Пользователи PAID или NEW */

SELECT
    user_id
FROM orders
WHERE status = 'PAID'

UNION

SELECT
    user_id
FROM orders
WHERE status = 'NEW';


/* Общий список событий */

SELECT
    'user' AS entity_type,
    id AS entity_id,
    created_at
FROM users

UNION ALL

SELECT
    'product' AS entity_type,
    id AS entity_id,
    created_at
FROM products

UNION ALL

SELECT
    'order' AS entity_type,
    id AS entity_id,
    created_at
FROM orders

ORDER BY created_at DESC;


/* Активные товары из заказов */

SELECT
    p.id AS product_id,
    p.name AS product_name
FROM products AS p
WHERE p.is_active = TRUE

INTERSECT

SELECT
    p.id AS product_id,
    p.name AS product_name
FROM products AS p
JOIN order_items AS oi
    ON oi.product_id = p.id

ORDER BY product_id;


/* Активные товары без заказов */

SELECT
    id AS product_id,
    name AS product_name
FROM products
WHERE is_active = TRUE

EXCEPT

SELECT
    p.id AS product_id,
    p.name AS product_name
FROM products AS p
JOIN order_items AS oi
    ON oi.product_id = p.id;


/* Пользователи с заказами или новые */

SELECT
    u.id AS user_id,
    u.name AS user_name
FROM users AS u
JOIN orders AS o
    ON o.user_id = u.id

UNION

SELECT
    id AS user_id,
    name AS user_name
FROM users
WHERE created_at > DATE '2025-01-01';


/* Дорогие товары из заказов */

SELECT
    id AS product_id,
    name AS product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)

INTERSECT

SELECT
    p.id AS product_id,
    p.name AS product_name,
    p.price
FROM products AS p
JOIN order_items AS oi
    ON oi.product_id = p.id

ORDER BY product_id;


/* Пользователи без CANCELLED */

SELECT
    u.id AS user_id,
    u.name AS user_name
FROM users AS u
JOIN orders AS o
    ON o.user_id = u.id

EXCEPT

SELECT
    u.id AS user_id,
    u.name AS user_name
FROM users AS u
JOIN orders AS o
    ON o.user_id = u.id
WHERE o.status = 'CANCELLED';


/* Общий поиск */

SELECT
    'user' AS entity_type,
    id AS entity_id,
    name AS display_name
FROM users

UNION ALL

SELECT
    'product' AS entity_type,
    id AS entity_id,
    name AS display_name
FROM products;