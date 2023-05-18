-- Introduction to MySQL aggregate functions
-- An aggregate function performs a calculation on multiple values and returns a single value.

-- For example, you can use the AVG() aggregate function that takes multiple numbers and returns the average value of the numbers.

-- Syntax of an aggregate function:

    function_name(DISTINCT | ALL expression)

-- Approach to work with aggregate functions:- 
-- First, specify the name of the aggregate function e.g., AVG(). See the list of aggregate functions in the following section.
-- Second, use DISTINCT if you want to calculate based on distinct values or ALL in case you want to calculate all values including duplicates. The default is ALL.
-- Third, specify an expression that can be a column or expression which involves column and arithmetic operators.

-- The aggregate functions are often used with the GROUP BY clause to calculate an aggregate value for each group e.g., the average value by the group or the sum of values in each group.

-- Refer the picture The following picture(sum_aggregate.png) the SUM() aggregate function is used in conjunction with a GROUP BY clause:

-- Refer aggregate_functions.png to find the list of aggregate functions 

Aggregate function	Description
AVG()			    Return the average of non-NULL values.
BIT_AND()		    Return bitwise AND.
BIT_OR()		    Return bitwise OR.
BIT_XOR()		    Return bitwise XOR.
COUNT()			    Return the number of rows in a group, including rows with NULL values.
GROUP_CONCAT()		Return a concatenated string.
JSON_ARRAYAGG()		Return result set as a single JSON array.
JSON_OBJECTAGG()	Return result set as a single JSON object.
MAX()			    Return the highest value (maximum) in a set of non-NULL values.
MIN()			    Return the lowest value (minimum) in a set of non-NULL values.
STDEV()			    Return the population standard deviation.
STDDEV_POP()		Return the population standard deviation.
STDDEV_SAMP()		Return the sample standard deviation.
SUM()			    Return the summation of all non-NULL values a set.
VAR_POP()		    Return the population standard variance.
VARP_SAM()		    Return the sample variance.
VARIANCE()		    Return the population standard variance.

-----------------------------------------

Use products and orderdetails tables: 

-- MySQL aggregate function – AVG()
The AVG() function calculates the average value of a set of values. It ignores NULL in the calculation.

-- Usecases:-
-- calculate the average buy price of all products in the products
SELECT AVG(buyPrice) as average_buy_price
FROM products;
+-------------------+
| average_buy_price |
+-------------------+
|         54.395182 |
+-------------------+

-- calculate the average buy price for each product line:
select productLine, AVG(buyPrice)
from products
GROUP BY productLine;
+------------------+---------------+
| productLine      | AVG(buyPrice) |
+------------------+---------------+
| Classic Cars     |     64.446316 |
| Motorcycles      |     50.685385 |
| Planes           |     49.629167 |
| Ships            |     47.007778 |
| Trains           |     43.923333 |
| Trucks and Buses |     56.329091 |
| Vintage Cars     |     46.066250 |
+------------------+---------------+


-----------------------------------------
-- MySQL aggregate function – COUNT()
The COUNT() function returns the number of the value in a set.

-- Usecases:-
-- Get the number of products in the products table as total
SELECT COUNT(*) as total
FROM products;
+-------+
| total |
+-------+
|   110 |
+-------+

-- Use the COUNT() function with the GROUP BY clause to get the number of products for each product line order by product line
SELECT productLine, COUNT(*)
FROM products
GROUP BY productLine;
+------------------+----------+
| productLine      | COUNT(*) |
+------------------+----------+
| Classic Cars     |       38 |
| Motorcycles      |       13 |
| Planes           |       12 |
| Ships            |        9 |
| Trains           |        3 |
| Trucks and Buses |       11 |
| Vintage Cars     |       24 |
+------------------+----------+

-----------------------------------------
-- MySQL aggregate function – SUM()
The SUM() function returns the sum of values in a set. The SUM() function ignores NULL. If no matching row found, the SUM() function returns NULL.

-- Usecases:-
-- Get the total order value of each product, you can use the SUM() function in conjunction with the GROUP BY clause
SELECT productCode, SUM(quantityOrdered * priceEach) as total
FROM orderdetails
GROUP BY productCode
ORDER BY total DESC LIMIT 5;
+-------------+-----------+
| productCode | total     |
+-------------+-----------+
| S18_3232    | 276839.98 |
| S12_1108    | 190755.86 |
| S10_1949    | 190017.96 |
| S10_4698    | 170686.00 |
| S12_1099    | 161531.48 |
+-------------+-----------+

-- Get more detail using join the orderdetails table to the products
SELECT o.productCode, p.productName, SUM(quantityOrdered * priceEach) as total
FROM orderdetails o
    INNER JOIN
products p ON o.productCode = p.productCode
GROUP BY productCode
ORDER BY total;

+-------------+-------------------------------------+----------+
| productCode | productName                         | total    |
+-------------+-------------------------------------+----------+
| S24_1937    | 1939 Chevrolet Deluxe Coupe         | 28052.94 |
| S24_3969    | 1936 Mercedes Benz 500k Roadster    | 29763.39 |
| S24_2972    | 1982 Lamborghini Diablo             | 30972.87 |
| S24_2840    | 1958 Chevy Corvette Limited Edition | 31627.96 |
| S32_2206    | 1982 Ducati 996 R                   | 33268.76 |
+-------------+-------------------------------------+----------+
-----------------------------------------
-- MySQL aggregate function – MAX()
The MAX() function returns the maximum value in a set. 
-- MAX(expression)

-- Usecases:-
-- Use the MAX() function to get the highest buy price from the products table
SELECT MAX(buyPrice) as highest_price
FROM products;
+---------------+
| highest_price |
+---------------+
|        103.42 |
+---------------+

-- Use the MAX() function with the GROUP BY clause to get the highest price per product line
SELECT productLine, MAX(buyPrice)
FROM products
GROUP BY productLine;
+------------------+---------------+
| productLine      | MAX(buyPrice) |
+------------------+---------------+
| Classic Cars     |        103.42 |
| Motorcycles      |         91.02 |
| Vintage Cars     |         86.70 |
| Trucks and Buses |         84.76 |
| Ships            |         82.34 |
| Planes           |         77.27 |
| Trains           |         67.56 |
+------------------+---------------+


---------------------------------------------
-- MySQL aggregate function – MIN()
The MIN() function returns the minimum value in a set of values.
-- MIN(expression)

-- Usecases:-
-- Use the MIN() function to find the lowest price from the products table
SELECT MIN(buyPrice) lowest_price
FROM products;
+--------------+
| lowest_price |
+--------------+
|        15.91 |
+--------------+

-- Use the MIN() function with the GROUP BY clause to get the lowest price per product line
SELECT productLine, MIN(buyPrice)
FROM products
GROUP BY productLine;
+------------------+---------------+
| productLine      | MIN(buyPrice) |
+------------------+---------------+
| Classic Cars     |         15.91 |
| Vintage Cars     |         20.61 |
| Motorcycles      |         24.14 |
| Trucks and Buses |         24.92 |
| Trains           |         26.72 |
| Planes           |         29.34 |
| Ships            |         33.30 |
+------------------+---------------+

---------------------------------------------
-- MySQL aggregate function – GROUP_CONCAT() 
The GROUP_CONCAT() concatenates a set of strings and returns the concatenated string

-- ***USE employees and customers tables

-- Usecases:-

-- use the GROUP_CONCAT() function to return the sales staffs and list of customers that each sales staff is in charge of:
SELECT firstName, lastName, GROUP_CONCAT(DISTINCT customerName ORDER BY customerName) as customers
FROM customers
    INNER JOIN
employees on customers.SalesRepEmployeeNumber = employees.employeeNumber
GROUP BY employeeNumber
ORDER BY firstName, lastName;
-- +-----------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- | firstName | lastName | customers                                                                                                                                                                                                          |
-- +-----------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- | Andy      | Fixter   | Anna's Decorations, Ltd,Australian Collectables, Ltd,Australian Collectors, Co.,Australian Gift Network, Co,Souveniers And Things Co.                                                                              |
-- | Barry     | Jones    | Baane Mini Imports,Bavarian Collectables Imports, Co.,Blauer See Auto, Co.,Clover Collections, Co.,Herkku Gifts,Norway Gifts By Mail, Co.,Scandinavian Gift Ideas,Toms Spezialitäten, Ltd,Volvo Model Replicas, Co |
-- +-----------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- 2 rows in set (0.03 sec)
;
-- Calculate the average buy prices of average buy prices of product lines;
SELECT AVG(pl_avg) 'Average Product'
FROM(
    SELECT
    AVG(buyPrice) pl_avg
    FROM products GROUP BY productLine
) avgs;

-- Return the customers and their orders

SELECT customerNumber, GROUP_CONCAT(orderNumber) "Their Orders"
from orders
GROUP BY customerNumber
ORDER BY "Their Orders";

WITH cte AS(
    SELECT c.customerName,
    COUNT(o.customerNumber) AS order_count
    FROM
        customers c
    LEFT JOIN orders o ON c.customerNumber = o.customerNumber
    GROUP BY c.customerNumber,c.customerName

)
SELECT
    customerName,
    order_count,
    CASE order_count
        WHEN 0 THEN 'New Customer' 
        WHEN 1 THEN 'One-time Customer' 
        WHEN 2 THEN 'Repeated Customer' 
        WHEN 3 THEN 'Frequent Customer' 
        ELSE  'Loyal Customer'
    END customerType
FROM cte
ORDER BY customerName;

-- Sort the customer by states if state is no NULL
-- Or sort the country if the state is NULL

select customerNumber, customerName, state, country
FROM customers
ORDER BY (CASE 
    WHEN state is NULL THEN country
    ELSE  state
END)
LIMIT 5;

-- SUM to calculate total sales orders by order status

SELECT 
    SUM(
        CASE 
            WHEN status = 'Shipped' THEN  1
            ELSE  0
        END
    ) AS 'Shipped',
    SUM(
        CASE 
            WHEN status = 'On Hold' THEN  1
            ELSE  0
        END
    ) 'On Hold',
    COUNT(*) AS total
FROM   
    orders;

SELECT IF(1=2, 'TRUE', 'FALSE');
SELECT ELSE(1=2,'FALSE','TRUE');

SELECT customerNumber, customerName, 
        IF( state is NULL, 'na', state) state, country
FROM 
    customers;

SELECT contactName, IFNULL(mobile,home_phone) phone
FROM emp_contact_info;