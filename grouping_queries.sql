-- GROUP BY

SELECT
    status
FROM
    orders
GROUP BY
    status;

SELECT
    COUNT(*)
FROM
    orders
GROUP BY
    status;

SELECT
    status,
    quantityOrdered,
    priceEach,
    SUM(quantityOrdered * priceEach) AS amount
FROM
    orders
    INNER JOIN orderdetails USING (orderNumber)
GROUP BY
    status;

SELECT 
    YEAR(orderDate) AS Year,
    SUM(quantityOrdered * priceEach) AS Total
FROM
    orders
    INNER JOIN orderDetails USING (orderNumber)
WHERE
    status = "Shipped"
GROUP BY
    YEAR(orderDate);

SELECT
    year(orderDate) as YEAR,
    COUNT(orderNumber) AS Total
FROM
    orders
GROUP BY
    YEAR;

SELECT status, COUNT(status) as Total
FROM orders
GROUP BY status
ORDER BY status;

-- HAVING
-- HAVING clause is used in SELECT statement to specify filter condition for a group of rows
SELECT 
    YEAR(orderDate) AS Year,
    SUM(quantityOrdered * priceEach) AS Total
FROM
    orders
    INNER JOIN orderDetails USING (orderNumber)
WHERE
    status = "Shipped"
GROUP BY
    YEAR(orderDate)
HAVING
    year > 2003;

SELECT
    orderNumber,
    SUM(quantityOrdered),
    SUM(priceEach*quantityOrdered) AS total
FROM
    orderDetails
GROUP BY
    orderNumber
HAVING
    total > 1000;

SELECT
    orderNumber,
    SUM(quantityOrdered),
    SUM(priceEach*quantityOrdered) AS total
FROM
    orderDetails
GROUP BY
    orderNumber
HAVING
    total > 1000
    AND
    itemsCount > 600;
-- ROLLUP

SELECT
    productline,
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY
    productline WITH ROLLUP;

SELECT
    orderYear,
    productline,
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY
    orderYear,
    productline
WITH ROLLUP;

-- IF operator

SELECT
    IF(GROUPING(orderYear), "All Years", orderYear) orderYear,
    IF(GROUPING(productline),"All Productline", productline) Productline,
    SUM(orderValue) totalOrderValue
FROM
    sales 
GROUP BY
    orderYear,
    productline WITH ROLLUP;