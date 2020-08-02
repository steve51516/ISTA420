-- Name: Steven Fairchild
-- File: EX05-steven.sql
-- Date: August, 01 2020

use TSQLV4;

DROP TABLE IF EXISTS USA.Presidents;
DROP SCHEMA IF EXISTS USA;

GO
CREATE SCHEMA USA;
GO

CREATE TABLE USA.Presidents(
ID varchar(20),
Last_Name varchar(50), 
First_Name varchar(50),
Middle_Name varchar(50),
Order_of_Presidency varchar(50),
Date_of_Birth varchar(50),
Date_of_Death varchar(50),
Town_Or_County_of_Birth varchar(50),
State_of_Birth varchar(50),
Home_State varchar(50),
Party_Affliliation varchar(50),
Date_Took_Office varchar(50),
Date_Left_Office varchar(50),
Assassination_Attempt varchar(50),
Assassinated varchar(50),
Religous_Afflilation varchar(50),
Image_Path varchar(50)
);

BULK INSERT USA.Presidents FROM 'E:\steve\Documents\Quantico06\ISTA420\USP.csv'
WITH
(
DATAFILETYPE = 'char',
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

Delete TOP(1) from USA.Presidents;

ALTER TABLE USA.Presidents ALTER COLUMN ID INT NOT NULL;
ALTER TABLE USA.Presidents DROP column Image_Path;
ALTER TABLE USA.Presidents ADD CONSTRAINT ID CHECK (ID BETWEEN 1 AND 44);
ALTER TABLE USA.Presidents ADD PRIMARY KEY (ID)

ALTER TABLE USA.Presidents ALTER COLUMN Date_of_Birth DATE NOT NULL;
ALTER TABLE USA.Presidents ALTER COLUMN Date_of_Death DATE;
ALTER TABLE USA.Presidents ALTER COLUMN Date_Took_Office DATE NOT NULL;
ALTER TABLE USA.Presidents ALTER COLUMN Date_Left_Office DATE;

UPDATE USA.Presidents
SET Date_Left_Office = '01/20/2017', Assassinated = 'FALSE', Assassination_Attempt = 'FALSE'
OUTPUT inserted.*
WHERE ID = 44;

ALTER TABLE USA.Presidents DROP CONSTRAINT ID;
ALTER TABLE USA.Presidents ADD CONSTRAINT ID_CHECK CHECK (ID BETWEEN 1 AND 45);

INSERT INTO USA.Presidents (ID, Last_Name, First_Name, Middle_Name, Order_of_Presidency, Date_of_Birth, Date_of_Death,
Town_Or_County_of_Birth, State_of_Birth, Home_State, Party_Affliliation, Date_Took_Office, Date_Left_Office, Assassination_Attempt, 
Assassinated, Religous_Afflilation)
OUTPUT inserted.*
VALUES
(45, 
'Trump', 
'Donald', 
'John',
45,
'6/14/1946',
NULL,
'Queens, New York City',
'New York',
'New York',
'Republican',
'01/20/2017',
NULL,
NULL,
NULL,
'Presbyterian');

select p.First_Name, P.Last_Name, DATEDIFF(DAY, Date_Took_Office, Date_Left_Office) from USA.Presidents p

select First_Name, Last_Name, DATEDIFF(YEAR, Date_of_Birth, Date_Took_Office) as Age_When_Took_Office from USA.Presidents p


select count(ID) as NumOfPresidents, Home_State, Party_Affliliation
from USA.Presidents
group by Home_State, Party_Affliliation
order by Home_State, Party_Affliliation;

select count(ID) as NumOfPresidents, Religous_Afflilation, Party_Affliliation
from USA.Presidents
group by Religous_Afflilation, Party_Affliliation
order by Religous_Afflilation, Party_Affliliation;