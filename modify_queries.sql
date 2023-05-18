CREATE TABLE if not exists tasks (
    task_id INT AUTO_INCREMENT,
    title VARCHAR(255) not null,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (project_id)
);

CREATE TABLE if not exists projects (
    project_id INT AUTO_INCREMENT,
    title VARCHAR(255) not null,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (project_id)
);

INSERT INTO projects(title,start_date,end_date) values("AI for Marketing","2023-05-16","2023-05-21");

CREATE TABLE devices(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO devices(name)
VALUES("ROUTER F1"),("SWITCH 1"),("MODEM 1");

INSERT INTO devices(id,name)
VALUES(4,"PRINTER")
ON DUPLICATE KEY UPDATE name = "My printer";

CREATE TABLE subscribers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(200) NOT NULL UNIQUE
);

INSERT INTO subscribers(email)
VALUES("skarthi2105@gmail.com");

INSERT IGNORE INTO subscribers(email)
VALUES("skarthi2105@gmail.com");

SELECT firstName, lastName, email from employees where employeeNumber = 1056;

-- UPDATE

SELECT DISTINCT email FROM employees;

SELECT DISTINCT jobTitle FROM employees;
UPDATE employees
SET email = "mary@gmail.com"
where employeeNumber = 1056;

UPDATE employees SET
email = REPLACE(email,'classicmodelcars','wileyedge');

SELECT email from employees where employeeNumber = 1056;



CREATE DATABASE IF NOT EXISTS empdb;

USE empdb;

CREATE TABLE merits (
    performance INT(11) NOT NULL,
    percentage FLOAT NOT NULL,
    PRIMARY KEY (performance)
);

CREATE TABLE employees (
    emp_id INT(11) NOT NULL AUTO_INCREMENT,
    emp_name VARCHAR(255) NOT NULL,
    performance INT(11) DEFAULT NULL,
    salary FLOAT DEFAULT NULL,
    PRIMARY KEY (emp_id),
    CONSTRAINT fk_performance FOREIGN KEY (performance)
        REFERENCES merits (performance)
);
INSERT INTO merits(performance,percentage)
VALUES(1,0),(2,0.01),(3,0.03),(4,0.04),(5,0.1);

INSERT INTO employees(emp_name,performance,salary)
VALUES('Karthik',1,10000),
      ('Selva',2,20000),
      ('Asjad',3,30000),
      ('Sano',4,50000),
      ('Shyam',5,60000);

-- Adjust the salary of employees based on their performance

UPDATE employees
    INNER JOIN
        merits on employees.performance = merits.performance
SET
    salary = salary + (salary * percentage);

