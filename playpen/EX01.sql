.echo on
.headers on
-- Steven Fairchild
-- Assignment EX01
-- July 3, 2020

drop table if exists cars;

create table cars (
vin text primary key,
production_year int,
make text,
model text,
miles int,
cylinders int,
cubic_inches int,
condition text,
color text
);

insert into cars values (
'1HD1FBM13GB621764',
2016,
'Harley-Davidson',
'FLHR',
19585,
2,
103,
'fair',
'Velocity Red Sunglo');
insert into cars values (
'2T3G1RFV3KW022253',
2019,
'Toyota',
'RAV4',
13765,
4,
152,
'excellent',
'Grey');
insert into cars values (
'3N1AB7AP6HY267036',
2017,
'Nissan',
'Sentra',
57652,
4,
109,
'fair',
'Grey');
insert into cars values (
'1FA6P8TH6F5305400',
2015,
'Ford',
'Mustang',
57710,
4,
140,
'Good',
'Orange Fury');

.schema garage

select * from cars;
select * from cars where cylinders = 2;
select * from cars where cylinders = 4;
select avg(miles) from cars;
select avg(production_year) from cars;
select avg(cubic_inches) from cars;
select sum(miles) from cars;

.database
