
-- Un query que permita calcular el tiempo promedio de envío por categoría de productos en el último trimestre, incluyendo información sobre clientes, empleados y proveedores.
-- Este CTE (Common Table Expression) calcula el tiempo promedio de envío para cada categoría de productos en el trimestre y año más reciente

WITH TiempoPromedioEnvio AS (
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
)

-- Este query une los resultados del CTE con información adicional de clientes, vendedores y proveedores
SELECT
    TPE.CategoriaProducto,
    TPE.Año,
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
    TPE.Año = YEAR(SOH.OrderDate) -- Realiza una unión con las órdenes de ventas que coinciden con el año del CTE
JOIN
    Sales.Customer AS C
ON
    SOH.CustomerID = C.CustomerID -- Realiza una unión con la tabla de clientes basada en el ID del cliente
JOIN
    Person.Person AS P
ON
    C.PersonID = P.BusinessEntityID -- Realiza una unión con la tabla de personas basada en el ID de entidad comercial del cliente
LEFT JOIN
    Sales.SalesPerson AS SP
ON
    SOH.SalesPersonID = SP.BusinessEntityID -- Realiza una unión con los vendedores si están disponibles
LEFT JOIN
    Person.Person AS PS
ON
    SP.BusinessEntityID = PS.BusinessEntityID -- Realiza una unión con las personas que son vendedores
LEFT JOIN
    Purchasing.Vendor AS V
ON
    TPE.Año = YEAR(V.ModifiedDate) -- Realiza una unión con los proveedores si están disponibles
ORDER BY
    TPE.Año, TPE.CategoriaProducto; -- Ordena los resultados por año y categoría de producto

