--La cantidad de diferentes ciudades dentro de los proveedores --northwind
Select DISTINCT S.Country, COUNT(*) AS TOTAL
from Suppliers S
GROUP BY S.Country

--De los productos que si se han comprado y que son de categoria 6 o 7 , cuál de ellos es el que menos se ha comprado , en cuanto a cantidad ( columna quantity)
Select *
from Products P
where (P.CategoryID = 7 OR P.CategoryID = 6)---P.UnitsOnOrder > 0 and 

--Cuál es el mínimo digito que si aparece, en los teléfonos de los proveedores tomando en cuenta únicamente el último carácter de dicha columna
SELECT S.Phone
FROM Suppliers S
WHERE S.PHONE LIKE '%0'

--El nombre del empleado que tiene menos territorios asignados
SELECT DISTINCT E.FirstName, COUNT(*) AS TOTAL
FROM Employees E
INNER JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
GROUP BY E.FirstName

--Cuánto es el promedio en dias , de la diferencia entre las fechas de contratación y fecha de nacimiento de los empleados, siempre y cuando los territorios asignados al empleado sean más de 7
SELECT DISTINCT E.FirstName, E.BirthDate, E.HireDate
FROM Employees E
WHERE E.FirstName = 'Robert'---EN EXCEL VER EL PROMEDIO ENTRE FECHAS