/* Категория цены товара */

SELECT
    id,
    name,
    price,
    CASE
        WHEN price < 5000 THEN 'cheap'
        WHEN price <= 50000 THEN 'regular'
        ELSE 'premium'
    END AS price_label
FROM products;

/* Статус телефона */

SELECT
    id,
    name,
    phone,
    CASE
        WHEN phone IS NULL THEN 'not specified'
        ELSE 'specified'
    END AS phone_status
FROM users;

/* Уникальные статусы заказов */

SELECT DISTINCT
    status
FROM orders;

/* Пользователи с заказами */

SELECT DISTINCT
    user_id
FROM orders;

/* Последний заказ каждого пользователя */

SELECT DISTINCT ON (user_id)
    id,
    user_id,
    status,
    created_at
FROM orders
ORDER BY
    user_id,
    created_at DESC;

/* Самый дорогой товар каждого наименования */

SELECT DISTINCT ON (name)
    id,
    name,
    price
FROM products
ORDER BY
    name,
    price DESC,
    id;