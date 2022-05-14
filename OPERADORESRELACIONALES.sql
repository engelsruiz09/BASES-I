DECLARE @mivar int

SET @mivar= 5
print @mivar

SELECT*  --proyeccion
FROM Purchasing.PurchaseOrderHeader
WHERE Freight > 50---SELECCION 
----------------------------------------------------------------------
SELECT status,orderdate,shipdate,totaldue,Freight  --proyeccion
FROM Purchasing.PurchaseOrderHeader
WHERE Freight > 50---SELECCION 
----------------------------------------------------------------------
SELECT *
FROM PRODUCTION.PRODUCT

----------------------------------------------------------------------
SELECT NAME , COLOR,LISTPRICE
FROM PRODUCTION.PRODUCT
--WHERE LISTPRICE BETWEEN 25 AND 35
WHERE LISTPRICE >= 25 AND LISTPRICE <= 35

---------------------------------------------------------------------
--LISTAR LAS PERSONAS DONDE EL NOMBRE INICIE CON LA LETRA A (PENDIENTE EL TEMA DE CLIENTES)
SELECT*
FROM PERSON.PERSON
WHERE FIRSTNAME LIKE 'A%A%O'

----------------------------------------------------------------------
--MOSTRAR LOS PAISES QUE INICIEN CON U Y QUE INMEDIATAMENTE DESPUES SOLO TENGA UN CARACTER
SELECT SUBSTRING(NAME,1,11)PRIMER_CARACTER,NAME,LEN(NAME)
FROM PERSON.CountryRegion
WHERE SUBSTRING(NAME,1,1) = 'U' AND 
								LEN(NAME) = 2

-----------------------------------------------------------------------
--LISTAR LOS NOMBRES DE LOS VENDORS DONDE LA WS NO ESTE EN BLANCO.
--LISTAR LOS NOMBRES DE LOS VENDORS QUE SI TENGAN WS.
SELECT *
FROM PURCHASING.VENDOR 
WHERE PurchasingWebServiceURL IS NULL
AND MODIFIEDDATE < '2011-05-01'

SELECT *
FROM PURCHASING.VENDOR 
WHERE PurchasingWebServiceURL IS NULL
AND YEAR(MODIFIEDDATE) < 2012


--------------------------------------------------------------------
--LISTAR LOS NOMBRES DE LOS VENDORS DONDE LA ULTIMA FECHA DE MODIFICACION
--SEAN LOS MESES DE ABRIL O DICIEMBRE
SELECT *
FROM PURCHASING.VENDOR 
WHERE  MONTH(MODIFIEDDATE) IN (4,12)
AND NAME IN ('Cycling Master','International Trek Center')


------------------------------------------------------------------------
--OBTENER LOS PRODUCTOS DONDE EL NOMBRE INICIE CON P Y SU PRECIO UNITARIO
--COMPRENDIDO ENTRE 10 Y 100
SELECT *
FROM PRODUCTION.PRODUCT
WHERE NAME LIKE 'P%' AND LISTPRICE BETWEEN 10 AND 100
