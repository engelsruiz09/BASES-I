---TABLA UTILIZADA PARA ESTA QUERY: ADVENTUREWORKS2019
---CÉSAR SILVA / 1184519
---JULIO RUIZ / 1284719

---Mostrar el nombre, apellido, puesto, edad y cantidad de horas de vacaciones para
---los empleados que nacieron entre 1970 y 1985. Ordenado por edad.
Select 2022 - YEAR(E.BirthDate) AS AGE, P.FirstName, P.LastName, E.JobTitle, E.VacationHours
	from Person.Person P
	INNER JOIN	HumanResources.Employee E ON P.BusinessEntityID = E.BusinessEntityID
WHERE E.BirthDate >= '1970-01-01' AND E.BirthDate <= '1985-12-31'
ORDER BY AGE 

---Mostrar el nombre, apellido, puesto, y cantidad de horas de vacaciones para los
---Agregar el empleados que nacieron entre 1970 y 1985. Ordenado por edad.
---departamento actual en el cual labora la persona.
Select 2022 - YEAR(E.BirthDate) AS AGE, P.FirstName, P.LastName, E.JobTitle, E.VacationHours, D.Name AS Department
	from Person.Person P
	INNER JOIN	HumanResources.Employee E ON P.BusinessEntityID = E.BusinessEntityID
		INNER JOIN HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
			INNER JOIN HumanResources.Department D ON EDH.DepartmentID = D.DepartmentID
WHERE E.BirthDate >= '1970-01-01' AND E.BirthDate <= '1985-12-31'
ORDER BY AGE

---Muestre la cantidad de empleados por departamento que tienen actualmente.		
SELECT DISTINCT D.Name AS Departamento, COUNT(*) AS Total_Empleados
	FROM HumanResources.EmployeeDepartmentHistory EDH
	INNER JOIN HumanResources.Department D ON EDH.DepartmentID = D.DepartmentID
GROUP BY D.Name
ORDER BY D.Name

---Total de ventas y monto realizados por año y mes.
Select DISTINCT YEAR(TH.ModifiedDate) AS YEAR, MONTH(TH.ModifiedDate) AS MONTH, SUM(P.ListPrice) AS MONTO, COUNT(*) AS TOTAL_VENTAS
	FROM Production.TransactionHistory TH
		INNER JOIN Production.Product P ON P.ProductID = TH.ProductID
GROUP BY YEAR(TH.ModifiedDate), MONTH(TH.ModifiedDate)
ORDER BY YEAR, MONTH

---Cuantas ventas fueron entregadas en una dirección diferente de la entrega de factura.
SELECT COUNT(*) AS CANTIDAD
	FROM sales.SalesOrderHeader SOH
WHERE BillToAddressID <> ShipToAddressID

---Cantidad de ventas que se le han aplicado algún descuento,
---agrupándola por el tipo de descuento y mostrando el monto descontado.
SELECT DISTINCT SOP.SpecialOfferID AS ID_OFERTAS_APLICADAS, COUNT(*) AS TOTAL_VENTAS_DESCUENTO
	FROM SALES.SpecialOffer SO
		INNER JOIN SALES.SpecialOfferProduct SOP ON SO.SpecialOfferID = SOP.SpecialOfferID
			INNER JOIN Production.Product P ON P.ProductID = SOP.ProductID
GROUP BY SOP.SpecialOfferID

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