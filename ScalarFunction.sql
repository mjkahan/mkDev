-- =============================================
-- Author:		Michael Kahan
-- Create date:  1/29/2019
-- Description:	Scalar Function to return First Order Date
-- =============================================
CREATE FUNCTION [Demo].[ufnGetFirstOrderDate]
(
	-- Add the parameters for the function here
	@EmployeeID INT
)
RETURNS DATE -- Returns best sales date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @FirstOrderDate AS DATE;

	-- Add the T-SQL statements to compute the return value here
	SELECT @FirstOrderDate = CAST(MIN(SOH.OrderDate) AS DATE)
		FROM Sales.SalesOrderHeader SOH
		LEFT JOIN Sales.SalesOrderDetail SOD
			ON SOD.SalesOrderID = SOH.SalesOrderID
		LEFT JOIN Sales.SalesPerson SP
			ON SP.BusinessEntityID = SOH.SalesPersonID
		LEFT JOIN HumanResources.Employee EMP
			ON EMP.BusinessEntityID = SP.BusinessEntityID
		LEFT JOIN Person.Person PER
			ON PER.BusinessEntityID = EMP.BusinessEntityID

		WHERE
		SP.BusinessEntityID = @EmployeeID
		;

	-- Return the result of the function
	RETURN @FirstOrderDate;

END
