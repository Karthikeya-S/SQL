SELECT
    firstName,
    lastName,
    jobTitle
FROM   
    employees
WHERE
    jobTitle = "Sales Rep" AND
    officeCode = 1
ORDER BY 
    officeCode, jobTitle;

--Between

SELECT
    firstName,
    lastName,
    jobTitle
FROM   
    employees
WHERE
    officeCode BETWEEN 1
    AND 3
ORDER BY 
    officeCode;

--LIKE OPERATOR

SELECT
    firstName,
    lastName
FROM   
    employees
WHERE
    lastName LIKE "%son"
ORDER BY 
    firstName;

-- NULL operator

SELECT
    firstName,
    lastName,
    reportsTo
FROM
    employees
WHERE
    reportsTo IS NULL;

-- NOT NULL operator

SELECT
    firstName,
    lastName,
    reportsTo
FROM
    employees
WHERE
    reportsTo IS NOT NULL;

-- <> NOT operator

SELECT
    firstName,
    lastName
FROM
    employees
WHERE
    jobTitle <> "Sales Rep";

-- DISTINCT OPERATOR

SELECT DISTINCT
    state
FROM   
    customers;

SELECT DISTINCT
    state,city
FROM   
    customers
WHERE
    state is NOT NULL
ORDER BY
    city;

SELECT 
    name, 
    country, 
    state
FROM
    customers
WHERE
    country = "USA"
    AND state = "CA"
    AND creditlimit > 100000;