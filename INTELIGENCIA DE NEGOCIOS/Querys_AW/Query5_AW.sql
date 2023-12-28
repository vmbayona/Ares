-- Un query que permita analizar el desempeño de los productos en función de las revisiones de los clientes, mostrando información sobre empleados y clientes asociados a las revisiones

-- Subquery (P) para obtener el promedio de calificación y cantidad de revisiones por producto
SELECT
    P.NombreProducto, -- Nombre del producto
    P.PromedioCalificacion, -- Promedio de calificación
    P.CantidadRevisiones, -- Cantidad de revisiones
    C.NombreCliente, -- Nombre del cliente (si existe)
    C.ApellidoCliente, -- Apellido del cliente (si existe)
    E.NombreEmpleado, -- Nombre del empleado (si existe)
    E.ApellidoEmpleado -- Apellido del empleado (si existe)
FROM (
    -- Subquery (P) para calcular el promedio de calificación y cantidad de revisiones por producto
    SELECT
        P.ProductID AS IDProducto, -- ID del producto
        P.Name AS NombreProducto, -- Nombre del producto
        AVG(PR.Rating) AS PromedioCalificacion, -- Promedio de calificación
        COUNT(PR.ProductReviewID) AS CantidadRevisiones -- Cantidad de revisiones
    FROM
        Production.Product AS P
    LEFT JOIN
        Production.ProductReview AS PR
    ON
        P.ProductID = PR.ProductID -- Unión con la tabla de revisiones de productos
    GROUP BY
        P.ProductID, P.Name
) AS P
LEFT JOIN (
    -- Subquery (C) para obtener información del cliente (si existe)
    SELECT 
        C.CustomerID AS IDCliente, -- ID del cliente
        P.FirstName AS NombreCliente, -- Nombre del cliente
        P.LastName AS ApellidoCliente -- Apellido del cliente
    FROM 
        Sales.Customer AS C
    JOIN 
        Person.Person AS P
    ON 
        C.PersonID = P.BusinessEntityID -- Unión con la tabla de clientes
) AS C
ON
    P.IDProducto = C.IDCliente -- Unión con el ID del cliente
LEFT JOIN (
    -- Subquery (E) para obtener información del empleado (si existe)
    SELECT 
        E.BusinessEntityID AS IDEmpleado, -- ID del empleado
        P.FirstName AS NombreEmpleado, -- Nombre del empleado
        P.LastName AS ApellidoEmpleado -- Apellido del empleado
    FROM 
        HumanResources.Employee AS E
    JOIN 
        Person.Person AS P
    ON 
        E.BusinessEntityID = P.BusinessEntityID -- Unión con la tabla de empleados
) AS E
ON
    P.IDProducto = E.IDEmpleado; -- Unión con el ID del empleado

