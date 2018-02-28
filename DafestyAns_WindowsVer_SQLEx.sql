
--test codes
SELECT * FROM MemberCategories ORDER BY MemberCategory;
SELECT * FROM GoodCustomers ORDER BY MemberCategory;
SELECT * From Customers

DROP TABLE 

--W2Q.1
--Create a table
CREATE TABLE MemberCategories
(MemberCategory 			nvarchar(2)		NOT NULL,
 MemberCatDescription 	nvarchar(200)		NOT NULL,
 PRIMARY KEY (MemberCategory));

--W2Q.2
--INSERT DATA VALUES INTO TABLE
INSERT INTO MemberCategories 
VALUES ('A', 'Class A Members'), ('B', 'Class B Members'), ('C', 'Class C Members');

--W2Q.3
--Creating NEW TABLE
CREATE TABLE GoodCustomers
(CustomerName 	nvarchar(50)	NOT NULL,
 Address 		nvarchar(65),
 PhoneNumber 	nvarchar(9)		NOT NULL,
 MemberCategory 	nvarchar(2),
PRIMARY KEY (CustomerName, PhoneNumber),
FOREIGN KEY (MemberCategory) 
	REFERENCES MemberCategories (MemberCategory));

--code I got when attempting to create foreign key in DBeaver GUI itself
/*ALTER TABLE `GoodCustomers` 
ADD CONSTRAINT GOODCUSTOMERS_MEMBERCATEGORIES_FK FOREIGN KEY (`MemberCategory`) 
													REFERENCES `MemberCategories`(`MemberCategory`) ;*/

--W2Q.4
--Insert Customers with Member Catgory A or B into GoodCustomers
INSERT INTO GoodCustomers 
(CustomerName, PhoneNumber, MemberCategory)
SELECT CustomerName, PhoneNumber, MemberCategory
FROM Customers
WHERE MemberCategory IN ('A', 'B');

--W2Q.5
--insert extra data into GoodCustomers
INSERT INTO GoodCustomers
(CustomerName, PhoneNumber, MemberCategory)
VALUES ('Tracy Tan', '736572', 'B');

--W2Q.6
--insert even more data, this time all info is given
INSERT INTO GoodCustomers
VALUES ('Grace Leong','15 Bukit Purmei Road, Singapore 0904','278865','A');

--W2Q.7
--insert even more data, this time with an error (referential integrity violation, 
--P doesn't exist in MemberCategories)
INSERT INTO GoodCustomers
VALUES ('Lynn Lim','15 Bukit Purmei Road, Singapore 0904','278865','P');

--W2Q.8
--changing Grace Leong's address
UPDATE GoodCustomers
SET Address = '22 Bukit Purmei Road, Singapore 0904'
WHERE CustomerName = 'Grace Leong';

--W2Q.9
--updating a customer's mem cat
UPDATE GoodCustomers
SET MemberCategory = 'B'
WHERE CustomerName IN (SELECT CustomerName FROM Customers
						WHERE CustomerID = '5108');

--W2Q.10
--removing grace from DB
DELETE FROM GoodCustomers
WHERE CustomerName = 'Grace Leong';

--W2Q.11
--removing B members from DB
DELETE FROM GoodCustomers
WHERE MemberCategory = 'B';

--W2Q.12
--Adding column FaxNumber to GoodCustomers
ALTER TABLE GoodCustomers
ADD FaxNumber nvarchar(25);

--W2Q.13
--changing nvarchar size for address in GC
ALTER TABLE GoodCustomers
ALTER COLUMN Address nvarchar(80);

--W2Q.14
--Add ICNumber to GC
ALTER TABLE GoodCustomers
ADD ICNumber nvarchar(10);

--W2Q.15
--creating unique index for ICNumber... which won't work cause:
--1) no values in ICNumber and
--2) NULL values when reoccuring are considered duplicate and non-unique
CREATE UNIQUE INDEX ICIndex
	ON GoodCustomers(ICNumber);

--W2Q.16
--Creating a valid index for FaxNumber
CREATE INDEX FaxIndex
	ON GoodCustomers(FaxNumber);

--W2Q.17
--Dropping the made index in 16... no need ALTER apparently...
DROP INDEX FaxIndex ON GoodCustomers;

--W2Q.18
--removing column FaxNumber...
ALTER TABLE GoodCustomers
DROP COLUMN FaxNumber;

--W2Q.19
--deleting all records from GoodCustomers
DELETE FROM GoodCustomers;

--W2Q.20
--Droping entire GoodCustomers table... wow this feels like a waste of time
DROP TABLE GoodCustomers;