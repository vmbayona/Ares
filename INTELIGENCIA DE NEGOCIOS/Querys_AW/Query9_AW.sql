-- Obtener el último año máximo
SELECT MAX(YEAR(SOH.OrderDate)) AS UltimoAno
FROM Sales.SalesOrderHeader AS SOH;

-- Obtener el nombre del producto, el nombre y apellido del cliente, el nombre del territorio y las ventas totales para el último año máximo
SELECT 
    P.FirstName AS NombreCliente,
    P.LastName AS ApellidoCliente,
    ST.Name AS NombreTerritorio,
    PR.Name AS NombreProducto,
    SUM(SOD.LineTotal) AS VentasTotales
FROM 
    Sales.SalesOrderHeader AS SOH
JOIN
    Sales.SalesOrderDetail AS SOD
ON 
    SOH.SalesOrderID = SOD.SalesOrderID
JOIN
    Sales.SalesTerritory AS ST
ON
    SOH.TerritoryID = ST.TerritoryID
JOIN
    Sales.Customer AS C
ON
    SOH.CustomerID = C.CustomerID
JOIN
    Person.Person AS P
ON 
    C.PersonID = P.BusinessEntityID
JOIN
    Production.Product AS PR
ON
    SOD.ProductID = PR.ProductID
WHERE 
    YEAR(SOH.OrderDate) = (SELECT MAX(YEAR(SOH.OrderDate)) FROM Sales.SalesOrderHeader AS SOH)
GROUP BY 
    P.FirstName,
    P.LastName,
    ST.Name,
    PR.Name;





