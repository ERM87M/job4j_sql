/* 1. Курсор products */

BEGIN;

DECLARE products_cursor CURSOR FOR
    SELECT id, name, price
    FROM products;

FETCH 3 FROM products_cursor;

FETCH 2 FROM products_cursor;

CLOSE products_cursor;

COMMIT;


/* 2. Курсор orders */

BEGIN;

DECLARE orders_cursor CURSOR FOR
    SELECT *
    FROM orders;

FETCH 5 FROM orders_cursor;

FETCH 5 FROM orders_cursor;

CLOSE orders_cursor;

COMMIT;


/* 3. Курсор с перемещением */

BEGIN;

DECLARE scroll_cursor SCROLL CURSOR FOR
    SELECT *
    FROM orders;

FETCH 3 FROM scroll_cursor;

MOVE BACKWARD 2 FROM scroll_cursor;

FETCH 2 FROM scroll_cursor;

CLOSE scroll_cursor;

COMMIT;