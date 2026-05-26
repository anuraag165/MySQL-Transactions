# MySQL Transactions

This project demonstrates transaction-based operations in MySQL, including rollback, commit, and simple order processing.
It is designed as a reference/tutorial for understanding how transactions help maintain database consistency.

---

## 👨‍💻 Programmer

Anuraag Raj

---

## 📂 Project Structure

* `01_task1_customer3.sql`
  Contains SQL commands for:

  * Creating the `customer3` table
  * Inserting sample customer records
  * Updating a customer record
  * Running `ROLLBACK` without an explicit transaction

* `02_task2_customer4.sql`
  Contains SQL commands for:

  * Creating the `customer4` table
  * Running a transaction with `ROLLBACK`
  * Running a transaction with `COMMIT`
  * Comparing committed and rolled-back changes

* `03_task3_create_tables.sql`
  Contains SQL commands for:

  * Creating customer, product, order, and order-line tables
  * Inserting sample order-processing data

* `04_task3_transaction.sql`
  Contains SQL commands for:

  * Starting a transaction
  * Inserting a new order
  * Inserting order-line records
  * Updating order totals
  * Updating product stock
  * Committing the transaction

---

## 🚀 How to Run

Open MySQL Workbench or the MySQL command line and run the scripts in this order:

```sql
SOURCE 01_task1_customer3.sql;
SOURCE 02_task2_customer4.sql;
SOURCE 03_task3_create_tables.sql;
SOURCE 04_task3_transaction.sql;
```

Run `04_task3_transaction.sql` a second time to see how the results change after repeated execution.

---

## 📝 What You Will See

* A `customer3` table showing that rollback does not undo changes already committed by autocommit
* A `customer4` table showing how explicit transactions can undo changes with `ROLLBACK`
* A committed transaction where later rollback does not undo saved changes
* Order tables that receive a new order each time the transaction script is executed
* Product stock values updated as part of the order transaction

---

## 🎯 Learning Outcomes

* Understand the purpose of transactions in MySQL
* Learn how `START TRANSACTION`, `ROLLBACK`, and `COMMIT` work
* See the effect of MySQL autocommit on rollback behavior
* Use transactions to group multiple SQL statements as one unit of work
* Understand how repeated transaction execution changes stored data

---

## 📖 Explanation Notes

### Customer3 Rollback

After `ROLLBACK`, the `customer3` table is not different from the table seen immediately after the update. The area code for customer `777` remains `666`.

This happens because the update was not inside an explicit transaction. In MySQL, autocommit is normally enabled, so the `UPDATE` statement is committed immediately. Once it has been committed, a later `ROLLBACK` cannot undo it.

### Customer4 Rollback

After the first transaction is rolled back, the `customer4` table returns to its original contents.

Customer `780` is not inserted, and customer `777` keeps the original area code `617`. This is because both the insert and update were performed after `START TRANSACTION` and before `ROLLBACK`, so both changes were undone.

### Customer4 Commit

After the second transaction, customer `999` appears in the table, and customer `779` has area code `666`.

This is different from the rollback example because the transaction uses `COMMIT` before `ROLLBACK`. The `COMMIT` permanently saves the insert and update. The `ROLLBACK` after the commit has no effect.

### Order Transaction

The transaction script displays all orders, including the new order inserted by the script. The script calculates the next order number, inserts a new order, inserts order lines, updates the order total, updates product stock, and commits the transaction.

The maximum order number is shown by:

```sql
SELECT MAX(order_number) AS max_order_number
FROM orders;
```

After running the create-tables script, the first transaction run creates order `1003`. Running the transaction script again creates order `1004`.

Each time the transaction script is run, it finds the current maximum order number, adds `1`, inserts a new order with that number, inserts order-line records, updates the order total, decreases product stock, and commits the changes.

---

## 📌 Notes

* MySQL normally runs with autocommit enabled.
* `ROLLBACK` only undoes changes that are part of an active uncommitted transaction.
* `COMMIT` permanently saves the current transaction.
* A `ROLLBACK` issued after `COMMIT` does not undo the committed changes.
