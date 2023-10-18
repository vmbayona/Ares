SELECT 
    C.CustomerID,
    P.FirstName AS Nombre,
    P.LastName AS Apellido
FROM 
    Sales.Customer AS C
JOIN 
    Person.Person AS P
ON 
    C.PersonID = P.BusinessEntityID;
