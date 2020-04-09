CREATE VIEW dbo.vw_InternetSales 
AS
SELECT
f.ProductKey,
f.OrderDateKey,
f.CustomerKey,
f.SalesOrderNumber,
f.OrderQuantity,
f.UnitPrice,
f.UnitPriceDiscountPct,
f.ExtendedAmount,
f.ProductStandardCost,
f.TotalProductCost

FROM
dbo.FactInternetSales f;


CREATE VIEW dbo.vw_Product
AS
SELECT
dp.ProductKey,
dp.EnglishProductName AS ProductName,
ISNULL(pc.EnglishProductCategoryName, 'NA') AS CategoryName,
ISNULL(sc.EnglishProductSubcategoryName, 'NA') SubCategoryName,
dp.Color,
ISNULL(dp.Size, 'NA') AS Size,
ISNULL(dp.ModelName, 'NA') AS ModelName,
ISNULL(dp.EnglishDescription, 'NA') AS ProductDescription

FROM
dbo.DimProduct dp
LEFT JOIN dbo.DimProductSubcategory sc
	ON sc.ProductSubcategoryKey = dp.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory pc
	ON pc.ProductCategoryKey = sc.ProductCategoryKey;


CREATE VIEW dbo.vw_Customer
AS
SELECT
dc.CustomerKey,
dc.FirstName,
dc.LastName,
CONCAT(dc.FirstName, ' ', dc.LastName) AS FullName,
dc.EnglishOccupation AS Occupation,
dc.EmailAddress,
dc.Phone AS PhoneNumber

FROM
dbo.DimCustomer dc;

CREATE VIEW dbo.vw_CalendarDate
AS
SELECT
dd.DateKey,
CAST(CONCAT(dd.CalendarYear, '-', dd.MonthNumberOfYear, '-', dd.DayNumberOfMonth) AS DATE) AS CalendarDate,
dd.EnglishMonthName AS [MonthName],
dd.WeekNumberOfYear,
dd.CalendarYear,
dd.MonthNumberOfYear,
dd.DayNumberOfMonth

FROM
dbo.DimDate dd;
