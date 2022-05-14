--SCRIPT -----------FUNCIONES DE AGREGACIONES
---------------------------------------------------------
BEGIN 
	--CODIGO
	--DECLARAR VARIABLES
	--UTILIZAR VARIABLES

	--UTILIZAR QUERYS PARA EJECUTAR
	DECLARE @CANTIDAD INT
	SELECT @CANTIDAD = COUNT(1) 
	FROM SALES.SalesOrderDetail
	-- IF 
	DECLARE @DIA INT
	SET @DIA = DATEPART(DW,GETDATE())
	IF(@DIA = 3) PRINT 'MARTES'
	PRINT @DIA
END
----------------------------------------------------------
--QUERY
--CASE : PROYECCION Y EN LA SELECCION
--NO RECONOCE UN IF
SELECT WorkOrderID,OrderQty,
	CASE WHEN OrderQty < 10 THEN 'PEQUE�A'
	WHEN OrderQty >= 10 THEN 'GRANDE'
	ELSE 'TBD' END AS TIPO
FROM PRODUCTION.WorkOrder


----------------------------------------------------------

--AGREGACION
--CONTEO
--PROMEDIO
--MULTIPLICACION/DIVISION
--MAXIMO / MINIMO

--OBTENER EL NUMERO DE FILAS DE UNA TABLA
--OBTENER EL MAXIMO Y MINIMO PRECIO UNITARIO DE LOS PRODUCTOS
--OBTENER LA SUMA DE LOS MONTOS TOTALES DE LAS ORDENES
--OBTENER EL PROMEDIO DEL PESO DE LAS ORDENES

SELECT*
FROM SALES.SalesOrderDetail
-------------------------------------------------------------------------

SELECT COUNT(1) AS CANTIDAD, COUNT(*) AS CANTIDAD2,
	   COUNT(DISTINCT SalesOrderID)AS CANTIDAD3,COUNT (DISTINCT SalesOrderDetailID) AS CANTIDAD4
FROM SALES.SalesOrderDetail

WHERE ProductID < 800

SELECT*
FROM SALES.SalesOrderDetail

---------------------------------------------------------------------

SELECT *
FROM Production.Product
ORDER BY ListPrice ASC --DESC


SELECT MAX(LISTPRICE)AS MAXIMO,MIN(LISTPRICE) AS MINIMO
FROM Production.Product



------------------------------------------------------------------------
SELECT SUM(TotalDue) AS TOTAL, COUNT(1) AS CANTIDAD, AVG(TotalDue) as PROM,
	SUM(TotalDue)/COUNT(1) AS PROM2

	SELECT RevisionNumber + STATUS AS NUEVA
FROM SALES.SalesOrderHeader


------------------------------------------------------------------------
						--AGRUPACION Y ORDENAMIENTO
						--GROUP BY
						--HAVING
SELECT DISTINCT STATUS
FROM sales.SalesOrderHeader

--1 = CONFIRMADO
--5 = CANCELADO

--NO LA ESTAS UTILIZANDO EN UNA FUNCION DE AGREGACION
--NO EXISTE DENTRO DE LA CLAUSULA DE AGRUPACION (GROUP BY)
SELECT Status, SUM(TotalDue) AS TOTAL, COUNT(1) AS CANTIDAD, AVG(TotalDue) as PROM
FROM SALES.SalesOrderHeader
GROUP BY Status


SELECT OrderDate, SUM(TotalDue) AS TOTAL, COUNT(1) AS CANTIDAD, AVG(TotalDue) as PROM
FROM SALES.SalesOrderHeader
GROUP BY OrderDate
ORDER BY OrderDate


SELECT DISTINCT ACCOUNTNUMBER, SUBSTRING(ACCOUNTNUMBER,4,4)AS TIPO
FROM SALES.SalesOrderHeader

SELECT SUBSTRING(ACCOUNTNUMBER,4,4)AS TIPO, SUM(TotalDue) AS TOTAL, COUNT(1) AS CANTIDAD, AVG(TotalDue) as PROM
FROM SALES.SalesOrderHeader
GROUP BY SUBSTRING(ACCOUNTNUMBER,4,4)
ORDER BY SUBSTRING(ACCOUNTNUMBER,4,4)




SELECT YEAR(OrderDate) AS A�O,MONTH(ORDERDATE) AS MES, SUM(TotalDue) AS TOTAL, COUNT(1) AS CANTIDAD, AVG(TotalDue) as PROM
FROM SALES.SalesOrderHeader
GROUP BY YEAR(OrderDate),MONTH(ORDERDATE)
ORDER BY 1 ASC, 2 DESC

--OBTENER LA CANTIDAD DE VENTAS POR (AGRUPADO) A�O 