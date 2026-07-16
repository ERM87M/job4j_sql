INSERT
	INTO
	orders (user_id,
	status)
VALUES
    (1,
'CANCELLED'),
    (1,
'CANCELLED'),
    (1,
'CANCELLED');

SELECT
	id,
	user_id,
	status,
	created_at
FROM
	orders
WHERE
	user_id = 1
	AND status <> 'CANCELLED';