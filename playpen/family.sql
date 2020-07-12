.echo on
.headers on
-- Name: Steven Fairchild
-- File: family.sql
-- Date: July 2, 2020



drop table if exists family;

id int primary key
create table family (
id int,
name text,
sex int,
role text
);

insert into family values (1,"Steven",1,"parent");
insert into family values (2,"Chika",0,"parent");
insert into family values (3,"Casie",0,"child");
insert into family values (4,"Jackson",1,"child");
insert into family values (5,"Max",1,"pet");
insert into family values (6,"Midnight",0,"pet");

select * from family;
select * from family where sex = 1;
select * from family where role like "child";
select * from family where role like "pet";
-- select * from family where id = (id % 2 = 0);