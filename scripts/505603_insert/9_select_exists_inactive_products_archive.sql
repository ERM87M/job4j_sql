DROP TABLE IF EXISTS inactive_products_archive;

CREATE TABLE inactive_products_archive
(
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id   BIGINT         NOT NULL,
    product_name TEXT           NOT NULL,
    price        NUMERIC(12, 2) NOT NULL,
    archived_at  TIMESTAMPTZ    NOT NULL DEFAULT now()
);

INSERT INTO inactive_products_archive (product_id, product_name, price)
SELECT id, name, price
FROM products
WHERE is_active=false
RETURNING id, product_id, product_name, price;