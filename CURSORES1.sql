
--declararlo

DECLARE C_DATOS CURSOR SCROLL
For
	SELECT*
	FROM SALES.Customer
--abrir el cursor
OPEN C_DATOS
--navegar 
--navegar por los N registros dentro del cursor y hacer algo con cada uno de los registros
-- algo : operacion, actualizar, eliminar,calcular,ejecutar funciones o procedimientos
	FETCH FIRST FROM C_DATOS
	FETCH RELATIVE 1 FROM C_DATOS
--cerrar el cursor
CLOSE C_DATOS
--libera memoria 
DEALLOCATE C_DATOS

--

-------------------------------------------------------------------------------------------------
DECLARE @CODIGO_CLIENTE INT,
		@TIENDA_ID INT,
		@CUENTA_NUMERO VARCHAR(100)
DECLARE C_DATA CURSOR
FOR
	SELECT CUSTOMERID,STOREID,ACCOUNTNUMBER
	FROM SALES.Customer
	WHERE CustomerID < 30

OPEN C_DATA
FETCH C_DATA INTO @CODIGO_CLIENTE,@TIENDA_ID,@CUENTA_NUMERO  --OBTIENE LAS N COLUMNAS DEL PRIMER REGISTRO
WHILE(@@FETCH_STATUS = 0)
BEGIN 
	--HACER ALGO
	PRINT'MI DATO: ' + CAST(@CODIGO_CLIENTE AS VARCHAR(10))

	FETCH C_DATA INTO @CODIGO_CLIENTE,@TIENDA_ID,@CUENTA_NUMERO  --REALIZANDO UN NEXT (SCROLL)
END 

CLOSE C_DATA
DEALLOCATE C_DATA



--------------------------EJERCICIO PRESENTACION --------------------------------------------------------
--aumentar el sueldo de los empleados en un 10% a las personas que esten casadas y que sean mujeres y un 5% al resto de empleados utilice almenos
--un cursor
/*SELECT* 
FROM HumanResources.EmployeePayHistory
WHERE BusinessEntityID = 4 AND
	RateChangeDate = (
SELECT MAX(RATECHANGEDATE)
	FROM HumanResources.EmployeePayHistory
	WHERE BusinessEntityID = 4)*/

	-------------------------------------------

DECLARE @EMPLOYEE_ID INT,
		@STATUS VARCHAR(2),
		@GENDER VARCHAR(2),
		@RATE_EMPLOYEE DECIMAL,
		@NEW_RATE_EMPLOYEE DECIMAL

DECLARE C_DATOS CURSOR
FOR
SELECT BusinessEntityID,MaritalStatus,Gender
FROM HumanResources.Employee

OPEN C_DATOS

FETCH C_DATOS INTO @EMPLOYEE_ID,@STATUS,@GENDER
WHILE(@@FETCH_STATUS =0 )
BEGIN
	--HACER ALGO
	SELECT @RATE_EMPLOYEE = Rate
FROM HumanResources.EmployeePayHistory
WHERE BusinessEntityID = @EMPLOYEE_ID AND
	RateChangeDate = (
SELECT MAX(RATECHANGEDATE)
	FROM HumanResources.EmployeePayHistory
	WHERE BusinessEntityID = @EMPLOYEE_ID)

	IF(@STATUS = 'M' AND @GENDER =  'F')
	BEGIN 
		SET @NEW_RATE_EMPLOYEE = @RATE_EMPLOYEE*1.10
	END
	ELSE 
	BEGIN 
		SET @NEW_RATE_EMPLOYEE = @RATE_EMPLOYEE*1.05
	END

	INSERT INTO HumanResources.EmployeePayHistory
	(BusinessEntityID,RateChangeDate,RATE,PayFrequency)
	VALUES
	(@EMPLOYEE_ID,GETDATE(),@NEW_RATE_EMPLOYEE,2)
	FETCH C_DATOS INTO @EMPLOYEE_ID,@STATUS,@GENDER
END
CLOSE C_DATOS
DEALLOCATE C_DATOS

