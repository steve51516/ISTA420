-- Name: Steven Fairchild
-- File: EX04-steven.sql
-- Date: July 25, 2020

USE TSQLV4;

-- 1. Use a derived table to build a query that returns the number of distinct products per year that each
--customer ordered. Use internal aliasing. Use a variable to set the customer number. For example, if
--the customer ID is 1234, the query should report the number of distinct products ordered by customer
--1234 for the years 2014, 2015, and 2016.

select c.custnum, c.orderid, c.orderdate from (select distinct custid as custnum, orderid, orderdate from sales.orders) as c 
group by c.custnum, c.orderid, c.orderdate order by c.custnum;

-- 2. Use multiple common table expressions to build a query that returns the number of distinct products
--per year that each country's customers ordered. Use external aliasing. Use a variable to set the country
--name. For example, if the country name is France, the query should report the number of distinct
--products ordered by French customers for the years 2014, 2015, and 2016.

DECLARE @country varchar(30);
set @country = 'usa';

with totalProducts as
(
select distinct c.country, od.productid, count(od.productid) as totalCount, o.orderdate 
from sales.OrderDetails od, 
(select c.country, c.custid from sales.customers c where c.country like @country) c, 
(select o.orderdate from Sales.Orders o where o.orderdate between '2014-01-01' and '2016-12-31') o
group by c.country, od.productid, o.orderdate
)
select distinct * from totalProducts order by orderdate;

-- 3. Create a view that shows, for each year, the total dollar amount spent by customers in each country
-- for all the years in the database.

DROP VIEW IF EXISTS Sales.CountrySUM;
GO
CREATE VIEW Sales.CountrySUM
AS with OD as ( select o2.productid, o2.orderid, o.shipcountry, o2.qty, o2.unitprice, year(orderdate) as orderyear, O.custid, 
(select sum(O1.unitprice * O1.qty) from sales.OrderDetails as O1 where O1.orderid = O2.orderid and o1.productid = o2.productid) as totprice 
from sales.orderdetails as O2 inner join sales.orders as O on o2.orderid = o.orderid ) 
SELECT  orderyear,  Od.shipcountry, sum(OD.totprice) as totspending FROM OD group by orderyear,  Od.shipcountry; 
GO

select * from Sales.CountrySUM;

-- 5. Use the CROSS APPLY operator to create a query showing the top three products shipped to customers
-- in each country. Your report should contain the name of the country, the product id, the product name,
-- and the number of products shipped to customers in that country.

select o.shipcountry, od.qty, od.productid, p.productname
from Sales.Orders o
cross apply
(select top (3) od.productid, od.qty from sales.OrderDetails od where od.orderid = o.orderid order by od.qty desc) as od,
(select p.productname, p.productid from Production.Products p) as p where od.productid = p.productid
order by o.shipcountry

SELECT C.custid, A.orderid, A.orderdate
FROM Sales.Customers AS C
CROSS APPLY
(SELECT TOP (3) orderid, empid, orderdate, requireddate
FROM Sales.Orders AS O
WHERE O.custid = C.custid
ORDER BY orderdate DESC, orderid DESC) AS A;