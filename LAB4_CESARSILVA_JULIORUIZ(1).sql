--LAB 4, BASES DE DATOS
--CÉSAR SILVA / 1184519
--JULIO RUIZ / 1284719
--BASE UTILIZADA NORTHWND
--====================================================================================================---------------
--Mostrar el contacto, código de cliente y compañía de todos los clientes que viven en London.
SELECT Customers.ContactName,Customers.CustomerID,CUSTOMERS.CompanyName,Customers.City
	FROM Customers
WHERE City = 'London'

--====================================================================================================---------------
--La cantidad de productos descontinuados
SELECT COUNT(Products.Discontinued) AS CANTIDAD_PRODUCTO
	FROM Products
WHERE Discontinued = 0

--====================================================================================================---------------
--Mostrar un listado de nombre de clientes que no tengan pedidos 
SELECT DISTINCT C.ContactName, C.Country
FROM Customers C
    LEFT OUTER JOIN Orders O on C.CustomerID = O.CustomerID
where O.CustomerID IS NULL
Order by C.contactName

--====================================================================================================---------------
--Mostrar el promedio de edades por cada titulo de empleado.
SELECT DISTINCT COUNT(E.Title) AS CANTIDAD,E.Title, ROUND(AVG(YEAR(GETDATE()) - YEAR(E.BIRTHDATE)),0) AS prom_Edades
FROM EMPLOYEES E 
GROUP BY E.Title

--====================================================================================================---------------
--Mostrar la cantidad de clientes por pais que no hayan realizado pedido alguno 
SELECT DISTINCT C.Country,COUNT(*) AS NO_PERSONAS_NO_PEDIDOS
FROM Customers C
    LEFT OUTER JOIN Orders O on C.CustomerID = O.CustomerID
where O.CustomerID IS NULL
GROUP BY C.Country

--====================================================================================================---------------
--Mostrar los nombres y apellidos de los empleados,combinando ambas columnas con formato: "apellido, nombre". Agregar la edad de cada empleado
SELECT Employees.LastName + ' ' +Employees.FirstName AS NOMBRE,YEAR(GETDATE()) - YEAR(Employees.BirthDate) AS AGE
FROM Employees 

--====================================================================================================---------------
--Mostrar nombre y precio unitario de los productos que sean seafood
SELECT P.ProductName, P.UnitPrice, P.CategoryID
	FROM Products P
	INNER JOIN	 Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Seafood' AND C.CategoryID = 8

--====================================================================================================---------------
--Mostrar todos los proveedores donde el contacto sea un "marketing mangaers/sales presentative" y que se pueda contactar por fax
SELECT*
	FROM Suppliers
WHERE Suppliers.Fax IS NOT NULL AND (Suppliers.ContactTitle = 'Marketing Manager' OR Suppliers.ContactTitle = 'Sales Representative')

--====================================================================================================---------------
--Mostrar el nombre y dirección de los clientes que han realizado pedidos con "Federal Shipping"
SELECT C.ContactName,C.Address,O.ShipVia
    FROM Orders O 
    INNER JOIN    Customers C ON C.CustomerID = O.CustomerID 
        INNER JOIN Shippers S ON  S.ShipperID =  O.ShipVia
WHERE O.ShipVia = '3' OR S.CompanyName = 'Federal Shipping'

--====================================================================================================---------------
--Mostrar el nombre, direccion, telefono, y país de los proveedores donde la direccion contenga la palabra "rue", ordenado por pais y nombre
SELECT  S.Country AS PAIS, S.Contactname as NOMBRE, S.Address AS DIRECCION, S.Phone AS TELEFONO
FROM Suppliers S
WHERE S.Address LIKE '%rue%'
ORDER BY NOMBRE

--====================================================================================================---------------
--Mostrar todos los transportistas, donde se incluya la suma total de fletes realizados por órdenes, redondeado al número entero más cercano.
SELECT DISTINCT S.ShipperID AS TRANSPORTISTAS, COUNT(O.ShipVia) AS TOTAL_ORDENES, ROUND(SUM(O.Freight),0) AS FLETES_TOTALES 
From Shippers S
INNER JOIN Orders O ON S.ShipperID = O.ShipVia
GROUP BY S.ShipperID
ORDER BY S.ShipperID

--====================================================================================================---------------
--Mostrar una lista de códigos de clientes, que han realizado pedidos con fecha requerida entre 1 de enero de 1997 y 1 de enero de 1998, y que su "freith" este por abajo de 100 unidades.
SELECT O.CustomerID As CodeCliente, RequiredDate As fecha_Pedido,O.Freight
    FROM Orders O
WHERE (MONTH(O.RequiredDate) >= 1 AND YEAR(O.RequiredDate) = 1997 AND DAY(O.RequiredDate) >= 1 OR MONTH(O.RequiredDate) = 1 AND YEAR(O.RequiredDate) = 1998 AND DAY(O.RequiredDate) = 1)
    AND O.Freight < 100
Order BY fecha_Pedido

--====================================================================================================---------------
--Mostrar las cantidades totales ordenadas por cada código de producto (del detalle de ordenes).
SELECT DISTINCT OD.ProductID, SUM(OD.Quantity) AS TOTAL_ORDENES
FROM [Order Details] OD
GROUP BY OD.ProductID
ORDER BY OD.ProductID ASC
