CREATE TABLE folders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    parent_id BIGINT REFERENCES folders(id)
);

INSERT INTO folders (name, parent_id)
VALUES
    ('Projects', NULL),
    ('Backend', 1),
    ('Frontend', 1),
    ('Java', 2),
    ('Python', 2),
    ('src', 4),
    ('test', 4),
    ('React', 3),
    ('components', 8),
    ('utils', 9),
    ('images', 8);


/* Дерево каталогов */

WITH RECURSIVE folder_tree AS (
    SELECT
        id,
        name AS folder_name,
        parent_id,
        0 AS level,
        ARRAY[id] AS path
    FROM folders
    WHERE id = 1

    UNION ALL

    SELECT
        f.id,
        f.name AS folder_name,
        f.parent_id,
        ft.level + 1 AS level,
        ft.path || f.id AS path
    FROM folders AS f
    JOIN folder_tree AS ft
        ON f.parent_id = ft.id
)
SELECT
    repeat('  ', level) || folder_name AS folder_name,
    level
FROM folder_tree
ORDER BY path;


/* Полный путь */

WITH RECURSIVE path_builder AS (
    SELECT
        id,
        name,
        parent_id,
        ARRAY[name] AS path_array
    FROM folders
    WHERE id = 10

    UNION ALL

    SELECT
        f.id,
        f.name,
        f.parent_id,
        f.name || pb.path_array AS path_array
    FROM folders AS f
    JOIN path_builder AS pb
        ON f.id = pb.parent_id
)
SELECT
    array_to_string(path_array, ' -> ') AS full_path
FROM path_builder
WHERE parent_id IS NULL;


/* Дерево без циклов */

WITH RECURSIVE folder_tree AS (
    SELECT
        id,
        name AS folder_name,
        parent_id,
        0 AS level,
        ARRAY[id] AS sort_path
    FROM folders
    WHERE id = 1

    UNION ALL

    SELECT
        f.id,
        f.name AS folder_name,
        f.parent_id,
        ft.level + 1 AS level,
        ft.sort_path || f.id AS sort_path
    FROM folders AS f
    JOIN folder_tree AS ft
        ON f.parent_id = ft.id
)
CYCLE id
SET is_cycle
USING cycle_path
SELECT
    repeat('  ', level) || folder_name AS folder_name,
    level
FROM folder_tree
WHERE NOT is_cycle
ORDER BY sort_path;