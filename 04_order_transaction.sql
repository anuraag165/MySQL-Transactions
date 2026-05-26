-- MySQL Transactions - Order transaction script
-- Transaction script.
-- Run this script by copying and pasting it into the MySQL shell.
-- Each run creates one new order using the next order number.

USE mysql_transactions;

START TRANSACTION;

SET @next_order_number = (
    SELECT IFNULL(MAX(order_number), 1000) + 1
    FROM orders
);

INSERT INTO orders
    (order_number, cus_code, order_date, order_total)
VALUES
    (@next_order_number, 10012, CURDATE(), 0.00);

INSERT INTO order_line
    (order_number, line_number, p_code, line_units, line_price)
VALUES
    (@next_order_number, 1, 'PVC23DRT', 4, 5.87),
    (@next_order_number, 2, '23109-HB', 2, 9.95);

UPDATE orders
SET order_total = (
    SELECT SUM(line_units * line_price)
    FROM order_line
    WHERE order_number = @next_order_number
)
WHERE order_number = @next_order_number;

UPDATE product_order
SET p_onhand = p_onhand - 4
WHERE p_code = 'PVC23DRT';

UPDATE product_order
SET p_onhand = p_onhand - 2
WHERE p_code = '23109-HB';

COMMIT;

-- Final result for recording the transaction output.
SELECT
    o.order_number,
    o.cus_code,
    CONCAT(c.cus_fname, ' ', c.cus_lname) AS customer_name,
    o.order_date,
    o.order_total
FROM orders o
JOIN customer_order c
    ON o.cus_code = c.cus_code
ORDER BY o.order_number;

-- Useful for checking the highest order number after repeated execution.
SELECT MAX(order_number) AS max_order_number
FROM orders;
