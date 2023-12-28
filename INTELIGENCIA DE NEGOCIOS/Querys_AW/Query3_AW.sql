--  Un query que permita calcular el tiempo promedio de env�o por categor�a de productos en el �ltimo trimestre

SELECT
    PC.Name AS CategoriaProducto, -- Nombre de la Categor�a de Producto
    YEAR(SOH.OrderDate) AS A�o, -- A�o
    AVG(DATEDIFF(DAY, SOH.OrderDate, SOH.ShipDate)) AS TiempoPromedioEnvioDias -- Tiempo Promedio de Env�o en D�as
FROM
    Sales.SalesOrderHeader AS SOH
JOIN
    Sales.SalesOrderDetail AS SOD
ON
    SOH.SalesOrderID = SOD.SalesOrderID -- Realiza una uni�n con la tabla de detalles de �rdenes de ventas basada en el ID de la orden de ventas
JOIN
    Production.Product AS P
ON
    SOD.ProductID = P.ProductID -- Realiza una uni�n con la tabla de productos basada en el ID del producto
JOIN
    Production.ProductSubcategory AS PS
ON
    P.ProductSubcategoryID = PS.ProductSubcategoryID -- Realiza una uni�n con la tabla de subcategor�as de productos basada en el ID de subcategor�a
JOIN
    Production.ProductCategory AS PC
ON
    PS.ProductCategoryID = PC.ProductCategoryID -- Realiza una uni�n con la tabla de categor�as de productos basada en el ID de categor�a
WHERE
    -- Filtra las �rdenes de ventas del trimestre m�s reciente y del a�o m�s reciente
    DATEPART(QUARTER, SOH.OrderDate) = (SELECT DATEPART(QUARTER, MAX(SOH.OrderDate)) FROM Sales.SalesOrderHeader AS SOH)
    AND YEAR(SOH.OrderDate) = (SELECT MAX(YEAR(SOH.OrderDate)) FROM Sales.SalesOrderHeader AS SOH)
GROUP BY
    PC.Name, YEAR(SOH.OrderDate) -- Agrupa los resultados por categor�a de productos y a�o
ORDER BY
    YEAR(SOH.OrderDate); -- Ordena los resultados por a�o

