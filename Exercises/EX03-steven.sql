.echo on
.headers on

-- Name: Steven Fairchild
-- File: EX03-steven.sql
-- Date: July 17, 2020

-- 1. Using SQLite and the Northwind database, create a line item report that contains a line for each product in the order with the following columns: the order id, the product id, the unit price, the quantity sold, the line item price, and the percent of that line item constitutes of the total amount of the order.

select orderid, productid, unitprice, (unitprice * quantity) as line_total, ((unitprice*quantity)/(sum(unitprice*quantity)))*100 as PctOfTotalOrder from order_details group by orderid limit 25;

-- 2. I want to know the unique (distinct) cities, regions, and postal codes: (a) where we have both customers and employees, (b) where we have customers but no employees AND both customers ad employees, and (c) where we have employees but no customers AND both customers and employees. Write three queries, using inner and outer joins. Report the results of the queries. There is no need for any further reporting.

-- (a) where we have both customers and employees
select c.postalcode, e.postalcode, e.city, e.region, e.country, c.companyname, c.city, c.region, c.country from customers c inner join employees e on e.city = c.city;

-- (b) where we have customers but no employees AND both customers and employees
select c.postalcode, e.postalcode, e.city, e.region, e.country, c.companyname, c.city, c.region, c.country from customers c left join employees e on e.city = c.city;

-- (c) where we have employees but no customers AND both customers and employees.
select e.city, e.region, e.country, c.companyname, c.city, c.region, c.country from employees e left join customers c on e.city = c.city;