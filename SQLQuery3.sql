--Data types in SQL
--Date and Time data type- stores date type values
DECLARE @mydate date='05-14-2021'
SELECT @mydate AS Mydate

--Date time data type- stores date combined with time values
DECLARE @mydatetime datetime='05-14-2021'
SELECT @mydatetime AS todayDateTime

DECLARE @mytime time='16:25:42.12'
SELECT @mytime AS todaydate

SELECT @mydate AS Mydate,@mytime AS Mytime

--UNICODE AND NON-UNICODE data types
--NON UNICODE- Takes 1 Byte for storage
--CHAR(n)- stores fixed length non-unique code data
DECLARE @mychar CHAR(20)='Edvancer'
SELECT @mychar AS char, DATALENGTH(@mychar) AS DataLength,LEN(@mychar) AS Length;

--Varchar- stores variable length non-unique code data
DECLARE @myvar VARCHAR(20)='Edvancer'
SELECT @myvar AS 'myvarchar',DATALENGTH(@myvar) AS DataLength,LEN(@myvar) AS Length;

--UNICODE Data Type- Takes 2 bytes for storage
--nchar- stores fixed length unicode data
DECLARE @mynchar NCHAR(20)='Edvancer'
SELECT @mynchar AS mynchar,DATALENGTH(@mynchar) AS DataLength,LEN(@mynchar) AS Length;
--nvarchar- stores variable length unique code data
DECLARE @mynvar NVARCHAR(20)='Edvancer'
SELECT @mynvar AS mynvar,DATALENGTH(@mynvar) AS DataLength,LEN(@mynvar) AS Length;

--INTEGER Data type
DECLARE @smallint smallint=12376.7854
SELECT @smallint as small;

--FLOAT Data type
DECLARE @float float(10)=12376.7854
SELECT @float AS float;

DECLARE @float float(10),@int int
set @float=12376.7854
set @int=570
SELECT @float+@int AS Result

--DML Statements
--FILTERING the Data- WHERE Clause
--Find out the employee having sick hours more than 50
SELECT * FROM HumanResources.Employee
WHERE SickLeaveHours>50

--Find the credit cards that expired in the year 2008
SELECT * FROM Sales.CreditCard
WHERE ExpYear=2008

--Types of Operators
--Arthematic Operators
--ADD
SELECT 8+2
--SUB
SELECT 8-2
--MUL
SELECT 8*2
--DIV
SELECT 8/2
--MODULUS
SELECT 8%2

--COMPARISION Operators
--Find the store ID not operating in territory ID 4 from the customers table
SELECT StoreID,TerritoryID from Sales.Customer
WHERE TerritoryID<>4
--Find the the transaction details from transaction history table where the actual cost is not less than 2000
SELECT * from Production.TransactionHistory
WHERE ActualCost!=2000

--Basic Logical Operators
--Write a query to fetch the sales person details for territory 4 having commission % of 1.5
SELECT * from Sales.SalesPerson
WHERE TerritoryID=4 AND CommissionPct=0.015
--Write a query to fetch employees having more than 50 vacation hours or 30 sick hours
SELECT * from HumanResources.Employee
WHERE VacationHours>50 OR SickLeaveHours>30
--Where a query to fetch purchase order details where received quanty is between 550 and 600
SELECT * from Purchasing.PurchaseOrderDetail
WHERE ReceivedQty BETWEEN 550 AND 600
--fetch the employees who are 'Tool Designer','Senior Tool Designer','Design Engineer'
SELECT * from HumanResources.Employee
WHERE JobTitle IN ('Tool designer','Senior Tool designer','Design Engineer')
--Fetch 'Ball barings' Product from Product table
SELECT * from Production.Product
WHERE Name LIKE 'Bearing Ball'
--Fetch products that have 'Bearing' in it's name
SELECT * from Production.Product
WHERE Name LIKE '%Bearing%'
--Fetch address info from address table where Postal code ends with either 2 or 6
SELECT * from Person.Address
WHERE PostalCode LIKE '%[26]'

--Complex logical operators
--Find the product sub categories with a black color product
--EXISTS
SELECT * from DimProductSubcategory subcat
WHERE EXISTS
(SELECT * from DimProduct prod 
WHERE Color='black' AND subcat.ProductSubcategoryKey=prod.ProductSubcategoryKey)
--ALL
--Find the employees having base rate greater than base rate for all employees under sales department
SELECT * from DimEmployee 
WHERE BaseRate> ALL
(SELECT BaseRate from DimEmployee 
WHERE DepartmentName='Sales');
--ANY
SELECT * from DimEmployee 
WHERE BaseRate> ANY
(SELECT BaseRate from DimEmployee 
WHERE DepartmentName='Sales');

--DISTINCT
--Find the distinct title of persons from persons table
SELECT DISTINCT(Title) from Person.Person
--Find the distinct combitions of discount types and its categories
SELECT DISTINCT [Type],[Category] from Sales.SpecialOffer

--Sorting- ORDER BY
SELECT DISTINCT GroupName from HumanResources.Department
ORDER BY GroupName DESC
--Find the line total amount for productID 776 from in ascending order from sales order details table
SELECT ProductID,LineTotal from Sales.SalesOrderDetail
WHERE ProductID=776
ORDER BY LineTotal

--TOP N- Restricts number of records to be fetched
--Find top 10 order quantity for productID 722 from work order table
SELECT TOP 10 * from Production.WorkOrder
WHERE ProductID=722
ORDER BY OrderQty DESC
--Find Top 10 rejected products with tied values from table Purchase Order Details
SELECT TOP 10 WITH TIES DueDate,ProductID,RejectedQty from Purchasing.PurchaseOrderDetail
ORDER BY RejectedQty DESC
--Find TOP 50% Scrapped reason for all scrapped quantity from table worker order
SELECT TOP 50 PERCENT ScrappedQty,ScrapReasonID from Production.WorkOrder
ORDER BY ScrappedQty

SELECT * FROM Production.WorkOrder

--NULL Comparision- Null values can not be compared with arthematic operators
-- Use NULL or NOT NULL Claus
--Find  all sales order details where carrier tracking number is not null from table 'Sales Order Details'
SELECT * from Sales.SalesOrderDetail
WHERE CarrierTrackingNumber IS NOT NULL
--Find the list of all persons whose name title is null from 'Person table'
SELECT * from Person.Person
WHERE Title IS NULL
--Find the list of all address and replace address line 2 with address line 1 where address line 2 is null from 'Address table'
SELECT AddressLine1,ISNULL(AddressLine2,AddressLine1),AddressLine2
FROM Person.Address

--Alias
--Combine all the address fields to form a single address field
SELECT AddressLine1,AddressLine2,AddressLine1+' '+ISNULL(AddressLine2,AddressLine1)+' '+PostalCode AS Address
FROM Person.Address
--Write the query to fetch the total quantity as stocked quantity and scrapped quantiy from 'product work order' table
SELECT ScrappedQty,StockedQty,ScrappedQty+StockedQty [total quantity]
FROM Production.WorkOrder

--AGGRATIONS
--SUM()
--Find the total quantities sold through internet sales in the year 2006
SELECT * FROM FactInternetSales

SELECT SUM(OrderQuantity) AS [Total Quantity] FROM FactInternetSales
WHERE OrderDateKey/10000=2006

--AVG()
--Write a query to fetch the avg unit price of the internet sales recorded in year 2005 for sales territory
SELECT AVG(UnitPrice) from FactInternetSales
WHERE OrderDateKey/10000=2005 AND SalesTerritoryKey=6

--MIN()
--Fetch the minimum amount of salesAmountQuota for the year 2006 from 'FactSalesQuota'
SELECT MIN(SalesAmountQuota) AS MIN_Quota from FactSalesQuota
WHERE CalendarYear=2006

--COUNT()
--Fetch the count of silver color products from 'Dimproduct' table
SELECT COUNT(*) FROM DimProduct
WHERE Color='silver';

--GROUP BY
--How many total calls were made by call centre executive in each shift from 'factcallcentre' table
SELECT SUM(Calls),Shift from FactCallCenter
GROUP BY Shift;
--Where clause is executed first and then followed by GROUP BY Clause
--Find the sales for each productID
SELECT ProductID, SUM(SalesQuantity) from Sales
GROUP BY ProductID;
--Find the avg yearly sales amount of reseller sales for each sales territory sorted by order year from 'FactResellerSales'
SELECT AVG(SalesAmount),SalesTerritoryKey,OrderDateKey from FactResellerSales
GROUP BY SalesTerritoryKey,OrderDateKey
ORDER BY OrderDateKey
--Find the total orders raised on weekdays and on holidays through call center from FactCallCenter table
SELECT SUM(Orders) AS TotalOrders,WageType from FactCallCenter
GROUP BY WageType

--HAVING Clause
--it works just like WHERE Clause but for the aggregated data
--In which shift we are making more than 400 avg calls per day
SELECT AVG(Calls),Shift,DateKey from FactCallCenter
GROUP BY Shift,DateKey
HAVING AVG(Calls)>400;
--Find the male prospective buyers for each occupation type having yearly income greater than 90000 from 'Perspective buyers' table
SELECT Gender, SUM(YearlyIncome),Occupation from ProspectiveBuyer
GROUP BY Occupation,Gender
HAVING SUM(YearlyIncome)>90000 AND Gender='M';

select * from ProspectiveBuyer

--subquery
--select * from sales.SalesOrderDetail
--select * from Sales.SalesOrderHeader

--subquery for column expression
select SalesOrderNumber, SubTotal, OrderDate,
(select SUM(OrderQty) from sales.SalesOrderDetail
where SalesOrderID=43659)  AS TotalQuantity
from sales.SalesOrderHeader where SalesOrderID=43659

--subquery for filter expression
select BusinessEntityID,FirstName,LastName from Person.Person
where BusinessEntityID=
(select BusinessEntityID from HumanResources.Employee
where NationalIDNumber='895209680');

--find the total sales value for silver coloured product
select sum(salesquantity) as TotalSales from sales
where ProductID IN
(select ProductID from Products
where color='silver')

--find products with sales value greater than average sales value of all the products
select distinct ProductID from sales
where SalesValue> ALL
(select avg(SalesValue)as avgsales from sales GROUP BY ProductID)

--find the total sales value against each product from sales table if there is a sale recorded for productID=8
SELECT ProductID,sum(SalesValue) from Sales
where EXISTS
(SELECT * FROM Sales where ProductID=8)
GROUP BY ProductID

--find month with sales value greater than equal to avg sales value of the month
select DISTINCT MonthID,SalesValue from Sales where SalesValue >= 
(select avg(salesvalue) from Sales) 

--Find avg sales for each product for sales done in Ahmedabad city
select * from sales
select * from City

select avg(salesvalue),ProductID from sales
where CityID IN 
(select CityID from City where CityName ='Ahmedabad')
GROUP BY ProductID

--find min sales for each month for sales done in year 2015
select min(salesvalue),MonthID from sales where MonthID IN
(select MonthID from sales where MonthID like '2015%')
Group by MonthID

--OVER Clause- we can get aggregated data with out GROUP BY
--Find the yearly income of the prospective buyers along with the average income of their occuption
SELECT FirstName,LastName,YearlyIncome, AVG(YearlyIncome)
OVER(partition by Occupation) as Avg_occ_income
from ProspectiveBuyer;

--What % of total value does each value represents
SELECT *,ROUND((SalesQuantity*100)/SUM(SalesQuantity)OVER(Partition by ProductID),2)
 from Sales;

 --Ranking functions-Gives the rank to each row over the partition of the data
 --RANK()
 --Write a query to rank the employee based on their hire date for each job title from table HumanResourcesEmployee
 SELECT JobTitle,
	LoginID,
	HireDate, 
 RANK() OVER(PARTITION BY JobTitle
 ORDER BY Hiredate)
 from AdventureWorks2014.HumanResources.Employee;
 --ROW NUMBER()
 --	Write a query to display row number for each record from sales table
 SELECT ROW_NUMBER() OVER(ORDER BY NAME) AS ROW_NUM,*
 FROM AdventureWorks2014.Sales.Store;

 --DATE AND TIME Functions
 --CONVERT()- To convert the date into any other format
 SELECT CONVERT(DATE,'14 NOV 2005',101);
 SELECT CONVERT(DATETIME,'14 NOV 2005 11:45',113);
 --GETDATE()
 SELECT GETDATE();
 SELECT CONVERT(DATE,GETDATE(),101);
 SELECT CONVERT(DATETIME,GETDATE(),109);
 --DATEPART()
 SELECT DATEPART(d,'14 nov 2015');
 SELECT DATEPART(YYYY,'14 NOV 2015');
 --DATEADD()
 SELECT DATEADD(dd,2,'14 nov 2015');
 SELECT DATEADD(YY,-1,'14 NOV 2015');
 SELECT DATEADD(MM,-1,'14 NOV 2015');
--DATEDIFF()
SELECT DATEDIFF(MM,'14 NOV 2015','14 DEC 2015');
SELECT DATEDIFF(YY,'14 NOV 2015','14 DEC 2016');

--LOGICAL Functions
--CHOOSE()- CHOOSE(index_to_choose,val1,val2,val3,...)
--Write a query to catgorise the different shifts as given below from table 'HumanResourcesShift'
SELECT Name,CHOOSE(ShiftID,'GeneralShift','ReportingShift','CriticalShift') Category
from AdventureWorks2014.HumanResources.Shift;
SELECT * FroM HumanResources.Shift;
--Write a query to categorise the discount % in below categories along with their names from table 'Sales.SpecialOffer'
SELECT Description,DiscountPct,
IIF(DiscountPct>0.30,'Bumper sale','Regular Sale') AS Category
from AdventureWorks2014.Sales.SpecialOffer;

--STRING FUNCTIONS
--CHARINDEX()
SELECT CHARINDEX('name','My name is Priya');
SELECT CHARINDEX('name','My name is Priya',2);
SELECT CHARINDEX('name','My name is Priya',8);
--CONCAT()
SELECT CONCAT('Happy','Birthday');
SELECT CONCAT('Happy',' ','Birthday');
--LEFT()
SELECT LEFT('UNIVERSE',3);
SELECT LEFT('UNIVERSE',1);
SELECT LEFT('UNIVERSE',5);
--RIGHT()
SELECT RIGHT('UNIVERSE',3);
SELECT RIGHT('UNIVERSE',1);
SELECT RIGHT('UNIVERSE',5);
--LEN()
SELECT LEN('UNIVERSE');
SELECT LEN('Happy Birthday');
--LOWER()
SELECT LOWER('UNIVERSE');
SELECT LOWER('ANIL');
--UPPER()
SELECT UPPER('universe');
SELECT UPPER('Priya');
--REVERSE()
SELECT REVERSE('name');
SELECT REVERSE('Priya');
--SUBSTRING()
SELECT SUBSTRING('Very Good Morning',6,4);
--REPLACE()
SELECT REPLACE('Good Boy','Good','Bad');
SELECT REPLACE('abcdef','abc','123');

--CONVERSION Functions
--CAST(), CONVERT()
--Write a query to prepare a report on list on price of all products as on sell start date from table 'Production.Product'
SELECT 'List price of product'+Name+'is'+CONVERT(NVARCHAR,ListPrice)+'as on date'+
CONVERT(NVARCHAR,SellStartDate) from Production.Product;

SELECT 'List price of product'+Name+'is'+CAST(ListPrice as NVARCHAR)+'as on date'+
CAST(SellStartDate as NVARCHAR) from Production.Product

--Write a query to find the ratio of scrapped quantity against orderd quantity from table 'Production.WorkOrder' upto 2 decimal point
SELECT CAST(CAST(OrderQty AS decimal(10,2))/CAST(ScrappedQty AS decimal(10,2)) AS decimal(10,2)) RATIO
from Production.WorkOrder;
