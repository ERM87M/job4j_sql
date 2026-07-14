INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 99990.00),
    (1, 3, 2, 24990.00),
    (2, 2, 1, 149990.00)
RETURNING *;