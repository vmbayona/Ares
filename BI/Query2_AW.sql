--  Un query que permita calcular el margen de beneficio de cada producto en el último año

-- Subconsulta para encontrar el último año disponible en Sales.SalesOrderHeader
WITH UltimoAno AS (
    SELECT MAX(YEAR(OrderDate)) AS UltimoAno
    FROM Sales.SalesOrderHeader
)

-- Selección de datos relacionados con el último año disponible
SELECT
    YEAR(SOH.OrderDate) AS AnoDeOrden, -- Año de la orden
    P.Name AS NombreDelProducto, -- Nombre del producto
    SUM(SOD.LineTotal) - SUM(SOD.UnitPrice) AS MargenDeBeneficio -- Cálculo del margen de beneficio
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
WHERE YEAR(SOH.OrderDate) = (SELECT UltimoAno FROM UltimoAno) -- Filtrar por el último año
GROUP BY
    YEAR(SOH.OrderDate), P.Name
ORDER BY
    AnoDeOrden DESC; -- Ordenar los resultados por el año de la orden en orden descendente
