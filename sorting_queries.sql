-- ORDER BY CLAUSE

SELECT select_list
FROM
    table_name
ORDER BY
    col1 [ASC|DESC]
    col2 [ASC|DESC]

SELECT
    contactLastname,
    contactFirstname
FROM
    customers
ORDER BY
    contactLastname;

-- Last Name in Descending ORDER 

SELECT
    contactLastname,
    contactFirstname
FROM
    customers
ORDER BY
    contactLastname DESC;

-- Last Name in Descending ORDER BY
-- First Name in Ascending ORDER BY

SELECT
    contactLastname,
    contactFirstname
FROM
    customers
ORDER BY
    contactLastname DESC,
    contactFirstname ASC;

-- Limiting to 20
SELECT
    contactLastname,
    contactFirstname
FROM
    customers
ORDER BY
    contactLastname DESC,
    contactFirstname ASC limit 20;

--orderdetails TABLE

select * from orderdetails limit 10;

-- Orderline items from orderdetails TABLE
-- to calculate subtotal and sort by subtotal

SELECT
    orderNumber,
    orderlinenumber,
    quantityOrdered * priceEach AS Subtotal
FROM
    orderdetails
ORDER BY
    quantityOrdered * priceEach DESC LIMIT 20;

SELECT
    orderNumber,
    orderlinenumber,
    quantityOrdered * priceEach AS Subtotal
FROM
    orderdetails
ORDER BY
    Subtotal DESC LIMIT 20;

-- FIELD FUNCTION

SELECT FIELD('A', 'B', 'C');

SELECT FIELD('B', 'A', 'B', 'C');
SELECT FIELD('A', 'A', 'C');

SELECT orderNumber, status FROM orders LIMIT 10;

SELECT 
    orderNumber, 
    status
FROM
    orders
ORDER BY
    FIELD(
        status,
        "In Process",
        "On Hold",
        "Cancelled",
        "Resolved",
        "Disputed",
        "Shipped"
    ) LIMIT 30;

SELECT 
    orderNumber, 
    status
FROM
    orders
ORDER BY
    FIELD(
        status,
        "In Process",
        "On Hold"
        
    ) LIMIT 30;

SELECT
    firstName, lastName, reportsTo
FROM
    
ORDER BY
    reportsTo LIMIT 20;