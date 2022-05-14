

--todo los diferentes tipos de contactos 
--cuantos contactocs de cada tipo.
-- todos los contactos (nombrea y apellidos) que sean "Purchasing Manager"
------------------------------------------------------------------------------------------------

SELECT DISTINCT CT.Name
FROM PERSON.BusinessEntityContact BEC
			INNER JOIN PERSON.BusinessEntity BE ON BEC.BusinessEntityID = BE.BusinessEntityID
			INNER JOIN PERSON.ContactType CT ON BEC.ContactTypeID = CT.ContactTypeID
ORDER BY CT.NAME

-------------------------------------------------------------------------------------------------
SELECT CT.Name,COUNT(*) AS CANTIDAD
FROM PERSON.BusinessEntityContact BEC
			INNER JOIN PERSON.BusinessEntity BE ON BEC.BusinessEntityID = BE.BusinessEntityID
			INNER JOIN PERSON.ContactType CT ON BEC.ContactTypeID = CT.ContactTypeID
GROUP BY CT.NAME
ORDER BY CT.NAME
--------------------------------------------------------------------------------------------------
---------INVESTIGAR ->ROWGUID (MD5)
SELECT BEC.BusinessEntityID,COUNT(*) AS CANTIDAD
FROM PERSON.BusinessEntityContact BEC
			INNER JOIN PERSON.BusinessEntity BE ON BEC.BusinessEntityID = BE.BusinessEntityID
			INNER JOIN PERSON.ContactType CT ON BEC.ContactTypeID = CT.ContactTypeID
GROUP BY BEC.BusinessEntityID

------------------------------------------------------------------------------------------------
SELECT P.FirstName,P.LastName --PROYECCION
FROM PERSON.BusinessEntityContact BEC
			INNER JOIN PERSON.BusinessEntity BE ON BEC.BusinessEntityID = BE.BusinessEntityID
			INNER JOIN PERSON.ContactType CT ON BEC.ContactTypeID = CT.ContactTypeID
			INNER JOIN PERSON.PERSON P ON BEC.PersonID = P.BusinessEntityID
WHERE CT.NAME = 'PURCHASING MANAGER'--SELECCION (FILTRO/CONDICION/REGLA)
ORDER BY 1,2 --POSICION DE LA COLUMNA

--JOIN : TABLA1 CON LA TABLA2
			--LLAVE FORANEA TABLA1 CON LA LLAVE PRIMARIA DE LA TABLA 2

---------------------------------------------------------------------------------------------------








--CUANTOS CONTACTOS DE CADA TIPO
--TIPOS DE CONTACTOS QUE TENGAN MAS DE 50.

SELECT ct.Name,COUNT(*) AS CANTIDAD
FROM PERSON.BusinessEntityContact BEC
			INNER JOIN PERSON.BusinessEntity BE ON BEC.BusinessEntityID = BE.BusinessEntityID
			INNER JOIN PERSON.ContactType CT ON BEC.ContactTypeID = CT.ContactTypeID
GROUP BY ct.Name
HAVING COUNT(*) >50


--SUBQUERY

(
SELECT CT.NAME,SUM(BEC.PERSONID) AS CANTIDAD
FROM PERSON.BusinessEntityContact BEC
			INNER JOIN PERSON.BusinessEntity BE ON BEC.BusinessEntityID=BE.BusinessEntityID
			INNER JOIN PERSON.ContactType CT ON BEC.ContactTypeID= CT.ContactTypeID
GROUP BY CT.NAME) b ON (a.NAME = b.NAME)
WHERE a.CANTIDAD >50

------------------------------------------------------------



--todos los productos con ListPrice mayor a 1000 y que se hayan vendido por lo menos una vez.
--mostrar el nombre , el costo y el precio
--ONTENER LA GANANCIA POR PRODUCTO
SELECT DISTINCT P.Name, P.ListPrice, P.StandardCost
FROM SALES.SalesOrderDetail SOD
		INNER JOIN Production.Product P ON SOD.ProductID = P.ProductID
WHERE ListPrice > 1000
ORDER BY 1

SELECT P.ProductID,P.Name, P.ListPrice, P.StandardCost
FROM Production.Product P
WHERE ListPrice > 1000 AND EXISTS
	(
		SELECT *
		FROM SALES.SalesOrderDetail SOD 
		WHERE SOD.ProductID = P.ProductID
	)
-------------------------------------------
SELECT P.ProductID,P.Name, P.ListPrice, P.StandardCost
FROM Production.Product P
WHERE ListPrice > 1000 AND NOT EXISTS
	(
		SELECT *
		FROM SALES.SalesOrderDetail SOD 
		WHERE SOD.ProductID = P.ProductID
	)

---------------------------------------------
SELECT *
FROM Production.Product
WHERE (ListPrice > 1000 OR 
		COLOR = 'RED') AND 
		NAME LIKE '%Frame%'