SELECT
    lastName,
    firstName
FROM
    employees
WHERE
    officeCode IN(
        SELECT officeCode FROM offices WHERE country = "USA"
    );

SELECT
    customerNumber,
    checkNumber,
    amount
FROM
    payments
WHERE
    amount = (SELECT MAX(amount) FROM payments);

-- Customers who haven't placed any orders

SELECT
    customerName
FROM
    customers
WHERE   
    customerNumber NOT IN(
        SELECT DISTINCT customerNumber FROM orders
    );

-- Find the minimum, maximum and average number of items in sale orders with subquery

SELECT 
    MAX(items),
    MIN(items),
    FLOOR(AVG(items))
FROM
    (
        SELECT orderNumber,COUNT(orderNumber) AS items FROM orderdetails GROUP BY orderNumber
    ) as lineItems;

-- Select producs whose buy prices are greater than the average buy price of
-- all products in each product line with correlated subquery

SELECT
    productName,
    buyprice
FROM
    products p1
WHERE
    buyprice > (
        SELECT AVG(buyprice) FROM products WHERE productline = p1.productline
    );

-- Find sales orders whose total values are greather than 60K

SELECT 
    orderNumber,
    SUM(priceEach * quantityOrdered) total
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 60000;

SELECT
    customerNumber,
    customerName
FROM
    customers
WHERE
    EXISTS(
        SELECT 
    orderNumber,
    SUM(priceEach * quantityOrdered) total
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 60000
    );

SELECT
    customerNumber,
    customerName
FROM
    customers
WHERE
    EXISTS(
        SELECT 
    orderNumber,
    SUM(priceEach * quantityOrdered) total
    FROM
        orderdetails
            INNER JOIN
        orders USING (orderNumber)
    WHERE
        customerNumber = customers.customerNumber
    GROUP BY orderNumber
    HAVING SUM(priceEach * quantityOrdered) > 60000
    );

-- GET the top 5 products by sales revenue in 2003 from the orders and orderdetails tables

SELECT
    productCode,
    SUM(quantityOrdered * priceEach) sales
FROM 
    orderdetails
        INNER JOIN
    orders USING(orderNumber)
WHERE
    Year(shippedDate) = 2003
GROUP BY productCode
ORDER BY sales DESC
LIMIT 5;

-- Use the result of this query as a derived table and join it with the products TABLE

SELECT
    productName, sales
FROM
    (
        SELECT
            productCode,
            SUM(quantityOrdered * priceEach) sales
        FROM 
            orderdetails
                INNER JOIN
            orders USING(orderNumber)
        WHERE
            Year(shippedDate) = 2003
        GROUP BY productCode
        ORDER BY sales DESC
        LIMIT 5
    ) top5product2003
    INNER JOIN products USING (productCode);

SELECT
    customerNumber,
    ROUND(SUM(quantityOrdered * priceEach)) sales,
    (CASE 
        WHEN SUM(quantityOrdered * priceEach) < 10000 THEN "Silver"
        WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN "Gold"
        WHEN SUM(quantityOrdered * priceEach) > 100000 THEN "Platinum"  
    END) customerGroup
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
WHERE
    YEAR(shippedDate) = 2003
GROUP BY customerNumber;


-- Find the customer who has atleast one order using EXISTS operator

SELECT
    customerNumber
FROM
    orders
WHERE
    EXISTS(
        SELECT 
    )


-- Update the phone's extension of the employees who work at the San Fransico office

SELECT employeeNumber,firstName,lastName,extension
FROM employees
WHERE EXISTS(
    SELECT 1 FROM offices WHERE city = "San Francisco" AND
    offices.officeCode = employees.officeCode
);

UPDATE employees
SET
    extension = CONCAT(extension, "1")
WHERE EXISTS(
    SELECT 1 FROM offices WHERE city = "San Francisco" AND
    offices.officeCode = employees.officeCode
);

CREATE TABLE customer_archive LIKE customers;

INSERT INTO customer_archive
SELECT * FROM customers
WHERE NOT EXISTS(SELECT 1 FROM orders WHERE orders.customerNumber = customers.customerNumber);

