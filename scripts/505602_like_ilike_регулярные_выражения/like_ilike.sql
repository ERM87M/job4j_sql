/* Создание таблицы vacancies */

CREATE TABLE vacancies
(
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title       TEXT        NOT NULL,
    company     TEXT        NOT NULL,
    description TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO vacancies (title, company, description)
VALUES
('Java Developer', 'Yandex', 'Разработка микросервисов на Java'),
('Python Developer', 'VK', 'Разработка backend-сервисов на Python'),
('PostgreSQL DBA', 'T-Bank', 'Администрирование и оптимизация баз данных PostgreSQL'),
('Frontend Developer', 'Avito', 'Разработка пользовательских интерфейсов на React'),
('Go Developer', 'Ozon', 'Разработка высоконагруженных сервисов на Go'),
('DevOps Engineer', 'Selectel', 'Настройка CI/CD и сопровождение инфраструктуры');

/* Пользователи с email, содержащим mail */

SELECT id, name, email
FROM users
WHERE	email ILIKE	'%mail%';

/* Товары с air в названии */

SELECT id, name, price
FROM products
WHERE name ILIKE '%air%';

/* Товары, начинающиеся на i */

SELECT id, name, price
FROM products
WHERE name LIKE 'i%';

/* Товары, оканчивающиеся на pro */

SELECT id, name, price
FROM products
WHERE name LIKE '%pro';

/* Пользователи с именем на A или I */

SELECT id, name, email
FROM users
WHERE	name ILIKE	'A%' OR name ILIKE	'I%';

/* Вакансии с java, go или postgres */

SELECT id, title, company, description
FROM	vacancies
WHERE title ~* '(java|go|postgres)' OR description ~* '(java|go|postgres)';

SELECT id, title, company, description
FROM vacancies
WHERE title ILIKE '%java%'
   OR title ILIKE '%go%'
   OR title ILIKE '%postgres%'
   OR description ILIKE '%java%'
   OR description ILIKE '%go%'
   OR description ILIKE '%postgres%';

/* iPhone с номером модели (Regex) */

SELECT id, name, price
FROM products
WHERE name ~* '^iPhone\s*\d+';