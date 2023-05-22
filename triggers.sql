CREATE TABLE emplooyees_audit(
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedate DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);
-- CREATE TRIGGER before_employee_update
--     BEFORE UPDATE ON employees
--     FOR EACH ROW
-- INSERT INTO employees_audit
-- SET action = 'update',
--     employeeNumber = OLD.employeeNumber,
--     lastname = OLD.lastname,
--     changedate = NOW();
-- SHOW TRIGGERS;
SELECT firstName, lastName from employees where employeeNumber = 1056;
UPDATE employees SET lastName = "Karthi" where employeeNumber = 1056;
SHOW TRIGGERS;
-- DROP TRIGGER IF EXISTS database_name.trigger_name;

CREATE TABLE members(
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    
    date_of_birth DATE NOT NULL
);
INSERT INTO members(name,email,date_of_birth)
    VALUES("Karthikeya","karthikeya@gmail.com","2001-05-21");
INSERT INTO members(name,email,date_of_birth)
    VALUES("Selva","karthik@gmail.com","2001-10-09");
INSERT INTO members(name,email,date_of_birth)
    VALUES("Asjad","asjad100@gmail.com","2001-12-26");
select * from members;
-- REMINDER TABLE members
DELIMITER $$
CREATE TRIGGER after_members_insert
AFTER INSERT
ON members FOR EACH ROW
BEGIN
    IF NEW.date_of_birth IS NULL THEN
        INSERT INTO reminders(member_id, message)
        VALUES(NEW.member_id, CONCAT('Hi',NEW.name,',please update your dob'));
    END IF;
END
DELIMITER;

SHOW TRIGGERS;

CREATE TABLE customer_bank(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone BIGINT,
    emi_amount INT DEFAULT 10000
);
DESCRIBE customer_bank;

INSERT INTO customer_bank(name,email,phone)
VALUES('Karthikeya','karthi@gmail.com',12345);
INSERT INTO customer_bank(name,email,phone)
VALUES('Selva','karthiq@gmail.com',67890);
INSERT INTO customer_bank(name,email,phone)
VALUES('Asjad','assjad@gmail.com',11225);
DELETE FROM customer_bank;
DELIMITER $$
CREATE TRIGGER before_ad_payment