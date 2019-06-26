-- =============================================
-- Author:		Michael Kahan
-- Create date:  1/29/2019
-- Description:	Stored Procedure to update RepPerformance table
-- =============================================
CREATE PROCEDURE Demo.uspUpdateRepPerformance
	@OrderYear INT

AS
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for procedure here

	-- Clear Table
	TRUNCATE TABLE Demo.RepPerformance

	-- Insert new records
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

	WHERE
	DATEPART(YEAR, SOH.OrderDate) = @OrderYear

	GROUP BY
	SP.BusinessEntityID,
	DATEPART(YEAR, SOH.OrderDate)


END
GO
