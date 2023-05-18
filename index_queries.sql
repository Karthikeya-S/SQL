-- MySQL uses indexes to quickly find rows with specific column values. 
    -- Without an index, MySQL must scan the whole table to locate the relevant rows. 
    -- The larger table, the slower it searches.

-- Important features of indexes in MySQL
Creating indexes        – introduces you to the index concept and shows you how to create an index for one or more columns of a table.
Removing indexes        – shows you how to remove an existing index of a table.
Listing table indexes   – provides you with a statement to list all indexes or specific indexes of a table.
Unique indexes          – uses the unique indexes to ensure distinct values stored in a column.
Prefix indexes          – shows you how to use the prefix index to create an index for a character string column.
Invisible indexes       – covers the index visibility and shows you how to make an index visible or invisible.
Descending indexes      –  shows you how to use descending indexes to increase query performance.
Composite indexes       – illustrates the application of composite indexes and shows you when to use them to speed up your queries.
Clustered indexes       – explains the clustered indexes in InnoDB tables.
Index cardinality       – explains the index cardinality and shows you how to view it using the show indexes command.
USE INDEX hint          –  shows you how to use the USE INDEX hint to instruct the query optimizer to use the only list of specified indexes to find rows in a table.
FORCE INDEX hint        – shows you how to use the FORCE INDEX hint to force the query optimizer to use specified indexes to select data from a table.
;
---------------------------------------------------------------

CREATE TABLE t(
   c1 INT PRIMARY KEY,
   c2 INT NOT NULL,
   c3 INT NOT NULL,
   c4 VARCHAR(10),
   INDEX (c2,c3) 
);

-- CREATE INDEX index_name on table_name(column_list);
-- CREATE indx_c4 on t(c4);

-- By DEFAULT, mysql creates the B-Tree index if we don't specify the index type
/*
    Storage Engine      Allowed Index Types
    InnoDB                  B-TREE
    MyISAM                  B-TREE
    MEMORY/HEAP             HASH,B-TREE
*/

SELECT
    employeeNumber,
    lastName,
    firstName
FROM
    employees
WHERE
    jobTitle = 'Sales Rep';

EXPLAIN FORMAT=JSON SELECT
    employeeNumber,
    lastName,
    firstName
FROM
    employees
WHERE
    jobTitle = 'Sales Rep';
SET @explain_format='TREE';
SELECT @explain_format;
CREATE INDEX idxjobTitle on employees(jobTitle);
SHOW INDEXES from employees;
-- Drop index:
DROP INDEX index_name on TABLE_NAME;
CREATE TABLE leads(
    lead_id INT AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    information_source VARCHAR(255),
    INDEX name(first_name,last_name),
    UNIQUE email(email),
    PRIMARY KEY(lead_id)
);

CREATE TABLE contacts(
    contact_id INT AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    PRIMARY KEY(contact_id),
    UNIQUE(email),
    INDEX phone(phone) INVISIBLE,
    INDEX name(first_name, last_name) comment 'By first name and/or last name'
);

CREATE TABLE table_name(
    column_list,
    INDEX(column_name(length))
);

CREATE TABLE IF NOT EXISTS contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    UNIQUE KEY unique_email (email)
);


CREATE TABLE table_name (
    c1 data_type PRIMARY KEY,
    c2 data_type,
    c3 data_type,
    c4 data_type,
    INDEX index_name (c2,c3,c4)
);


CREATE TABLE t(
    a INT NOT NULL,
    b INT NOT NULL,
    INDEX a_asc_b_desc (a ASC, b DESC)
);


DROP TABLE t;

CREATE TABLE t (
    a INT,
    b INT,
    INDEX a_asc_b_asc (a ASC , b ASC),
    INDEX a_asc_b_desc (a ASC , b DESC),
    INDEX a_desc_b_asc (a DESC , b ASC),
    INDEX a_desc_b_desc (a DESC , b DESC)
);


