-- Name: Steven Fairchild
-- File: EX06-steven.sql
-- Date: August 5, 2020

USE TSQLV4;

DROP TABLE IF EXISTS CC.ProductLines;
DROP TABLE IF EXISTS CC.Products;
DROP TABLE IF EXISTS CC.OrderDetails;
DROP TABLE IF EXISTS CC.Orders;
DROP TABLE IF EXISTS CC.Customers;
DROP TABLE IF EXISTS CC.Employees;
DROP TABLE IF EXISTS CC.Offices;
DROP TABLE IF EXISTS CC.Payments;


DROP SCHEMA IF EXISTS CC;

GO
CREATE SCHEMA CC;
GO

CREATE TABLE CC.ProductLines(
productLine varchar(50) PRIMARY KEY,
textDescription varchar(MAX),
htmlDescription varchar(250),
imagepath varchar(MAX)
);

--CREATE TABLE CC.Products(
--productCode varchar(50) PRIMARY KEY,
--productName varchar(50),
--productLine varchar(50),
--productScale varchar(50),
--productVender varchar(50),
--productDescription varchar(MAX),
--quantityInStock varchar(50),
--buyPrice varchar(50),
--MSRP varchar(MAX)
--);


CREATE TABLE CC.Products
(
productCode varchar(500) not null
	constraint ClassicCars_Products primary key,
productName varchar(MAX),
productLine varchar(MAX),
productScale varchar(MAX),
productVendor varchar(MAX),
productDescription varchar(MAX),
quantityInStock varchar(MAX),
buyPrice varchar(MAX),
MSRP varchar(MAX)
);
GO

CREATE TABLE CC.OrderDetails(
orderNumber varchar(50),
productCode varchar(50),
quantityOrdered varchar(50),
priceEach money,
orderLineNumber varchar(MAX)
);

CREATE TABLE CC.Orders(
orderNumber varchar(50) PRIMARY KEY,
orderDate varchar(50),
requiredDate varchar(50),
shippedDate varchar(50),
orderStatus varchar(250),
comments varchar(MAX),
customerNumber varchar(MAX)
);

CREATE TABLE CC.Customers(
customerNumer varchar(50) PRIMARY KEY,
customerName varchar(50),
contactLastName varchar(50),
contactFirstName varchar(50),
phone varchar(50),
addressLine1 varchar(50),
addressLine2 varchar(50),
city varchar(50),
customerState varchar(50),
postalCode varchar(50),
country varchar(50),
salesRepEmployeeNumber varchar(50),
creditLimit varchar(MAX)
);

CREATE TABLE CC.Employees(
employeeNumber varchar(50) PRIMARY KEY,
lastName varchar(50),
firstName varchar(50),
extension varchar(50),
email varchar(50),
officeCode varchar(50),
reportsTo varchar(50),
jobTitle varchar(50)
);

CREATE TABLE CC.Offices (
officeCode varchar(50) PRIMARY KEY,
city varchar(50),
phone varchar(50),
addressLine1 varchar(50),
addressLine2 varchar(50),
state varchar(50),
country varchar(50),
postalCode varchar(50),
territory varchar(50)
);

CREATE TABLE CC.Payments(
customerNumber varchar(50),
checkNumber varchar(50),
paymentDate varchar(50),
amount varchar(50),
CONSTRAINT PK_Reservation_2 PRIMARY KEY (customerNumber, checkNumber)
);

select * from CC.Customers;

BULK INSERT CC.Customers 
FROM 'E:\steve\Documents\Quantico06\ISTA420\Data\Customers.csv'
WITH (
FORMAT = 'CSV',
KEEPNULLS,
DATAFILETYPE = 'char',
--FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

BULK INSERT CC.Employees FROM 'E:\steve\Documents\Quantico06\ISTA420\Data\Employees.csv'
WITH
(
FORMAT = 'CSV',
DATAFILETYPE = 'char',
--FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

BULK INSERT CC.Offices FROM 'E:\steve\Documents\Quantico06\ISTA420\Data\Offices.csv'
WITH
(
FORMAT = 'CSV',
DATAFILETYPE = 'char',
--FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

BULK INSERT CC.OrderDetails FROM 'E:\steve\Documents\Quantico06\ISTA420\Data\OrderDetails.csv'
WITH
(
FORMAT = 'CSV',
DATAFILETYPE = 'char',
--FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

BULK INSERT CC.Orders FROM 'E:\steve\Documents\Quantico06\ISTA420\Data\Orders.csv'
WITH
(
FORMAT='CSV',
KEEPNULLS,
DATAFILETYPE = 'char',
--FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

BULK INSERT CC.Payments FROM 'E:\steve\Documents\Quantico06\ISTA420\Data\Payments.csv'
WITH
(
FORMAT = 'CSV',
DATAFILETYPE = 'char',
--FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

BULK INSERT CC.ProductLines FROM 'E:\steve\Documents\Quantico06\ISTA420\Data\ProductLines.csv'
WITH
(
FORMAT = 'CSV',
DATAFILETYPE = 'char',
--FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

BULK INSERT CC.Products FROM 'E:\steve\Documents\Quantico06\ISTA420\Data\Products.csv'
WITH
(
FORMAT = 'CSV',
DATAFILETYPE = 'char',
--FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);
GO

-- 3. Perform the following queries:
--(a) How many distinct products does ClassicModels sell?

Select DISTINCT count(p.productLine) from CC.Products p
where p.productLine = '"Classic Cars"';

-- (b) Report the name and city of customers who don't have sales representatives?

Select c.customerName, c.city, c.salesRepEmployeeNumber from CC.Customers c
where c.salesRepEmployeeNumber = 'NULL';


-- (c) What are the names of executives with VP or Manager in their title? 
-- Use the CONCAT function to combine the employee's first name 
-- and last name into a single field for reporting.

Select CONCAT(firstName, ' ', lastName) as Name, jobTitle from cc.Employees e
where jobTitle LIKE '%VP%' OR jobTitle LIKE '%Manager%';


-- (d) Which orders have a value greater than $5,000?

Select orderNumber, CONVERT(money, priceEach) * CONVERT(int, quantityOrdered) as total from CC.OrderDetails od
where (Select CONVERT(money, priceEach) * CONVERT(int, quantityOrdered)) > 5000 
Order by (Select CONVERT(money, priceEach) * CONVERT(int, quantityOrdered)) ASC;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
-- (e) Report the account representative for each customer.
Select customerName, salesRepEmployeeNumber from CC.Customers c
---------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


-- (f) Report total payments for Atelier graphique.

Select SUM((convert(money,amount))) from CC.Payments
JOIN CC.Customers on Customers.customer Number=Payments.customerNumber 
where customerName LIKE '%Atelier graphique%';



-- (g) Report the total payments by date

Select amount, 
convert(datetime, paymentDate) as dateConverted from CC.Payments order by paymentDate ASC;

--------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
-- (h) Report the products that have not been sold.
select * from CC.OrderDetails order by quantityOrdered ASC;
select * from CC.Products; 

select * from CC.OrderDetails
JOIN CC.Products on Products.productCode=OrderDetails.productCode order by quantityOrdered ASC;
----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


-- (i) List the amount paid by each customer.
-- Orders table doesn't show customerNumber as shown in the diagram
Select orderNumber,  CONVERT(money, priceEach) * CONVERT(int, quantityOrdered) as TotalPrice from CC.OrderDetails


-- (j) List products sold by order date.

select *, convert(datetime, orderdate) as dateConverted  from CC.orders order by orderDate ASC;


-- (k) List the order dates in descending order for orders for the 1940 Ford Pickup Truck.
----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
select *, convert(datetime, orderdate) from CC.Orders 
where Exists
(Select productCode from CC.Products where productName LIKE '%1940 Ford Pickup Truck%');

----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
-- // TODO
-- (l) List the names of customers and their corresponding order number where a particular order from
-- that customer has a value greater than $25,000? 
Select orderNumber, CONVERT(money, priceEach) * CONVERT(int, quantityOrdered) as total from CC.OrderDetails
where (Select CONVERT(money, priceEach) * CONVERT(int, quantityOrdered)) > 25000; 
----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

-- (m) Compute the commission for each sales representative, assuming the commission is 5% of the
-- value of an order. Sort by employee last name and first name.

Select *, CONVERT(money, priceEach) * CONVERT(int, quantityOrdered) * 1.05 - CONVERT(money, priceEach) * CONVERT(int, quantityOrdered) as Commission
from CC.OrderDetails


-- (n) What is the difference in days between the most recent and oldest order date in the Orders file?
Select datediff(day, (MIN(convert(datetime, orderdate))), (MAX(convert(datetime, orderdate)))) from CC.orders 


-- (o) Compute the average time between order date and ship date for each customer ordered by the
-- largest difference.

 update CC.Orders
 set  shippedDate = replace(shippedDate, 'NULL', '2003-01-06 00:00:00.000')
select orderNumber,
(datediff
(day, 
(ISNULL(convert(datetime, orderdate), ' ')) + convert(datetime, orderdate), 
(ISNULL(convert(datetime, shippedDate), ' ')) + convert(datetime, shippedDate)) / count(orderDate))
as diffdatebetween 
from CC.orders 
group by shippedDate, orderDate, orderNumber
order by diffdatebetween desc
