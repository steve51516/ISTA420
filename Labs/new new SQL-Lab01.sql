.echo on
.headers on

--Name: myfamily.sql
--Author: Steven Fairchild
--Date: July 2, 2020

drop table if exists family;

create table family (
id int,
name text,
sex int,
role text,
age int,
);

insert into family values (1,'Steven',1,'Husband',25);
insert into family values (2,'Victoria'0,'Wife',25);

.schema

select * from family;
select * from family where sex = 1