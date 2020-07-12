.headers on
.echo on

-- Name: Steven Fairchild
-- File: T-SQL_EX02.sql
-- Date: July 10, 2020

-- 1. List the company name, the contact name and the country of all customers in Poland.
 select companyname, contactname, country from customers where country like 'Poland';
 
 -- 2. List the order Id, the order date, and the destination city of all orders shipped to Berlin.
 select orderid, shipcity, orderdate from orders where shipcity like 'Berlin';
 
 -- 3. How many boxes of Filo Mix do we have in stock?
 select unitsinstock, productname from products where productname like '%Filo%';
 
 -- 4. List the telephone numbers of all of our shippers.
 select phone, companyname from shippers;
 
 -- 5. Who is our oldest employee? Who is our youngest employee?
 
 -- Youngest employee
 select employeeid, firstname, lastname, birthdate from employees where birthdate = (select max(birthdate) from employees);
 
 -- Oldest employee
 select employeeid, firstname, lastname, birthdate from employees where birthdate = (select min(birthdate) from employees);
 
 -- 6. List the suppliers where the owner of the supplier is also the sales contact.
 select supplierid, contactname, contacttitle from suppliers where contacttitle like '%sales r%';
 
 -- 7. Mailing Labels
 -- From the Northwind database we used in class and SQLite, create mailing labels for customer represen-
 -- tatives. Each label should consist of six, and exactly six, lines. The mailing labels should be suitable
 -- for printing on sticky label paper, specifically Avery 8160 labels. The format should be as follows:
 -- TITLE FIRSTNAME LASTNAME
 -- COMPANYNAME
 -- STREET ADDRESS
 -- CITY STATE ZIP COUNTRY
 -- [blank line]
 -- [blank line]
 
 -- I only listed addresses from the united states because having the state in the address is a requirement.
 
 select contacttitle || ' ' || contactname || '
' || companyname || '
' || address || '
' || city || ' ' || region || ' ' || postalcode || ' ' || country || '
' || '
' from customers where contacttitle like 'Sales Representative' and country like 'USA';
-- 8. Telephone Book
select substr(contactname, 1, instr(contactname, " ")-1) || ', ' || substr(contactname, instr(contactname, " ")+1) || ' ' || substr(contactname, 1, instr(contactname, "_ ")) || '      ' || companyname || '   ' || phone from customers;
