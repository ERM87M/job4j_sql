INSERT INTO orders (user_id, status)
VALUES
    (1, 'NEW'),
    (2, 'PAID')
RETURNING id, user_id, status, created_at;