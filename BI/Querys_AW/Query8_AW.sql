-- Obtener el �ltimo trimestre disponible en funci�n de la �ltima fecha registrada en la base de datos
DECLARE @UltimaFecha DATETIME;
SELECT @UltimaFecha = MAX(OrderDate) FROM Sales.SalesOrderHeader;

-- Obtener informaci�n de los clientes, productos y total de compras
WITH ComprasUltimoTrimestre AS (
    SELECT
        c.CustomerID,
        c.PersonID,
        od.ProductID,
        SUM(od.LineTotal) AS TotalCompras
    FROM
        Sales.SalesOrderHeader AS oh
    INNER JOIN
        Sales.SalesOrderDetail AS od
    ON
        oh.SalesOrderID = od.SalesOrderID
    INNER JOIN
        Sales.Customer AS c
    ON
        oh.CustomerID = c.CustomerID
    WHERE
        oh.OrderDate >= DATEADD(QUARTER, DATEDIFF(QUARTER, 0, @UltimaFecha) - 1, 0) -- Primer d�a del �ltimo trimestre
        AND oh.OrderDate < DATEADD(QUARTER, DATEDIFF(QUARTER, 0, @UltimaFecha), 0) -- Primer d�a del primer trimestre
    GROUP BY
        c.CustomerID, c.PersonID, od.ProductID
)

-- Obtener informaci�n de los clientes, productos y total de compras
SELECT
    p.FirstName AS NombreCliente,
    p.LastName AS ApellidoCliente,
    pr.Name AS NombreProducto,
    cu.TotalCompras
FROM
    ComprasUltimoTrimestre AS cu
JOIN
    Person.Person AS p
ON
    cu.PersonID = p.BusinessEntityID
JOIN
    Production.Product AS pr
ON
    cu.ProductID = pr.ProductID
ORDER BY
    cu.TotalCompras DESC;

