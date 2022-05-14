--EXAMEN FINAL / CÉSAR ADRIAN SILVA PÉREZ / 1184519
---------------------------------------------------
---¿Cuál es el nombre del octavo producto que más se ha desechado (según sus ordenes de trabajo)?
SELECT TOP(8) P.Name, W.ScrappedQty
FROM Production.WorkOrder W
INNER JOIN Production.Product P ON W.ProductID = P.ProductID
ORDER BY W.ScrappedQty DESC
---MALA, RESPUESTA: STEM

---¿Cuántas ventas se han realizado, donde su detalle es mayor a 10 diferentes productos?
SELECT SalesOrderID, COUNT(1) AS TOTAL
FROM Sales.SalesOrderDetail SOD
GROUP BY SalesOrderID
ORDER BY TOTAL DESC 
---RESPUESTA: EXISTEN 1810 PEDIDOS CON UN TOTAL MAYOR A 10 PRODUCTOS DISTINTOS

---¿A cuántos productos nunca se les ha realizado orden de trabajo?
SELECT COUNT(1) AS TOTAL
FROM Production.WorkOrder W
INNER JOIN Production.Product P ON W.ProductID = P.ProductID
WHERE W.OrderQty = 0
---MALA, RESPUESTA: 266

---¿En que año existieron menos cambios de sueldo?
SELECT YEAR(EPH.RateChangeDate) AS AÑO, COUNT(1) AS TOTAL_CAMBIOS
FROM HumanResources.EmployeePayHistory EPH
GROUP BY YEAR(EPH.RateChangeDate)
ORDER BY TOTAL_CAMBIOS ASC
---RESPUESTA: 2006

---¿Cuál es el nombre del peor territorio en cuanto a ventas (según cantidad y no monto) y que incluyan algún producto de la subcatería = 'Helmets'?
Select ST.Name, COUNT(*) AS CANTIDAD
FROM SALES.SalesOrderHeader SOH
INNER JOIN SALES.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN SALES.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID
INNER JOIN Production.Product P ON SOD.ProductID = P.ProductID
INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductCategoryID
WHERE PS.Name = 'Helmets'
GROUP BY ST.Name
ORDER BY CANTIDAD ASC
---RESPUESTA: NORTHEAST
---ESTA ES LA QUE TE COMENTE QUE EL INGE ME DIO LA RESPUESTA POR TENER TODO EL QUERY BUENO