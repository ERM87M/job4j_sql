/* 1. Скидка */

CREATE OR REPLACE FUNCTION calculate_discount(
    price NUMERIC,
    discount_percent NUMERIC
)
RETURNS NUMERIC
LANGUAGE SQL
AS
$$
    SELECT price * (100 - discount_percent) / 100;
$$;

SELECT calculate_discount(2500, 15);


/* 2. Полное имя */

CREATE OR REPLACE FUNCTION full_name(
    name TEXT,
    surname TEXT
)
RETURNS TEXT
LANGUAGE SQL
AS
$$
    SELECT name || ' ' || surname;
$$;

SELECT full_name('Джонни', 'Депп');


/* 3. Увеличение цен */

CREATE OR REPLACE PROCEDURE increase_category_prices(
    category_name TEXT,
    percent NUMERIC
)
LANGUAGE SQL
AS
$$
    UPDATE products
    SET price = price * (100 + percent) / 100
    WHERE category = category_name;
$$;

CALL increase_category_prices('Iphone', 15);


/* 4. Архив заказов */

CREATE TABLE orders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE orders_archive (
    id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

INSERT INTO orders (user_id, created_at)
VALUES
    (1, CURRENT_TIMESTAMP - INTERVAL '2 years'),
    (2, CURRENT_TIMESTAMP - INTERVAL '6 months'),
    (3, CURRENT_TIMESTAMP - INTERVAL '400 days');

SELECT * FROM orders;

CREATE OR REPLACE PROCEDURE archive_old_orders()
AS
$$
DECLARE
    cutoff TIMESTAMP := CURRENT_TIMESTAMP - INTERVAL '1 year';
BEGIN
    INSERT INTO orders_archive (id, user_id, created_at)
    SELECT id, user_id, created_at
    FROM orders
    WHERE created_at < cutoff;

    DELETE FROM orders
    WHERE created_at < cutoff;
END;
$$
LANGUAGE plpgsql;

CALL archive_old_orders();

SELECT * FROM orders;
SELECT * FROM orders_archive;
