-- MySQL Transactions - Customer4 rollback and commit examples
-- Explicit transaction examples using ROLLBACK and COMMIT.

USE mysql_transactions;

DROP TABLE IF EXISTS customer4;

CREATE TABLE customer4 LIKE customer3;

INSERT INTO customer4
    (cus_code, cus_lname, cus_fname, cus_initial, cus_areacode, cus_phone, cus_balance)
VALUES
    (777, 'Di Stefano', 'Alfredo', 'I', '617', '844-2173', 9.80),
    (778, 'Puskas', 'Ferenc', 'K', '619', '844-2273', 45.40),
    (779, 'Ramas', 'Alfred', 'A', '615', '844-2573', 0.00);

-- Step 1: Confirm original customer4 contents.
SELECT * FROM customer4;

-- Step 2: Run these statements together as one transaction.
START TRANSACTION;

INSERT INTO customer4
    (cus_code, cus_lname, cus_fname, cus_initial, cus_areacode, cus_phone, cus_balance)
VALUES
    (780, 'Cruyff', 'Johan', 'R', '616', '844-2179', 10.00);

UPDATE customer4
SET cus_areacode = '666'
WHERE cus_code = 777;

ROLLBACK;

-- Step 3: View customer4 after rollback.
-- Customer 780 should not exist, and customer 777 should still have area code 617.
SELECT * FROM customer4;

-- Step 4: Run these statements together as another transaction.
START TRANSACTION;

INSERT INTO customer4
    (cus_code, cus_lname, cus_fname, cus_initial, cus_areacode, cus_phone, cus_balance)
VALUES
    (999, 'Boone', 'Megan', 'S', '699', '844-2199', 0.00);

UPDATE customer4
SET cus_areacode = '666'
WHERE cus_code = 779;

COMMIT;

-- This rollback happens after COMMIT, so it has no effect on the committed changes.
ROLLBACK;

-- Final view after commit followed by rollback.
-- Customer 999 should exist, and customer 779 should have area code 666.
SELECT * FROM customer4;
