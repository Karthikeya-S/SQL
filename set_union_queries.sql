-- UNION and UNION ALL – combine two or more result sets of multiple queries into a single result set.
-- INTERSECT           –  show you a couple of ways to simulate the INTERSECT operator.
-- MINUS               – explain to you the SQL MINUS operator and show you how to simulate it.

/* MySQL UNION operator to combine two or 
more result sets from multiple SELECT statements into a single result set.*/

SELECT column_list
UNION [DISTINCT | ALL]
SELECT column_list
UNION [DISTINCT | ALL]
SELECT column_list
...

-- To combine result set of two or more queries using the UNION operator, these are the basic rules that you must follow:

-- First, the number and the orders of columns that appear in all SELECT statements must be the same.
-- Second, the data types of columns must be the same or compatible.
-- By default, the UNION operator removes duplicate rows even if you don’t specify the DISTINCT operator explicitly.


-- Create 2 tables;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1 (
    id INT PRIMARY KEY
);

CREATE TABLE t2 (
    id INT PRIMARY KEY
);

INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4);


-- combine result sets returned from t1 and t2 tables with UNION 

select * from t1 
UNION 
select * from t2;

+----+
| id |
+----+
|  1 |
|  2 |
|  3 |
|  4 |
+----+
-- combine result sets returned from t1 and t2 tables with UNION ALL

select * from t1 
UNION ALL 
select * from t2;

+----+
| id |
+----+
|  1 |
|  2 |
|  3 |
|  2 |
|  3 |
|  4 |
+----+

-- use customers and employees

-- combine the first name and last name of employees and customers into a single result set

select distinct firstName, lastName
from employees
UNION
select DISTINCT contactFirstName, contactLastName
from customers;
+-----------+-----------+
| firstName | lastName  |
+-----------+-----------+
| Diane     | Murphy    |
| Mary      | Patterson |
| Jeff      | Firrelli  |
| William   | Patterson |
| Gerard    | Bondur    |
| Anthony   | Bow       |
-------------------------
-- combine the first name and last name of employees and customers into a single result set as a full name single column 

select distinct concat(firstName," ",lastName) as fullname
from employees
UNION
select DISTINCT concat(contactFirstName," ",contactLastName) as fullname
from customers;
+-------------------+
| fullname          |
+-------------------+
| Diane Murphy      |
| Mary Patterson    |
| Jeff Firrelli     |
| William Patterson |
| Gerard Bondur     |
| Anthony Bow       |
| Leslie Jennings   |
| Leslie Thompson   |
| Julie Firrelli    |
| Steve Patterson   |
+-------------------+

-- sort the result set of a union by fullname

select concat(firstName," ",lastName) as fullname
from employees
UNION
select concat(contactFirstName," ",contactLastName) as fullname
from customers
order by fullname ASC;
+--------------------+
| fullname           |
+--------------------+
| Adrian Huxley      |
| Akiko Shimamura    |
| Alejandra  Camino  |
| Alexander  Feuer   |
| Alexander  Semenov |
| Allen Nelson       |
| Andy Fixter        |
| Ann  Brown         |
+--------------------+

-- differentiate between employees and customers, you can add a column
;
select concat(firstName," ",lastName) as fullname,
    (CASE 
        WHEN employeeNumber is not null THEN "Employee" 
    END) contactType
from employees
UNION
select concat(contactFirstName," ",contactLastName) as fullname,
    (CASE 
        WHEN CustomerNumber is not null THEN "Customer" 
    END) contactType
from customers
order by fullname;
+--------------------------+-------------+
| fullname                 | contactType |
+--------------------------+-------------+
| Adrian Huxley            | Customer    |
| Akiko Shimamura          | Customer    |
| Alejandra  Camino        | Customer    |
| Alexander  Feuer         | Customer    |
| Alexander  Semenov       | Customer    |
| Allen Nelson             | Customer    |
| Andy Fixter              | Employee    |
------------------------------------------


