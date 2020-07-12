.echo on
.headers on

-- Name: Steven Fairchild
-- File: lab02b-steven.sql
-- Date: July 9, 2020

-- 1. Who are our customers in North America?
select customerid, companyname, country from customers where country in ('USA', 'Mexico', 'Canada');

-- 2. What orders were placed in April, 1998?
select orderid,orderdate from orders where orderdate like '1998-04%';

-- 3. What sauces do we sell?
select productid,productname from products where productname like '%sauce%';

-- 4. You sell some kind of dried fruit that I liked very much. What is its name?
select productid, productname from products where productname like "%dried%";

-- 5. What employees ship products to Germany in December?
 select orderdate,shipcountry from orders where orderdate like '%-12-%' and shipcountry like 'Germany';
 
-- 6. We have an issue with product 19. I need to know the total amount and the net amount of all orders for product 19 where the customer took a discount.
select employeeid,orderdate,shipcountry from orders where orderdate like '%-12-%' and shipcountry like 'Germany';

-- 7. I need a list of employees by title, First name, and last name, with the employee's position under their names, and a line separating each employee.
select titleofcourtesy || '_' || firstname || '_' || lastname || '
' || title || '
' from employees;

-- 8. I need a list of our customers and the First name only of the customer representative.
select substr( contactname , 1 , pos -1) as firstname , companyname from( select * , instr( contactname , ' ' ) as pos from customers) order by firstname;

-- 9. Give me a list of our customer contacts alphabetically by last name.
select contactname , substr ( contactname , instr( contactname , ' ' ) + 1) || ' , ' || substr ( contactname , 1 , instr( contactname , ' ' ) - 1) as alphaname from customers order by alphaname;

-- 10. I need a report telling me the most common pairing of customers and employees with the greatest order volume (by the number of orders placed). Exclude pairings with minimal orders.
select customerid, employeeid, count(orderid) as volume from orders group by customerid, employeeid having count(orderid) > 3;

-- 11. I need a report listing the highest average selling product by product id. The average is determined by the total sales of each product id divided by the quantity of the product sold. Include only the highest 20 products.
 select productid, count(quantity) as quant, sum(unitprice * quantity) as total, avg((unitprice * quantity) / quantity) as average from order_details group by productid order by average desc limit 20;