/* Неиспользуемые кузова */

SELECT
    cb.id,
    cb.name AS body_name
FROM car_bodies AS cb
LEFT JOIN cars AS c ON c.body_id = cb.id
WHERE c.id IS NULL
ORDER BY cb.id;


/* Неиспользуемые двигатели */

SELECT
    ce.id,
    ce.name AS engine_name
FROM car_engines AS ce
LEFT JOIN cars AS c ON c.engine_id = ce.id
WHERE c.id IS NULL
ORDER BY ce.id;


/* Неиспользуемые коробки */

SELECT
    ct.id,
    ct.name AS transmission_name
FROM car_transmissions AS ct
LEFT JOIN cars AS c ON c.transmission_id = ct.id
WHERE c.id IS NULL
ORDER BY ct.id;


/* Машины и кузова */

SELECT
    c.id,
    c.name AS car_name,
    cb.name AS body_name
FROM cars AS c
LEFT JOIN car_bodies AS cb
    ON cb.id = c.body_id
ORDER BY c.id;


/* Машины со всеми деталями */

SELECT
    c.id,
    c.name AS car_name,
    cb.name AS body_name,
    ce.name AS engine_name,
    ct.name AS transmission_name
FROM cars AS c
JOIN car_bodies AS cb
    ON cb.id = c.body_id
JOIN car_engines AS ce
    ON ce.id = c.engine_id
JOIN car_transmissions AS ct
    ON ct.id = c.transmission_id
ORDER BY c.id;


/* Машины без кузова */

SELECT
    c.id,
    c.name AS car_name,
    cb.name AS body_name,
    ce.name AS engine_name
FROM cars AS c
LEFT JOIN car_bodies AS cb
    ON cb.id = c.body_id
JOIN car_engines AS ce
    ON ce.id = c.engine_id
WHERE cb.id IS NULL;


/* Кузова и машины */

SELECT
    cb.id AS body_id,
    cb.name AS body_name,
    c.id AS car_id,
    c.name AS car_name
FROM car_bodies AS cb
LEFT JOIN cars AS c
    ON c.body_id = cb.id
ORDER BY cb.id, c.id;


/* Неиспользуемые двигатели */

SELECT
    ce.id,
    ce.name AS engine_name
FROM car_engines AS ce
LEFT JOIN cars AS c
    ON c.engine_id = ce.id
WHERE c.engine_id IS NULL
ORDER BY ce.id;


/* Машины с автоматической коробкой */

SELECT
    c.id,
    c.name AS car_name,
    cb.name AS body_name,
    ce.name AS engine_name,
    ct.name AS transmission_name
FROM cars AS c
JOIN car_transmissions AS ct
    ON ct.id = c.transmission_id
LEFT JOIN car_bodies AS cb
    ON cb.id = c.body_id
LEFT JOIN car_engines AS ce
    ON ce.id = c.engine_id
WHERE ct.name ILIKE 'automatic%';


/* Машины с отсутствующими деталями */

SELECT
    c.id,
    c.name AS car_name,
    cb.name AS body_name,
    ce.name AS engine_name,
    ct.name AS transmission_name
FROM cars AS c
LEFT JOIN car_bodies AS cb
    ON cb.id = c.body_id
LEFT JOIN car_engines AS ce
    ON ce.id = c.engine_id
LEFT JOIN car_transmissions AS ct
    ON ct.id = c.transmission_id
WHERE cb.id IS NULL
   OR ce.id IS NULL
   OR ct.id IS NULL;


/* Машины с двигателями */

SELECT
    c.id,
    c.name AS car_name,
    ce.name AS engine_name,
    ct.name AS transmission_name
FROM cars AS c
JOIN car_engines AS ce
    ON ce.id = c.engine_id
LEFT JOIN car_transmissions AS ct
    ON ct.id = c.transmission_id;


/* Неиспользуемые детали */

SELECT
    'body' AS detail_type,
    cb.id AS detail_id,
    cb.name AS detail_name
FROM car_bodies AS cb
LEFT JOIN cars AS c
    ON c.body_id = cb.id
WHERE c.id IS NULL

UNION ALL

SELECT
    'engine',
    ce.id,
    ce.name
FROM car_engines AS ce
LEFT JOIN cars AS c
    ON c.engine_id = ce.id
WHERE c.id IS NULL

UNION ALL

SELECT
    'transmission',
    ct.id,
    ct.name
FROM car_transmissions AS ct
LEFT JOIN cars AS c
    ON c.transmission_id = ct.id
WHERE c.id IS NULL;


/* Машины с выбранными кузовами */

SELECT
    c.id,
    c.name AS car_name,
    cb.name AS body_name,
    ce.name AS engine_name,
    ct.name AS transmission_name
FROM cars AS c
JOIN car_bodies AS cb
    ON cb.id = c.body_id
LEFT JOIN car_engines AS ce
    ON ce.id = c.engine_id
LEFT JOIN car_transmissions AS ct
    ON ct.id = c.transmission_id
WHERE cb.name IN ('sedan', 'hatchback', 'suv');