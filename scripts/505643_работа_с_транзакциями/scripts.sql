CREATE TABLE orders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_name TEXT NOT NULL,
    status TEXT NOT NULL
);

CREATE TABLE order_items (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES orders(id),
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price NUMERIC(12, 2) NOT NULL CHECK (price > 0)
);


BEGIN;

 /* Создаём заказ */
INSERT INTO orders (
    customer_name,
    status
)
VALUES (
    'Иван Петров',
    'NEW'
);

SAVEPOINT order_created;

/* Добавляем товары */
INSERT INTO order_items (
    order_id,
    product_name,
    quantity,
    price
)
VALUES
    (1, 'Ноутбук', 1, 90000),
    (1, 'Мышь', 2, 2500);

SAVEPOINT items_added;


 /* Ошибка количество не может быть отрицательным */
INSERT INTO order_items (
    order_id,
    product_name,
    quantity,
    price
)
VALUES
    (1, 'Монитор', -2, 30000);

 /* Откатываем ошибочную операцию */
ROLLBACK TO items_added;


/* Добавляем монитор правильно */
INSERT INTO order_items (
    order_id,
    product_name,
    quantity,
    price
)
VALUES
    (1, 'Монитор', 1, 3000);


/* меняем статус заказа */
UPDATE orders
SET status = 'PROCESSING'
WHERE customer_name = 'Иван Петров';


/* Откатываем всё после создание заказа */
ROLLBACK TO order_created;


/* Добавляем товары заного */
INSERT INTO order_items (
    order_id,
    product_name,
    quantity,
    price
)
VALUES
    (1, 'Ноутбук', 1, 85000),
    (1, 'Монитор', 2, 28000),
    (1, 'Клавиатура', 1, 7000);
COMMIT;