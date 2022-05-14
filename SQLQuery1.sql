--DDL

CREATE TABLE cliente
(
id_cliente int,
nombre varchar(50),
dpi varchar(13)

)

ALTER TABLE cliente --para cambiar la estructura de una tabla existente.
ADD fecha_nac DATE

ALTER TABLE cliente
ALTER COLUMN nombre VARCHAR(100)

--DROP TABLE cliente





--DML 
--SELECT* FROM VEHICULO

--INSERT VEHICULO
--(PLACA,MODELO)
--VALUES
--('M-343','KWS')
