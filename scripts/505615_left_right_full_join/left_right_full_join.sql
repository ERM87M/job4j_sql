/* Пользователи и количество заказов */

SELECT
    u.id AS user_id,
    u.name AS user_name,
    COUNT(o.id) AS количество_заказов
FROM users AS u
LEFT JOIN orders AS o ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY u.id;


/* Таблица платежей */

CREATE TABLE payments
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES orders(id),
    amount NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
    status TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO payments (order_id, amount, status)
VALUES
    (1, 129990.00, 'PAID'),
    (3, 4990.00, 'FAILED');


/* Заказы без платежей */

SELECT
    o.id AS order_id,
    o.status,
    o.created_at
FROM orders AS o
LEFT JOIN payments AS p ON p.order_id = o.id
WHERE p.order_id IS NULL
ORDER BY o.id;


/* Товары в заказах */

SELECT
    p.id AS product_id,
    p.name AS product_name,
    COUNT(oi.id) AS количество_строк_заказа
FROM products AS p
JOIN order_items AS oi ON oi.product_id = p.id
GROUP BY p.id, p.name
ORDER BY p.id;


/* Роли и количество пользователей */

SELECT
    r.code AS role_code,
    COUNT(ur.user_id) AS user_count
FROM roles AS r
LEFT JOIN user_roles AS ur ON ur.role_id = r.id
GROUP BY r.id, r.code
ORDER BY r.code;


/* Пользователи без ролей */

SELECT
    u.id,
    u.name
FROM users AS u
LEFT JOIN user_roles AS ur ON ur.user_id = u.id
WHERE ur.user_id IS NULL
ORDER BY u.id;


/* Назначение ролей */

SELECT
    r.code,
    ur.user_id
FROM roles AS r
FULL JOIN user_roles AS ur
    ON ur.role_id = r.id;


/* Все комбинации роль × окружение */

SELECT
    r.code AS role_code,
    e.code AS environment_code
FROM roles AS r
CROSS JOIN environments AS e;


/* Категории и родительские категории */

SELECT
    c.id,
    c.name AS category_name,
    p.name AS parent_category_name
FROM categories AS c
LEFT JOIN categories AS p
    ON p.id = c.parent_id;