--==================================================================================================================================================
--===============================================ejemplo de lab dml=================================================================================
---Monto y cantidad de ventas realizadas por territorio, que incluyan algún
---producto de la subcategoría “Wheels”
Select ST.Name, COUNT(*) AS CANTIDAD, SUM(SOH.TotalDue) AS MONTO
	FROM SALES.SalesOrderHeader SOH
		INNER JOIN SALES.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
			INNER JOIN SALES.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID
				INNER JOIN Production.Product P ON SOD.ProductID = P.ProductID
					INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductCategoryID
WHERE PS.Name = 'WHEELS'
GROUP BY ST.Name
ORDER BY ST.Name



--=============================================================================================================================================================
--¿Cuál es el nombre del peor territorio en cuanto a ventas ( según cantidad y no monto) y que incluyan algún producto de la subcatería = 'Helmets'?

SELECT *
FROM SALES.SalesTerritory --TERRITORYID
SELECT *
FROM SALES.SalesOrderHeader --SALESORDERID  , TERRITORYID
SELECT *
FROM SALES.SalesOrderDetail --SALESORDERID  ,    PRODUCTID 
SELECT *
FROM Production.ProductSubcategory -- PRODUCTSUBCATEGORYID
SELECT *
FROM Production.Product --PRODUCTID  , PRODUCTSUBCATEGORYID
------------------------------------------
SELECT ST.NAME, COUNT(*) AS CANTIDAD
FROM SALES.SalesOrderHeader SOH 
	INNER JOIN SALES.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	INNER JOIN SALES.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID
	INNER JOIN Production.Product P ON SOD.ProductID = P.ProductID
	INNER JOIN Production.ProductSubcategory PSC ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE PSC.NAME = 'Helmets'
GROUP BY ST.NAME
--ORDER BY CANTIDAD ASC

--=============================================================================================================================================================
--¿A cuántos productos nunca se les ha realizado orden de trabajo?

SELECT*
FROM Production.Product --PRODUCTID
SELECT*
FROM Production.ProductInventory --PRODUCTID
SELECT*
FROM Production.ProductCategory
SELECT*
FROM Production.WorkOrder
SELECT*
FROM SALES.SalesOrderDetail
SELECT*
FROM Production.WorkOrderRouting
SELECT*
FROM SALES.SalesOrderHeaderSalesReason
-----------------------------------
Select Production.Product.ProductID
FROM Production.Product
LEFT OUTER JOIN Production.WorkOrder ON Production.Product.ProductID = Production.WorkOrder.ProductID
Where Production.WorkOrder.ProductID IS NULL

--=============================================================================================================================================================
--¿Cuál es el nombre del octavo producto que más se ha desechado ( según sus ordenes de trabajo) ?

SELECT*
FROM SALES.SalesOrderHeader
SELECT*
FROM Sales.SalesOrderDetail--ORDERQTY
SELECT*
FROM Production.Product
SELECT*
FROM Production.WorkOrder --SCRAPREASONID , SCRAPPEDQTY
SELECT*
FROM Production.ScrapReason --SCRAPREASONID 
-----------------------------------------
SELECT TOP(8) P.NAME,WO.ScrappedQty
FROM Production.Product P
	INNER JOIN Production.WorkOrder WO ON P.ProductID = WO.ProductID
	INNER JOIN SALES.SalesOrderDetail SOD ON WO.OrderQty = SOD.OrderQty
WHERE ScrappedQty != 0
ORDER BY WO.ScrappedQty ASC


--==============================================================================================================================================================
--¿En que año existieron menos cambios de sueldo ?

SELECT*
FROM HumanResources.EmployeePayHistory --RATECHANGEDATE
-------------------------------------------------------------
SELECT YEAR(EPH.RateChangeDate) AS AÑO, COUNT(1) AS CANTIDAD_DE_CAMBIOS_DE_SUELDO
FROM HumanResources.EmployeePayHistory EPH
GROUP BY YEAR(EPH.RateChangeDate)
ORDER BY CANTIDAD_DE_CAMBIOS_DE_SUELDO ASC

--===============================================================================================================================================================
--¿Cuántas ventas se han realizado, donde su detalle es mayor a 10 diferentes productos?

SELECT* 
FROM SALES.SalesOrderDetail 
--------------------------------------
SELECT SOD.SalesOrderID,COUNT(SOD.SalesOrderID) AS TOTAL
FROM Sales.SalesOrderDetail SOD

GROUP BY SalesOrderID
ORDER BY TOTAL DESC  -->1810 SEGUN EL TOTAL DE CADA SALESORDERID




--====================================================EJERCICIOS SACADOS DE INTERNET PARA REPASAR ADVENTURE WORKS==================================================================================

--Mostrar a todos los empleados que se encuentran en el departamento de manufactura y de aseguramiento de la calidad.

SELECT*
FROM HumanResources.Employee --BUSINESSENTITYID,  JOBTITLE
SELECT*
FROM HumanResources.EmployeeDepartmentHistory -- BUSINESSENTITYID , DEPARTMENTID
SELECT*
FROM HumanResources.Department -- -> NAME ->PRODUCTION            , DEPARTMENTID
							   -- -> NAME ->QUALITY ASSURANCE 
---------------------------------------------
SELECT E.BusinessEntityID, D.NAME
FROM HumanResources.Employee E
	INNER JOIN HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
	INNER JOIN HumanResources.Department D ON EDH.DepartmentID = D.DepartmentID 
--AND EDH.EndDate IS NULL
AND D.NAME IN ('Quality Assurance','Production')



--Indicar el listado de los empleados del sexo masculino y que son solteros
SELECT*
FROM HumanResources.Employee --MARITALSTATUS , GENDER

SELECT E.MaritalStatus,E.Gender
FROM HumanResources.Employee E
WHERE MaritalStatus = 'S' AND Gender = 'M'

--Empleados cuyo apellido sea con la letra “S”
SELECT*
FROM PERSON.Person --LASTNAME , BUSSINESSENTITYID
SELECT*
FROM HumanResources.Employee --BUSSINESSENTITYID
---------------------------------
SELECT P.LastName
FROM Person.Person P
	INNER JOIN HumanResources.Employee E ON P.BusinessEntityID = E.BusinessEntityID
WHERE LastName LIKE 'S%'



--Los empleados que son del estado de Florida
SELECT*
FROM HumanResources.Employee --BUSINESSENTITYID
SELECT*
FROM PERSON.Person --BUSINESSENTITYID
SELECT*
FROM Person.CountryRegion --COUNTRYREGIONCODE
SELECT*
FROM PERSON.StateProvince --COUNTRYREGIONCODE ,STATEPROVINCEID
SELECT*
FROM Person.BusinessEntityAddress --BUSINESSENTITYID ,ADDRESSID
SELECT*
FROM Person.Address --ADDRESSID , STATEPROVINCEID
-------------------------------------------
SELECT E.BusinessEntityID,P.FirstName,SP.Name
FROM HumanResources.Employee E
	INNER JOIN Person.Person P ON E.BusinessEntityID = P.BusinessEntityID
	INNER JOIN Person.BusinessEntityAddress BEA ON P.BusinessEntityID = BEA.BusinessEntityID
	INNER JOIN PERSON.Address A ON BEA.AddressID = A.AddressID
	INNER JOIN Person.StateProvince SP ON A.StateProvinceID = SP.StateProvinceID
AND SP.Name = 'Florida'



--La suma de las ventas hechas por cada empleado, y agrupadas por año
SELECT*
FROM SALES.SalesPerson --SALESQUOTA
SELECT*
FROM Sales.SalesPersonQuotaHistory --SALESQUOTA , BUSINESSENTITYID ->HISTORIAL DE CUOTA DE VENDEDOR
SELECT*
FROM Person.Person --FIRSTNAME , BUSINESSENTITYID
-------------------------------------------------------------------
SELECT PP.BusinessEntityID,PP.FirstName,SUM(SalesQuota) AS TOTAL_VENDIDO,YEAR(QuotaDate) AS AÑO
FROM SALES.SalesPersonQuotaHistory SPQH
	INNER JOIN Person.Person PP ON SPQH.BusinessEntityID = PP.BusinessEntityID
GROUP BY PP.BusinessEntityID,PP.FirstName,YEAR(QuotaDate)
ORDER BY PP.BusinessEntityID




--El producto más vendido
 
SELECT*
FROM Sales.SalesOrderDetail --PRODUCTID
SELECT*
FROM Production.Product --PRODUCTID -> NAME

---------------------------------------------------
SELECT PP.ProductID,PP.Name,COUNT(PP.ProductID) AS MAS_VENDIDO 
FROM Production.Product PP
	INNER JOIN Sales.SalesOrderDetail SOD ON PP.ProductID = SOD.ProductID
GROUP BY PP.ProductID,PP.Name
ORDER BY MAS_VENDIDO DESC



--==========EJERCICIO CON NORTHWIND NO CON ADVENTURES XD==================================================================================================
--El nombre del empleado que tiene más territorios asignados
SELECT*
FROM HumanResources.EmployeeDepartmentHistory

SELECT*
FROM HumanResources.Employee  --BUSINESSENTITYID
SELECT*
FROM Person.Person --BUSINESSENTITYID
SELECT*
FROM SALES.SalesTerritoryHistory --BUSINESSENTITYID , TERRITORYID
SELECT*
FROM SALES.SalesTerritory --TERRITORYID
---------------------------------------------------------------------
SELECT HE.BusinessEntityID,PP.FirstName,COUNT(SSTH.TerritoryID) AS MAS_TERRITORIOS
FROM HumanResources.Employee HE
	INNER JOIN Person.Person PP ON HE.BusinessEntityID = PP.BusinessEntityID
	INNER JOIN Sales.SalesTerritoryHistory SSTH ON PP.BusinessEntityID = SSTH.BusinessEntityID
	INNER JOIN SALES.SalesTerritory SST ON SSTH.TerritoryID = SST.TerritoryID
GROUP BY SSTH.TerritoryID,HE.BusinessEntityID,PP.FirstName














--==========================================================EJERCICIOS DE NORTHWIND======================================================================
--la cantidad de diferentes títulos de contacto dentro de los proveedores es:
SELECT*
FROM Person.ContactType
SELECT*
FROM Purchasing.ProductVendor


--Cuántos clientes no han realizado pedido alguno
SELECT*
FROM Sales.Customer
SELECT*
FROM Sales.Store
SELECT*
FROM Sales.SalesPerson
SELECT*
FROM Sales.SalesOrderDetail
SELECT*
FROM Sales.SalesOrderHeader




