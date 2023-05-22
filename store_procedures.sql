DELIMITER $$
CALL GetCustomers();
CREATE PROCEDURE getAllProducts()
BEGIN
    SELECT * FROM products;
END 
DELIMITER ;

CALL getAllProducts();

-- CREATE Procedure procedure_name(parameters_list)
-- BEGIN  
--     statements;
-- END //

-- DELIMITER $$
-- USE 'wileyclassic' $$
-- create procedure 'GetAllCustomers' ()
-- BEGIN
--     SELECT * FROM customers;
-- END
-- ;

DELIMITER $$
CREATE PROCEDURE GetOrderCountByStatus(
    IN orderstatus VARCHAR(25),
    OUT total INT
)
BEGIN
    SELECT COUNT(orderNumber)
    INTO total
    FROM orders
    WHERE status = orderStatus;
END 
DELIMITER;

CALL GetOrderCountByStatus('in process',@total);
SELECT @total as total_in_process;
-----------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
) 
BEGIN
    SET counter = counter + inc;
END 
DELIMITER ;

SET @counter = 1;
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 7);
SELECT @counter;

DECLARE totalSales DEC(10,2) DEFAULT 0.0;
DECLARE a,b INT DEFAULT 0;

-- Assign values to the variables

SET variable_name = value;

DELIMITER $$
CREATE PROCEDURE GetTotalOrder()
BEGIN
    DECLARE totalOrder INT DEFAULT 0;
    SELECT COUNT(*)
    INTO totalOrder
    FROM orders;

    SELECT totalOrder;
END
DELIMITER;
CALL GetTotalOrder();

----------------------------------
SHOW PROCEDURE status;
SHOW PROCEDURE status where db = 'wileyclassic';

drop procedure GetTotalOrder;

SELECT
    routine_name
FROM
    information_schema.routines
WHERE
    routine_type = 'PROCEDURE'
    AND
    routine_schema = 'wileyclassic';

-- DECLARE ACTION HANDLER FOR condition_value STATEMENT;
-- CONTINUE OR EXIT;

CREATE TABLE supplierProducts(
    supplierId INT,
    productId INT,
    PRIMARY KEY (supplierId,productId)
);
DELIMITER $$
CREATE PROCEDURE InsertSupplierProduct(
    IN inSupplierId INT,
    IN inProductID INT    
)
BEGIN
    -- exit if duplicate key occurs
    DECLARE EXIT HANDLER FOR 1062 SELECT CONCAT('Duplicate Key (', inSupplierId,',', inProductID,') Occured') AS message;



    -- insert new row into the supplierProducts
    INSERT INTO supplierProducts(supplierId,productId)
    VALUES(inSupplierId, inProductId);
    -- return the product supplied by the supplier id
    SELECT COUNT(*)
    FROM supplierProducts
    WHERE supplierId = inSupplierId;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION CustomerLevel(
    credit DECIMAL(10,2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE CustomerLevel VARCHAR(20);

    IF credit > 50000 THEN
        SET CustomerLevel = 'PLATINUM';
    ELSEIF (credit <= 50000 AND credit >= 10000) THEN
        SET CustomerLevel = 'GOLD';
    ELSEIF (credit < 10000) THEN   
        SET CustomerLevel = 'SILVER';
    END IF;
    RETURN (CustomerLevel);
END 
DELIMITER ;

SHOW FUNCTION STATUS WHERE db = 'wileyclassic';

SELECT
    customerName,creditLimit,
    customerLevel(creditLimit)
FROM 
    customers
ORDER BY
    customerName;
SELECT DATABASE();
select customerName, employeeNumber FROM
customers, employees;