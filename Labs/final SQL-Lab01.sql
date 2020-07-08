.echo on
.headers on

-- Name: Family.sql
-- Author: Steven Fairchild
-- Date: July 2, 2020

drop table if exists family;

create table family (
id int,
name text,
age int,
role text,
sex int
);

insert into family values (1,'Steven',25,'husband',1);
insert into family values (2,'Victoria',35,'wife',0);
insert into family values (3,'Chester',9,'pet',1);
insert into family values (4,'Orion',.5,'pet',1);
insert into family values (5,'Dante',.5,'pet',1);
insert into family values (6,'Kai',.5,'pet',1);
insert into family values (7,'Taka',.5,'pet',1);

.schema family

select * from family;
select * from family where sex = 1;
select * from family where role like 'pet';
select * from family where role like 'husband';
select * from family where role like 'wife';
select name from family;
select avg(age) from family;
select sum(age) from family;