-- Un query que permita obtener la cantidad total de productos vendidos por cada categor�a por a�o

SELECT 
    -- Selecciona el a�o de la fecha de la orden
    YEAR(SOH.OrderDate) AS A�o,
    -- Selecciona el nombre de la categor�a del producto
    PC.Name AS Categor�a,
    -- Calcula la suma de la cantidad de productos vendidos
    SUM(SOD.OrderQty) AS TotalVendido
FROM 
    -- Selecciona la tabla de encabezados de �rdenes de ventas
    Sales.SalesOrderHeader SOH
INNER JOIN 
    -- Realiza una uni�n con la tabla de detalles de �rdenes de ventas
    Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN 
    -- Realiza una uni�n con la tabla de productos
    Production.Product P ON SOD.ProductID = P.ProductID
INNER JOIN 
    -- Realiza una uni�n con la tabla de subcategor�as de productos
    Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
INNER JOIN 
    -- Realiza una uni�n con la tabla de categor�as de productos
    Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID
GROUP BY 
    -- Agrupa los resultados por a�o y categor�a
    YEAR(SOH.OrderDate), PC.Name
ORDER BY 
    -- Ordena los resultados por a�o y categor�a
    A�o, Categor�a;
