CREATE TABLE accounts (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    owner TEXT NOT NULL,
    balance NUMERIC(12, 2) NOT NULL
);

INSERT INTO accounts (owner, balance)
VALUES
    ('Алексей', 10000.00),
    ('Мария', 15000.00),
    ('Иван', 20000.00);


-- Блокировка строки

-- Транзакция 1
BEGIN;

SELECT balance
FROM accounts
WHERE id = 1
FOR UPDATE;


-- Транзакция 2
BEGIN;

UPDATE accounts
SET balance = balance + 1
WHERE id = 1;

-- UPDATE ждёт освобождения строки


-- Транзакция 1
COMMIT;

-- После COMMIT транзакция 2 продолжит UPDATE
COMMIT;


-- Поиск блокирующей транзакции

-- Транзакция 1
BEGIN;

SELECT balance
FROM accounts
WHERE id = 1
FOR UPDATE;


-- Транзакция 2
BEGIN;

UPDATE accounts
SET balance = balance + 1
WHERE id = 1;

-- UPDATE ожидает блокировку


-- Транзакция 3
SELECT
    pid,
    state,
    wait_event_type,
    wait_event,
    pg_blocking_pids(pid) AS blocking_pids,
    query
FROM pg_stat_activity
WHERE datname = current_database();

SELECT
    pid,
    locktype,
    relation,
    mode,
    granted
FROM pg_locks
WHERE pid IS NOT NULL;


-- Взаимная блокировка

-- Транзакция 1
BEGIN;

UPDATE accounts
SET balance = balance + 1
WHERE id = 1;


-- Транзакция 2
BEGIN;

UPDATE accounts
SET balance = balance + 2
WHERE id = 2;


-- Транзакция 1
UPDATE accounts
SET balance = balance + 2
WHERE id = 2;


-- Транзакция 2
UPDATE accounts
SET balance = balance + 1
WHERE id = 1;

-- Возникает взаимоблокировка


-- Исправление сценария

-- Транзакция 1
BEGIN;

SELECT balance
FROM accounts
WHERE id IN (1, 2)
ORDER BY id
FOR UPDATE;

UPDATE accounts
SET balance = balance + 1
WHERE id = 1;

UPDATE accounts
SET balance = balance + 2
WHERE id = 2;

COMMIT;


-- Транзакция 2
BEGIN;

SELECT balance
FROM accounts
WHERE id IN (1, 2)
ORDER BY id
FOR UPDATE;

UPDATE accounts
SET balance = balance + 1
WHERE id = 1;

UPDATE accounts
SET balance = balance + 2
WHERE id = 2;

COMMIT;