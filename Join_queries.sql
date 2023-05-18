-- JOIN
-- RIGHT JOIN
-- LEFT JOIN
-- CROSS JOIN
-- SELF JOIN

SELECT
    a.orderNumber,
    status,
    SUM(priceEach*quantityOrdered) AS total
FROM
    orderDetails a
    INNER JOIN orders b ON b.orderNumber = a.orderNumber
GROUP BY
    orderNumber,
    status
HAVING
    status = "Shipped"
    AND total > 1500 LIMIT 20;

create table sales
SELECT
    productline,
    YEAR(orderDate) orderYear,
    SUM(priceEach*quantityOrdered) AS OrderValue
FROM
    orderDetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    products USING (productCode)
GROUP BY
    productline,
    orderYear;

SELECT
    productline,
    SUM(orderValue)
FROM
    sales
GROUP BY
    productline;

-- Total orderValue in whole TABLE

SELECT
    SUM(orderValue) totalOrderValue
FROM
    sales;

-- UNION Operator

SELECT
    productline,
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY
    productline
UNION ALL
SELECT 
    NULL,
    SUM(orderValue) totalOrderValue
FROM
    sales;
