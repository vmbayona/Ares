--  Un query que permita calcular el margen de beneficio de cada producto en el �ltimo a�o

-- Subconsulta para encontrar el �ltimo a�o disponible en Sales.SalesOrderHeader
WITH UltimoAno AS (
    SELECT MAX(YEAR(OrderDate)) AS UltimoAno
    FROM Sales.SalesOrderHeader
)

-- Selecci�n de datos relacionados con el �ltimo a�o disponible
SELECT
    YEAR(SOH.OrderDate) AS AnoDeOrden, -- A�o de la orden
    P.Name AS NombreDelProducto, -- Nombre del producto
    SUM(SOD.LineTotal) - SUM(SOD.UnitPrice) AS MargenDeBeneficio -- C�lculo del margen de beneficio
FROM
    Production.Product AS P
JOIN
    Sales.SalesOrderDetail AS SOD
ON
    P.ProductID = SOD.ProductID
JOIN
    Sales.SalesOrderHeader AS SOH
ON
    SOD.SalesOrderID = SOH.SalesOrderID
WHERE YEAR(SOH.OrderDate) = (SELECT UltimoAno FROM UltimoAno) -- Filtrar por el �ltimo a�o
GROUP BY
    YEAR(SOH.OrderDate), P.Name
ORDER BY
    AnoDeOrden DESC; -- Ordenar los resultados por el a�o de la orden en orden descendente
