SELECT 
R.ID,
R.EmployeeID,
R.SalesQuantity,
R.SalesRevenue,
R.OrderYear,
Demo.ufnGetFirstOrderDate(R.EmployeeID) AS FirstOrderDate,
P.FirstName,
P.LastName,
A.City,
SP.StateProvinceCode,
CR.CountryRegionCode

FROM 
Demo.RepPerformance R
INNER JOIN Person.Person AS P 
	ON P.BusinessEntityID = R.EmployeeID
INNER JOIN Person.BusinessEntityAddress AS BEA 
	ON BEA.BusinessEntityID = R.EmployeeID
INNER JOIN Person.[Address] AS A 
	ON A.AddressID = BEA.AddressID  
INNER JOIN Person.StateProvince AS SP 
	ON SP.StateProvinceID = A.StateProvinceID 
INNER JOIN Person.CountryRegion AS CR 
	ON CR.CountryRegionCode = SP.CountryRegionCode
