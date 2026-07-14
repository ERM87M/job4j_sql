INSERT INTO products (name, price, is_active)
VALUES
    ('iPhone 17', 99990.00, true),
    ('MacBook Air M5', 149990.00, true),
    ('AirPods Pro 2', 24990.00, true),
    ('Old Keyboard', 1500.00, false)
RETURNING id, name, price, is_active;