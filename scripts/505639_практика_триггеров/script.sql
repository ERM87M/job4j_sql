/* 1. История цен */

CREATE TABLE movie_price_history (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    movie_id BIGINT NOT NULL,
    old_price NUMERIC,
    new_price NUMERIC,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION save_price_history()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO movie_price_history (
        movie_id,
        old_price,
        new_price
    )
    VALUES (
        OLD.id,
        OLD.price,
        NEW.price
    );

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER movie_price_history_trigger
AFTER UPDATE OF price
ON movies
FOR EACH ROW
WHEN (OLD.price IS DISTINCT FROM NEW.price)
EXECUTE FUNCTION save_price_history();


/* 2. Проверка цены */

CREATE OR REPLACE FUNCTION check_movie_price()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.price < 0 THEN
        RAISE EXCEPTION 'Цена фильма не может быть отрицательной.';
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_movie_price_trigger
BEFORE INSERT OR UPDATE
ON movies
FOR EACH ROW
EXECUTE FUNCTION check_movie_price();


/* Проверка */

UPDATE movies
SET price = 350
WHERE id = 1;

SELECT * FROM movie_price_history;

UPDATE movies
SET price = -100
WHERE id = 1;


