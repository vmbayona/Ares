
-- Un query que permita calcular el tiempo promedio de env�o por categor�a de productos en el �ltimo trimestre, incluyendo informaci�n sobre clientes, empleados y proveedores.
-- Este CTE (Common Table Expression) calcula el tiempo promedio de env�o para cada categor�a de productos en el trimestre y a�o m�s reciente

WITH TiempoPromedioEnvio AS (
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
)

-- Este query une los resultados del CTE con informaci�n adicional de clientes, vendedores y proveedores
SELECT
    TPE.CategoriaProducto,
    TPE.A�o,
    TPE.TiempoPromedioEnvioDias,
    P.FirstName AS NombreCliente, -- Nombre del cliente
    P.LastName AS ApellidoCliente, -- Apellido del cliente
    PS.FirstName AS NombreVendedor, -- Nombre del vendedor
    PS.LastName AS ApellidoVendedor, -- Apellido del vendedor
    V.Name AS NombreProveedor -- Nombre del proveedor
FROM
    TiempoPromedioEnvio AS TPE
JOIN
    Sales.SalesOrderHeader AS SOH
ON
    TPE.A�o = YEAR(SOH.OrderDate) -- Realiza una uni�n con las �rdenes de ventas que coinciden con el a�o del CTE
JOIN
    Sales.Customer AS C
ON
    SOH.CustomerID = C.CustomerID -- Realiza una uni�n con la tabla de clientes basada en el ID del cliente
JOIN
    Person.Person AS P
ON
    C.PersonID = P.BusinessEntityID -- Realiza una uni�n con la tabla de personas basada en el ID de entidad comercial del cliente
LEFT JOIN
    Sales.SalesPerson AS SP
ON
    SOH.SalesPersonID = SP.BusinessEntityID -- Realiza una uni�n con los vendedores si est�n disponibles
LEFT JOIN
    Person.Person AS PS
ON
    SP.BusinessEntityID = PS.BusinessEntityID -- Realiza una uni�n con las personas que son vendedores
LEFT JOIN
    Purchasing.Vendor AS V
ON
    TPE.A�o = YEAR(V.ModifiedDate) -- Realiza una uni�n con los proveedores si est�n disponibles
ORDER BY
    TPE.A�o, TPE.CategoriaProducto; -- Ordena los resultados por a�o y categor�a de producto

