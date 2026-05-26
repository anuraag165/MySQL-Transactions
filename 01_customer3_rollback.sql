-- MySQL Transactions - Customer3 rollback example
-- Introduction to ROLLBACK behavior in MySQL.

DROP DATABASE IF EXISTS mysql_transactions;
CREATE DATABASE mysql_transactions;
USE mysql_transactions;

DROP TABLE IF EXISTS customer3;

CREATE TABLE customer3 (
    cus_code INT PRIMARY KEY,
    cus_lname VARCHAR(30) NOT NULL,
    cus_fname VARCHAR(30) NOT NULL,
    cus_initial CHAR(1),
    cus_areacode CHAR(3),
    cus_phone VARCHAR(12),
    cus_balance DECIMAL(10,2) DEFAULT 0.00
) ENGINE = InnoDB;

INSERT INTO customer3
    (cus_code, cus_lname, cus_fname, cus_initial, cus_areacode, cus_phone, cus_balance)
VALUES
    (777, 'Di Stefano', 'Alfredo', 'I', '617', '844-2173', 9.80),
    (778, 'Puskas', 'Ferenc', 'K', '619', '844-2273', 45.40),
    (779, 'Ramas', 'Alfred', 'A', '615', '844-2573', 0.00);

-- Step 3: View the original contents.
SELECT * FROM customer3;

-- Step 4: Update customer 777.
UPDATE customer3
SET cus_areacode = '666'
WHERE cus_code = 777;

-- Step 5: View the updated contents.
SELECT * FROM customer3;

-- Step 6: Roll back.
-- Because no explicit START TRANSACTION was used and MySQL autocommit is normally ON,
-- the UPDATE above is already committed and this ROLLBACK will not undo it.
ROLLBACK;

-- View the contents after rollback.
SELECT * FROM customer3;
