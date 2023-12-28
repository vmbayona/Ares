SELECT 
    SP.BusinessEntityID AS VendedorID,
    P.FirstName AS Nombre,
    P.LastName AS Apellido,
    CONCAT(
        LOWER(LEFT(P.FirstName, 1)), 
        LOWER(P.LastName), 
        RIGHT(CAST(SP.BusinessEntityID AS VARCHAR), 2),
        '@adventureworks.com'
    ) AS CorreoElectronico
FROM 
    Sales.SalesPerson AS SP
JOIN 
    Person.Person AS P
ON 
    SP.BusinessEntityID = P.BusinessEntityID
ORDER BY 
    VendedorID ASC;

