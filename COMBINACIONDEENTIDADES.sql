SELECT *
FROM SALES.SalesOrderHeader
WHERE CurrencyRateID IS NULL
-----------------------------
SELECT *
FROM SALES.SalesOrderHeader
WHERE CurrencyRateID IS NOT NULL
-----------------------------
SELECT *
FROM SALES.CurrencyRate
-----------------------------
SELECT *
FROM SALES.SalesOrderHeader SOH
	 INNER JOIN SALES.CurrencyRate CR ON SOH.CurrencyRateID = CR.CurrencyRateID
------------------------------
SELECT CR.FromCurrencyCode, CR.ToCurrencyCode, COUNT(1) AS CANTIDAD, SUM(TOTALDUE) AS MONTO,AVG(ENDOFDAYRATE) AS PROMEDIO
FROM SALES.SalesOrderHeader SOH
	 INNER JOIN SALES.CurrencyRate CR ON SOH.CurrencyRateID = CR.CurrencyRateID
GROUP BY CR.FromCurrencyCode, CR.ToCurrencyCode
ORDER BY CR.FromCurrencyCode, CR.ToCurrencyCode

------------------------------
SELECT YEAR(OrderDate) AS AÑO, CR.FromCurrencyCode, CR.ToCurrencyCode, COUNT(1) AS CANTIDAD, SUM(TOTALDUE) AS MONTO,AVG(ENDOFDAYRATE) AS PROMEDIO
FROM SALES.SalesOrderHeader SOH
	 INNER JOIN SALES.CurrencyRate CR ON SOH.CurrencyRateID = CR.CurrencyRateID
GROUP BY SOH.CURRENCYRATEID,YEAR(OrderDate), CR.FromCurrencyCode, CR.ToCurrencyCode
ORDER BY SOH.CURRENCYRATEID,YEAR(OrderDate),CR.FromCurrencyCode, CR.ToCurrencyCode
------------------------------
SELECT SOH.CURRENCYRATEID, YEAR(OrderDate) AS AÑO, CR.FromCurrencyCode, CR.ToCurrencyCode, COUNT(1) AS CANTIDAD, SUM(TOTALDUE) AS MONTO,AVG(ENDOFDAYRATE) AS PROMEDIO
FROM SALES.SalesOrderHeader SOH
	 INNER JOIN SALES.CurrencyRate CR ON SOH.CurrencyRateID = CR.CurrencyRateID
GROUP BY SOH.CURRENCYRATEID,YEAR(OrderDate), CR.FromCurrencyCode, CR.ToCurrencyCode
ORDER BY SOH.CURRENCYRATEID,YEAR(OrderDate),CR.FromCurrencyCode, CR.ToCurrencyCode
------------------------------


SELECT CR.FromCurrencyCode, CR.ToCurrencyCode, COUNT(1) AS CANTIDAD
FROM SALES.SalesOrderHeader SOH
	 LEFT OUTER JOIN SALES.CurrencyRate CR ON SOH.CurrencyRateID = CR.CurrencyRateID
GROUP BY CR.FromCurrencyCode, CR.ToCurrencyCode
ORDER BY CR.FromCurrencyCode, CR.ToCurrencyCode

------------------------------

SELECT CR.FromCurrencyCode, CR.ToCurrencyCode, COUNT(DISTINCT SOH.SalesOrderID) AS CANTIDAD
FROM SALES.SalesOrderHeader SOH
	 RIGHT OUTER JOIN SALES.CurrencyRate CR ON SOH.CurrencyRateID = CR.CurrencyRateID
GROUP BY CR.FromCurrencyCode, CR.ToCurrencyCode
ORDER BY CR.FromCurrencyCode, CR.ToCurrencyCode


------------------------------



---LAS VENTAS CON SU RESPECTIVO DETALLE A NIVERL PRODUCTO
SELECT SOH.AccountNumber, SOH.SalesOrderID, SOH.OrderDate, P.NAME, SOD.OrderQty
FROM SALES.SalesOrderHeader SOH
	 INNER JOIN SALES.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
		INNER JOIN Production.Product P ON SOD.ProductID = P.ProductID
	LEFT OUTER JOIN SALES.CurrencyRate CR ON SOH.CurrencyRateID = CR.CurrencyRateID
WHERE CR.CurrencyRateDate IS NOT NULL 
ORDER BY 1,2,3,4

SELECT SOH.AccountNumber, SOH.SalesOrderID, SOH.OrderDate, P.NAME, SOD.OrderQty
FROM SALES.SalesOrderHeader SOH
	 INNER JOIN SALES.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
		INNER JOIN Production.Product P ON SOD.ProductID = P.ProductID
	INNER JOIN SALES.CurrencyRate CR ON SOH.CurrencyRateID = CR.CurrencyRateID
ORDER BY 1,2,3,4