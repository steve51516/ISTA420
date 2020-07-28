.echo on
.headers on

-- Name: Steven Fairchild
-- File: QUIZ03.sql
-- Date: July 16, 2020

-- 1. Write a report giving the employee id, first name, last name, and the average amount of all orders by that employee. Use the SQL 92 syntax. Do not use a group by clause. Here is my output:
select distinct e.employeeid, e.firstname, e.lastname from (employees e join orders o on e.employeeid = o.employeeid) join order_details od on o.orderid = od.orderid;

-- 2. In some cities, we have customers, suppliers, and employees. Write a report that lists the customer’s contact name, the supplier’s contact name, the employee’s name, and the city in which all three are located. Use the SQL 92 syntax. Do not use a group by clause. Here is my output:
select c.contactname, s.contactname, e.firstname, e.lastname, c.city from customers c join suppliers s on c.city = s.city join employees e on e.city = c.city;

