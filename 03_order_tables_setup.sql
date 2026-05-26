-- MySQL Transactions - Order tables setup
-- Self-contained create tables script.
-- Run this file once before running 04_task3_transaction.sql.

USE lab10_transactions;

DROP TABLE IF EXISTS order_line;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer_order;
DROP TABLE IF EXISTS product_order;

CREATE TABLE customer_order (
    cus_code INT PRIMARY KEY,
    cus_lname VARCHAR(30) NOT NULL,
    cus_fname VARCHAR(30) NOT NULL,
    cus_balance DECIMAL(10,2) DEFAULT 0.00
) ENGINE = InnoDB;

CREATE TABLE product_order (
    p_code VARCHAR(20) PRIMARY KEY,
    p_descript VARCHAR(100) NOT NULL,
    p_price DECIMAL(10,2) NOT NULL,
    p_onhand INT NOT NULL
) ENGINE = InnoDB;

CREATE TABLE orders (
    order_number INT PRIMARY KEY,
    cus_code INT NOT NULL,
    order_date DATE NOT NULL,
    order_total DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (cus_code) REFERENCES customer_order(cus_code)
) ENGINE = InnoDB;

CREATE TABLE order_line (
    order_number INT NOT NULL,
    line_number INT NOT NULL,
    p_code VARCHAR(20) NOT NULL,
    line_units INT NOT NULL,
    line_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_number, line_number),
    FOREIGN KEY (order_number) REFERENCES orders(order_number),
    FOREIGN KEY (p_code) REFERENCES product_order(p_code)
) ENGINE = InnoDB;

INSERT INTO customer_order
    (cus_code, cus_lname, cus_fname, cus_balance)
VALUES
    (10010, 'Ramas', 'Alfred', 0.00),
    (10011, 'Dunne', 'Leona', 0.00),
    (10012, 'Smith', 'Kathy', 0.00);

INSERT INTO product_order
    (p_code, p_descript, p_price, p_onhand)
VALUES
    ('13-Q2/P2', '7.25-in. power saw blade', 14.99, 32),
    ('23109-HB', 'Claw hammer', 9.95, 23),
    ('PVC23DRT', 'PVC pipe, 3.5-in., 8-ft', 5.87, 188);

INSERT INTO orders
    (order_number, cus_code, order_date, order_total)
VALUES
    (1001, 10010, '2026-05-01', 24.94),
    (1002, 10011, '2026-05-02', 29.98);

INSERT INTO order_line
    (order_number, line_number, p_code, line_units, line_price)
VALUES
    (1001, 1, '13-Q2/P2', 1, 14.99),
    (1001, 2, '23109-HB', 1, 9.95),
    (1002, 1, '13-Q2/P2', 2, 14.99);

SELECT * FROM customer_order;
SELECT * FROM product_order;
SELECT * FROM orders;
SELECT * FROM order_line;
