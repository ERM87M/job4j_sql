/* Добавление новых колонок */

ALTER TABLE users
ADD COLUMN phone TEXT,
ADD COLUMN middle_name TEXT;

ALTER TABLE products
ADD COLUMN description TEXT,
ADD COLUMN discount_price NUMERIC(12, 2);

/* Пользователи без отчества */

SELECT
    id,
    name,
    middle_name
FROM users
WHERE middle_name IS NULL;

/* Товары без описания */

SELECT
    id,
    name,
    description
FROM products
WHERE description IS NULL;

/* Товары без скидочной цены */

SELECT
    id,
    name,
    price,
    discount_price
FROM products
WHERE discount_price IS NULL;

/* Пользователи без телефона */

SELECT
    id,
    name,
    phone
FROM users
WHERE phone IS NULL
   OR phone = '';

/* Описание товара или текст по умолчанию */

SELECT
    id,
    name,
    COALESCE(description, 'описание отсутствует') AS display_description
FROM products;

/* Итоговая цена товара */

SELECT
    id,
    name,
    price,
    discount_price,
    COALESCE(discount_price, price) AS final_price
FROM products;
