create view view_table AS
SELECT c.customerNumber, c.customerName, p.paymentDate, p.amount FROM customers c
INNER JOIN payments p on c.customerNumber = p.customerNumber;
CREATE view view_table1 AS
SELECT customerNumber, customerName, paymentDate, amount from customers
inner JOIN payments USING(customerNumber);
select * from view_table1
ORDER BY customerNumber;
select DATABASE();