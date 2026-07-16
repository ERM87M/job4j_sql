SELECT
	id,
	name,
	price
FROM
	products
WHERE
	is_active = TRUE
	AND
(price < 3000
		OR price >150000)