-- Un query que permita obtener la cantidad total de productos vendidos por cada categoría por año

SELECT 
    -- Selecciona el año de la fecha de la orden
    YEAR(SOH.OrderDate) AS Año,
    -- Selecciona el nombre de la categoría del producto
    PC.Name AS Categoría,
    -- Calcula la suma de la cantidad de productos vendidos
    SUM(SOD.OrderQty) AS TotalVendido
FROM 
    -- Selecciona la tabla de encabezados de órdenes de ventas
    Sales.SalesOrderHeader SOH
INNER JOIN 
    -- Realiza una unión con la tabla de detalles de órdenes de ventas
    Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN 
    -- Realiza una unión con la tabla de productos
    Production.Product P ON SOD.ProductID = P.ProductID
INNER JOIN 
    -- Realiza una unión con la tabla de subcategorías de productos
    Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
INNER JOIN 
    -- Realiza una unión con la tabla de categorías de productos
    Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID
GROUP BY 
    -- Agrupa los resultados por año y categoría
    YEAR(SOH.OrderDate), PC.Name
ORDER BY 
    -- Ordena los resultados por año y categoría
    Año, Categoría;
