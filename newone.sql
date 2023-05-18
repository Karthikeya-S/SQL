CREATE DATABASE IF NOT EXISTS hr;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100)
);
CREATE TABLE employees (
    id int AUTO_INCREMENT primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    department_id int not null,
    FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
);
INSERT INTO departments(dept_name)
VALUES('Sales'),('Markting'),('Finance'),('Accounting'),('Warehouses'),('Production');
INSERT INTO employees(first_name,last_name,department_id) 
VALUES('John','Doe',1),
		('Bush','Lily',2),
		('David','Dave',3),
		('Mary','Jane',4),
		('Jonatha','Josh',5),
		('Mateo','More',1);
CREATE VIEW v_employee_info AS
    SELECT
        id,first_name,last_name, dept_name
    FROM
        employees
            INNER JOIN
        departments USING (department_id);
RENAME TABLE employees TO people;
RENAME table departments to depts;
delete from depts where department_id is 1;
RENAME TABLE
    depts TO departments,
    people TO employees;
Syntax:
ALTER TABLE old_table_name to new_table_name;
create TEMPORARY TABLE lastNames
select DISTINCT last_name FROM employees;
RENAME table lastNames to unique_lastNames;
ALTER table lastNames RENAME to unique_lastNames;
-- ADD columns
ALTER TABLE table_name
    ADD COLUMN,
    ADD COLUMN,
    ADD COLUMN;
-- If a column already exists
SELECT
    IF (count(*) = 1, 'EXIST', 'NOT EXIST') AS result
FROM
    information_schema.columns
WHERE
    table_schema = "database_name" -- db name
    AND table_name = "table_name" -- table anem
    AND column_name = "location" --column name
;
DROP COLUMNS
DROP TABLE tablename;
-- MULTIPLE TABLES
DROP TABLE table_name,table1,table2;
DROP TABLE LIKE '%pattern%';
CREATE TABLE test1();
CREATE TABLE if not exists test2 like test1

SET @schema = 'database_name'
SET @pattern = 'test%'

dbname.tablename

SELECT CONCAT('DROP TABLE', GROUP_CONCAT(CONCAT(@schema,'.'table_name)),';')
INTO @dropLike
from information_schema.tables
where @schema = database()
and table_name like @pattern;
SELECT @dropLike;
DROP Table empdb.test1, empdb.test2, empdb.test3;
CREATE Table if not exists contacts(
    id int AUTO_INCREMENT primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    full_name VARCHAR(100) GENERATED ALWAYS AS (CONCAT(first_name," ",last_name))    
);
ALTER TABLE contacts
    ADD COLUMN fuller_name VARCHAR(100)
    GENERATED ALWAYS AS (CONCAT(first_name,' ',last_name));