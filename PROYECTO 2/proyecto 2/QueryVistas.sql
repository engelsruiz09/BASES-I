---------------------------------------------------------------------------------
-----------------------------LLAMADO DE LAS VISTAS-------------------------------
---------------------------------------------------------------------------------

--1) Cantidad de automotores por tipo que circulan cada hora y en cada punto de control. Pueden hacer análisis también incluyendo el municipio.
SELECT *
FROM VWVMUNT
SELECT *
FROM VWHOART

--2) Detalle de automotores que sobrepasan los límites de velocidad.
	--▪ Para cada punto en especifico se tiene el límite
SELECT *
FROM VWVEHICULO_VELOCIDAD
	--▪ Si un carro pasa por dos puntos o mas de control, se tiene identificado la distancia que existe entre dichos puntos.
SELECT *
FROM VWVEHICULO_CONTROL

--3) Detalle de automotores que no cumplen con la capacidad máxima de ocupantes.
SELECT *
FROM VWVEHICULO_TABLAC  --la placa tal tiene capacidad maxima de 5 personas, pero llevan 25 , y tienen 20 extras (se coloca multa)

--4) Detalle de pilotos que no cumplen con tener o no anteojos según su licencia.
SELECT *
FROM VWLICENCIA_LENTES

--5) Cuantos automotores fueron conducidos por personas (en base a la licencia) que no estaban registrados para conducirlos.
SELECT *
FROM VW_VEH_LIC

--6) Que edades son las que mas conducen para cierto sector/ubicación
SELECT *
FROM VW_CONTRO_LICENCIA

---------------------------------------------------------------------------------
-----------------------------CREACION DE LAS VISTAS------------------------------
-----------------EN LAS VISTAS NO SE PUEDE USAR LAS CLAUSULAS 'ORDER BY'---------
--1) Cantidad de automotores por tipo que circulan cada hora y en cada punto de control. Pueden hacer análisis también incluyendo el municipio.

CREATE VIEW VWVMUNT AS
SELECT C.MUNICIPIO, COUNT(1) AS TOTAL
FROM TABLA_CONTROL TC
INNER JOIN CONTRO C ON TC.ID_CONTROL = C.ID_CONTROL
INNER JOIN VEHICULO V ON TC.ID_VEHICULO = V.ID_VEHICULO
WHERE (V.PLACA LIKE 'A%' AND (C.MUNICIPIO = 'GUATEMALA' OR C.MUNICIPIO = 'SANTA CATARINA PINULA' OR C.MUNICIPIO = 'SAN JOSE PINULA' OR C.MUNICIPIO = 'SAN JOSE DEL GOLFO' OR C.MUNICIPIO = 'PALENCIA' OR C.MUNICIPIO = 'CHINAUTLA' OR C.MUNICIPIO = 'SAN PEDRO AYAMPUC' OR C.MUNICIPIO = 'MIXCO' OR C.MUNICIPIO = 'SAN PEDRO SACATEPEQUEZ' OR C.MUNICIPIO = 'SAN JUAN SACATEPEQUEZ' OR C.MUNICIPIO = 'SAN RAYMUNDO' OR C.MUNICIPIO = 'CHURRANCHO' OR C.MUNICIPIO = 'FAIJANES' OR C.MUNICIPIO = 'AMATITLAN' OR C.MUNICIPIO = 'VILLA NUEVA' OR C.MUNICIPIO = 'VILLA CANALES' OR C.MUNICIPIO = 'SAN MIGUEL PETAPA')
 )--AND TC.HORAT BETWEEN '23:00:00' AND '23:59:59') 
GROUP BY C.MUNICIPIO

CREATE VIEW VWHOART AS
SELECT TC.HORAT, COUNT(1) AS TOTAL
FROM TABLA_CONTROL TC
INNER JOIN VEHICULO V ON TC.ID_VEHICULO = V.ID_VEHICULO
WHERE (V.PLACA LIKE 'A%') 
GROUP BY TC.HORAT


--2) Detalle de automotores que sobrepasan los límites de velocidad.
	--▪ Para cada punto en especifico se tiene el límite
CREATE VIEW VWVEHICULO_VELOCIDAD AS
SELECT TC.ID_CONTROL, TC.ID_VEHICULO, C.VELOCIDAD_MAX, TC.VELOCIDAD
FROM TABLA_CONTROL TC
INNER JOIN CONTRO C ON TC.ID_CONTROL = C.ID_CONTROL
WHERE (TC.VELOCIDAD > C.VELOCIDAD_MAX)
	--▪ Si un carro pasa por dos puntos o mas de control, se tiene identificado la distancia que existe entre dichos puntos.
CREATE VIEW VWVEHICULO_CONTROL AS
SELECT TC.ID_VEHICULO, TC.FECHAT, SUM(C.KILOMETRO) AS RECORRIDO
FROM TABLA_CONTROL TC
INNER JOIN CONTRO C ON TC.ID_CONTROL = C.ID_CONTROL
GROUP BY TC.ID_VEHICULO, TC.FECHAT

--3) Detalle de automotores que no cumplen con la capacidad máxima de ocupantes.
CREATE VIEW VWVEHICULO_TABLAC AS
SELECT V.ID_VEHICULO AS ID_VEHICULO_CONDUCIDO, V.NUM_LICENCIA AS NUM_LICENCIA_CONDUCTOR, V.CAP_MAXIMA AS OCUPANTES_MAX, TC.OCUPANTES, (TC.OCUPANTES-V.CAP_MAXIMA) AS OCUPANTES_EXTRAS, TC.FECHAT, TC.HORAT
FROM VEHICULO V
INNER JOIN TABLA_CONTROL TC ON V.ID_VEHICULO = TC.ID_VEHICULO
WHERE (TC.OCUPANTES > V.CAP_MAXIMA) AND (TC.OCUPANTES - V.CAP_MAXIMA) > 0

--4) Detalle de pilotos que no cumplen con tener o no anteojos según su licencia.
CREATE VIEW VWLICENCIA_LENTES AS
SELECT LIC.NUM_LICENCIA, (LIC.NOMBRE + ' ' + LIC.APELLIDO) AS CONDUCTOR, LIC.LENTES AS LENTES_LIC, TC.LENTES AS LENTES_CONT, TC.HORAT AS HORA, TC.FECHAT AS FECHA
FROM LICENCIA LIC
	INNER JOIN VEHICULO VH ON LIC.NUM_LICENCIA = VH.NUM_LICENCIA
	INNER JOIN TABLA_CONTROL TC ON VH.ID_VEHICULO = TC.ID_VEHICULO
WHERE (LIC.LENTES != 'SI' AND TC.LENTES = 'SI') OR (LIC.LENTES = 'SI' AND TC.LENTES != 'SI')

--5) Cuantos automotores fueron conducidos por personas (en base a la licencia) que no estaban registrados para conducirlos.
CREATE VIEW VW_VEH_LIC AS
SELECT COUNT(1) AS TOTAL
FROM VEHICULO V
INNER JOIN LICENCIA L ON V.NUM_LICENCIA = L.NUM_LICENCIA
WHERE (V.PLACA LIKE 'A%' AND L.ID_LICENCIA != 1) OR (V.PLACA LIKE 'B%' AND L.ID_LICENCIA != 2) OR (V.PLACA LIKE 'C%' AND L.ID_LICENCIA != 3) OR (V.PLACA LIKE 'M%' AND L.ID_LICENCIA != 4)

--6) Que edades son las que mas conducen para cierto sector/ubicación
CREATE VIEW VW_CONTRO_LICENCIA AS
SELECT DISTINCT C.MUNICIPIO, AVG(YEAR(GETDATE()) - YEAR(L.FECHA_NAC)) AS EDAD_PROM
FROM CONTRO C 
INNER JOIN TABLA_CONTROL TC ON C.ID_CONTROL = TC.ID_CONTROL
INNER JOIN VEHICULO V ON TC.ID_VEHICULO = V.ID_VEHICULO
INNER JOIN LICENCIA L ON V.NUM_LICENCIA = L.NUM_LICENCIA
GROUP BY C.MUNICIPIO