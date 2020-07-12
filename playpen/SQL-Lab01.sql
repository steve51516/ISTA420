.echo on
.headers on

-- Name:fish.sql
-- Author: Steven Fairchild
-- Date: July 2, 2020

drop table if exists fish;

create table fish (
id int,
name text,
color text,
species text,
age int,
);

insert into fish values (1,"Fatty","black","black moore telescope goldfish",12);
insert into fish values (2,"Garfield","orange","ryukin",6);
insert into fish values (3,"Casper","white","ryukin",5);
insert into fish values (4,"Sherbert","white and gold","oranda",9);
insert into fish values (5,"Mario","white and red","red cap oranda",8);
insert into fish values (6, "no name","albino","bristlenose pleco",12);
insert into fish values (7, "no name","albino","bristlenose pleco",12);

.schema fish

select * from fish;
select * from fish where age = 12;
select * from fish where color like "white";
select * from fish where color like "orange";
select name from fish;
select avg(age) from fish;
select sum(age) from fish;