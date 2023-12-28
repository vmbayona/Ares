-- Un query que permita identificar los productos más devueltos en el último mes, incluyendo información sobre los clientes y empleados asociados a las devoluciones
-- Este CTE (Common Table Expression) obtiene la fecha de la última orden del año 2013

WITH MaxMonth2013 AS (
    SELECT
        MAX(SOH.OrderDate) AS LastOrderDate
    FROM
        Sales.SalesOrderHeader AS SOH
    WHERE
        YEAR(SOH.OrderDate) = 2013
)

-- Este query obtiene todos los productos devueltos en el último mes de la fecha obtenida del CTE
SELECT
    Prod.Name AS NombreProducto, -- Nombre del producto
    COUNT(*) AS ConteoDevoluciones, -- Cantidad de devoluciones
    P.FirstName AS NombreCliente, -- Nombre del cliente
    P.LastName AS ApellidoCliente, -- Apellido del cliente
    E.FirstName AS NombreEmpleado, -- Nombre del empleado (vendedor)
    E.LastName AS ApellidoEmpleado, -- Apellido del empleado (vendedor)
    D.Name AS DepartmentName  -- Nombre del departamento
FROM
    Sales.SalesOrderHeader AS SOH
    JOIN (
        SELECT
            C.CustomerID AS CustomerID,
            P.FirstName AS FirstName,
            P.LastName AS LastName
        FROM
            Sales.Customer AS C
            JOIN Person.Person AS P
            ON C.PersonID = P.BusinessEntityID
    ) AS P
    ON SOH.CustomerID = P.CustomerID
    JOIN Sales.SalesOrderDetail AS SOD
    ON SOH.SalesOrderID = SOD.SalesOrderID
    JOIN Production.Product AS Prod
    ON SOD.ProductID = Prod.ProductID
    JOIN (
        SELECT
            E.BusinessEntityID,
            P.FirstName,
            P.LastName,
            EDH.DepartmentID  -- Agregamos el identificador del departamento
        FROM HumanResources.Employee AS E
        JOIN Person.Person AS P
        ON E.BusinessEntityID = P.BusinessEntityID
        JOIN HumanResources.EmployeeDepartmentHistory AS EDH
        ON E.BusinessEntityID = EDH.BusinessEntityID
    ) AS E
    ON SOH.SalesPersonID = E.BusinessEntityID
    JOIN HumanResources.Department AS D  -- Unimos con la tabla de departamentos
    ON E.DepartmentID = D.DepartmentID
WHERE
    SOH.OrderDate >= (
        SELECT DATEADD(MONTH, -1, LastOrderDate) FROM MaxMonth2013
    ) -- Usar el último mes obtenido del CTE
    AND SOH.OrderDate < (
        SELECT LastOrderDate FROM MaxMonth2013
    )
    AND SOH.Status = 5 -- Considerar solo las devoluciones (puede variar según la base de datos)
GROUP BY
    Prod.Name, P.FirstName, P.LastName, E.FirstName, E.LastName, D.Name
ORDER BY
    ConteoDevoluciones DESC;








