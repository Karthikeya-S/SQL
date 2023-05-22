-- Transaction     – MySQL transactions, and how to use COMMIT and ROLLBACK to 
--                   manage transactions in MySQL.
-- Table locking   – use MySQL locking for cooperating table access between sessions.

-- MySQL transactions
-- To understand what a transaction in MySQL is, let’s take a look at an example of adding a new sales order in our sample database. The steps of adding a sales order are as described as follows:

-- First, query the latest sales order number from the orders table and use the next sales order number as the new sales order number.
-- Next, insert a new sales order into the orders table.
-- Then, get the newly inserted sales order number
-- After that, insert the new sales order items into the orderdetails table with the sales order number
-- Finally, select data from both orders and orderdetails tables to confirm the changes

-- MySQL transaction statements
-- MySQL provides us with the following important statement to control transactions:

-- To start a transaction, you use the START TRANSACTION  statement. The BEGIN or  BEGIN WORK are the aliases of the START TRANSACTION.
-- To commit the current transaction and make its changes permanent,  you use the COMMIT statement.
-- To roll back the current transaction and cancel its changes, you use the ROLLBACK statement.
-- To disable or enable the auto-commit mode for the current transaction, you use the SET autocommit statement.


-- COMMIT
-- In order to use a transaction, you first have to break the SQL statements into logical portions and determine when data should be committed or rolled back.

-- The following illustrates the step of creating a new sales order:

-- First, start a transaction by using the START TRANSACTION  statement.
-- Next, select the latest sales order number from the orders table and use the next sales order number as the new sales order number.
-- Then, insert a new sales order into the orders table.
-- After that, insert sales order items into the orderdetails table.
-- Finally, commit the transaction using the COMMIT statement.