--  Un query que permita calcular el tiempo promedio de envío por categoría de productos en el último trimestre

SELECT
    PC.Name AS CategoriaProducto, -- Nombre de la Categoría de Producto
    YEAR(SOH.OrderDate) AS Año, -- Año
    AVG(DATEDIFF(DAY, SOH.OrderDate, SOH.ShipDate)) AS TiempoPromedioEnvioDias -- Tiempo Promedio de Envío en Días
FROM
    Sales.SalesOrderHeader AS SOH
JOIN
    Sales.SalesOrderDetail AS SOD
ON
    SOH.SalesOrderID = SOD.SalesOrderID -- Realiza una unión con la tabla de detalles de órdenes de ventas basada en el ID de la orden de ventas
JOIN
    Production.Product AS P
ON
    SOD.ProductID = P.ProductID -- Realiza una unión con la tabla de productos basada en el ID del producto
JOIN
    Production.ProductSubcategory AS PS
ON
    P.ProductSubcategoryID = PS.ProductSubcategoryID -- Realiza una unión con la tabla de subcategorías de productos basada en el ID de subcategoría
JOIN
    Production.ProductCategory AS PC
ON
    PS.ProductCategoryID = PC.ProductCategoryID -- Realiza una unión con la tabla de categorías de productos basada en el ID de categoría
WHERE
    -- Filtra las órdenes de ventas del trimestre más reciente y del año más reciente
    DATEPART(QUARTER, SOH.OrderDate) = (SELECT DATEPART(QUARTER, MAX(SOH.OrderDate)) FROM Sales.SalesOrderHeader AS SOH)
    AND YEAR(SOH.OrderDate) = (SELECT MAX(YEAR(SOH.OrderDate)) FROM Sales.SalesOrderHeader AS SOH)
GROUP BY
    PC.Name, YEAR(SOH.OrderDate) -- Agrupa los resultados por categoría de productos y año
ORDER BY
    YEAR(SOH.OrderDate); -- Ordena los resultados por año

