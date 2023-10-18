SELECT 
    E.BusinessEntityID,
    P.FirstName,
    P.LastName,
    D.Name AS DepartmentName
FROM HumanResources.Employee AS E
JOIN Person.Person AS P
ON E.BusinessEntityID = P.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory AS EDH
ON E.BusinessEntityID = EDH.BusinessEntityID
JOIN HumanResources.Department AS D
ON EDH.DepartmentID = D.DepartmentID;
