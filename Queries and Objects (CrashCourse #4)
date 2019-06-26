-- Tutorial 1: ​SQL Server 2016 - Create/Insert/Select/Delete

-- Tell SQL Server you want to execute your code within the AdventureWorks database
USE AdventureWorks
GO

-- Create a new Schema to distinguish files for the Demo
CREATE SCHEMA Demo
GO

-- Create new table to hold data for RepPerformance
CREATE TABLE Demo.RepPerformance 
(
	ID INT PRIMARY KEY IDENTITY(1,1), -- Primary Key indicates a unique value and helps structure the table. IDENTITY(1,1) will make this column an auto-incrementing value starting from 1 and increasing by 1.
	EmployeeID INT,
	SalesQuantity INT, -- Sum of OrderQty
	SalesRevenue MONEY, -- Sum of ListPrice
	OrderYear INT -- Based on OrderDate
)

-- Insert records into new table using Values
INSERT INTO Demo.RepPerformance
(
	EmployeeID,
	SalesQuantity,
	SalesRevenue,
	OrderYear
)
VALUES
(11, 250, 2000, 1996),
(22, 175, 5000, 2018),
(33, 200, 3000, 2019),
(44, 75, 2500, 2015),
(55, 95, 6000, 2006),
(66, 100, 3500, 2002)

-- Select from table
SELECT * FROM Demo.RepPerformance

-- Delete from table
DELETE FROM Demo.RepPerformance WHERE SalesQuantity < 150

-- Verify records were deleted
SELECT * FROM Demo.RepPerformance

-- Truncate Table (clear all records)
TRUNCATE TABLE Demo.RepPerformance

-- Verify all records were removed
SELECT * FROM Demo.RepPerformance

-- Insert records into new table using Select
INSERT INTO Demo.RepPerformance
(
	EmployeeID,
	SalesQuantity,
	SalesRevenue,
	OrderYear
)
SELECT 
SP.BusinessEntityID AS EmployeeID,
SUM(SOD.OrderQty) AS SalesQuantity,
SUM(SOD.OrderQty * PRD.ListPrice) AS SalesRevenue,
DATEPART(YEAR, SOH.OrderDate) AS OrderYear

FROM
Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesOrderDetail SOD
	ON SOD.SalesOrderID = SOH.SalesOrderID
LEFT JOIN Sales.SalesPerson SP
	ON SP.BusinessEntityID = SOH.SalesPersonID
LEFT JOIN HumanResources.Employee EMP
	ON EMP.BusinessEntityID = SP.BusinessEntityID
LEFT JOIN Person.Person PER
	ON PER.BusinessEntityID = EMP.BusinessEntityID
LEFT JOIN Production.Product PRD
	ON PRD.ProductID = SOD.ProductID

GROUP BY
SP.BusinessEntityID,
DATEPART(YEAR, SOH.OrderDate)

-- Select from table
SELECT * FROM Demo.RepPerformance ORDER BY EmployeeID

-- Update records with empty EmployeeIDs
UPDATE Demo.RepPerformance 
SET EmployeeID = 0
WHERE EmployeeID IS NULL

-- Select from table to confirm no more empty EmployeeIDs
SELECT * FROM Demo.RepPerformance ORDER BY EmployeeID
