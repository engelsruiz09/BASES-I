
CREATE VIEW HUMANRESOURCES.VWEMPLOYEEHIREDATE AS 
SELECT P.FIRSTNAME, P.LASTNAME, E.HireDate
FROM HumanResources.Employee E
	INNER JOIN Person.Person P ON (E.BusinessEntityID = P.BusinessEntityID)

SELECT*
FROM HumanResources.VWEMPLOYEEHIREDATE

SELECT*
FROM [HumanResources].[vEmployeeDepartmentHistory] A
	INNER JOIN HumanResources.VWEMPLOYEEHIREDATE B ON (A.FirstName = B.FirstName)