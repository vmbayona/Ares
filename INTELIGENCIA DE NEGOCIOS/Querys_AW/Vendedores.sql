SELECT 
    SP.BusinessEntityID AS VendedorID,
    P.FirstName AS Nombre,
    P.LastName AS Apellido
FROM 
    Sales.SalesPerson AS SP
JOIN 
    Person.Person AS P
ON 
    SP.BusinessEntityID = P.BusinessEntityID;
