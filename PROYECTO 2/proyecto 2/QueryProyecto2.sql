CREATE TABLE TIPO_LICENCIA
(
	ID_LICENCIA INT NOT NULL,
	LETRA CHAR NOT NULL,
	TIPO_VEHICULO VARCHAR(50) NOT NULL

	CONSTRAINT PK_ID_LICENCIA PRIMARY KEY (ID_LICENCIA)
)
SELECT * FROM TIPO_LICENCIA

INSERT TIPO_LICENCIA
(ID_LICENCIA, LETRA, TIPO_VEHICULO)
VALUES
(1, 'A', 'BUS ESCOLAR')
INSERT TIPO_LICENCIA
(ID_LICENCIA, LETRA, TIPO_VEHICULO)
VALUES
(2, 'B', 'AUTOMOVIL TIPO CAMIONETA')
INSERT TIPO_LICENCIA
(ID_LICENCIA, LETRA, TIPO_VEHICULO)
VALUES
(3, 'C', 'AUTOMOVIL TIPO SEDAN')
INSERT TIPO_LICENCIA
(ID_LICENCIA, LETRA, TIPO_VEHICULO)
VALUES
(4, 'M', 'MOTOCICLETA')


CREATE TABLE LICENCIA
(
	NOMBRE VARCHAR(50) NOT NULL,
	APELLIDO VARCHAR(50) NOT NULL,
	LENTES VARCHAR(2) NOT NULL,
	FECHA_NAC DATE NOT NULL, ---dia entre 1-28 - mes entre 1-12 -a?o entre 1960-2003
	NUM_LICENCIA INT NOT NULL,
	DPI VARCHAR(50) NOT NULL,
	ID_LICENCIA INT NOT NULL

	CONSTRAINT PK_NUM_LICENCIA PRIMARY KEY(DPI),
	CONSTRAINT CHK_TIPO_LICENCIA CHECK(ID_LICENCIA = 1 OR ID_LICENCIA = 2 OR ID_LICENCIA = 3 OR ID_LICENCIA = 4),
	CONSTRAINT CHK_LENTES CHECK(LENTES = 'SI' OR LENTES = 'NO'),
	CONSTRAINT UK_NUM_LICENCIA UNIQUE(NUM_LICENCIA),
	CONSTRAINT UK_DPI UNIQUE(DPI)
)
BULK --Importa un archivo de datos en una tabla de base de datos o vista en un formato especificado por el usuario en SQL Server
   INSERT LICENCIA
   FROM 'C:\Users\julio ruiz\Downloads\Conductores.csv' 
   WITH 
       ( 
           FIRSTROW = 1, 
           MAXERRORS = 0, 
           FIELDTERMINATOR = ',', 
           ROWTERMINATOR = '\n' 
       )

CREATE TABLE VEHICULO
(
	PLACA VARCHAR(10) NOT NULL,
	NUM_LICENCIA INT NOT NULL,
	ID_VEHICULO INT NOT NULL,
	CAP_MAXIMA INT NOT NULL

	CONSTRAINT PK_ID_VEHICULO PRIMARY KEY(ID_VEHICULO)
)
BULK --Importa un archivo de datos en una tabla de base de datos o vista en un formato especificado por el usuario en SQL Server
   INSERT VEHICULO
   FROM 'C:\Users\julio ruiz\Downloads\Automoviles.csv' 
   WITH 
       ( 
           FIRSTROW = 1, 
           MAXERRORS = 0, 
           FIELDTERMINATOR = ',', 
           ROWTERMINATOR = '\n' 
       )

CREATE TABLE CONTRO
(
	ID_CONTROL INT NOT NULL,
	MUNICIPIO VARCHAR(50) NOT NULL,
	VELOCIDAD_MAX INT NOT NULL,
	KILOMETRO DECIMAL(3,1) NOT NULL --3 = NUMERO ENTERO DEL KILOMETRAJE, 1 = NUMERO DECIMAL DEL KILOMETRAJE

	CONSTRAINT PK_ID_CONTROL PRIMARY KEY(ID_CONTROL),
	CONSTRAINT CHK_MUNICIPIO CHECK(MUNICIPIO = 'GUATEMALA' OR MUNICIPIO = 'SANTA CATARINA PINULA' OR MUNICIPIO = 'SAN JOSE PINULA' OR MUNICIPIO = 'SAN JOSE DEL GOLFO' OR MUNICIPIO = 'PALENCIA' OR MUNICIPIO = 'CHINAUTLA' OR MUNICIPIO = 'SAN PEDRO AYAMPUC' OR MUNICIPIO = 'MIXCO' OR MUNICIPIO = 'SAN PEDRO SACATEPEQUEZ' OR MUNICIPIO = 'SAN JUAN SACATEPEQUEZ' OR MUNICIPIO = 'SAN RAYMUNDO' OR MUNICIPIO = 'CHURRANCHO' OR MUNICIPIO = 'FAIJANES' OR MUNICIPIO = 'AMATITLAN' OR MUNICIPIO = 'VILLA NUEVA' OR MUNICIPIO = 'VILLA CANALES' OR MUNICIPIO = 'SAN MIGUEL PETAPA')
)

SELECT * FROM CONTRO

INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(1, 'GUATEMALA', 33, 0)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(2, 'SANTA CATARINA PINULA', 39, 14.0)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(3, 'SAN JOSE PINULA', 79, 25)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(4, 'SAN JOSE DEL GOLFO', 57, 30)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(5, 'PALENCIA', 48, 40)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(6, 'CHINAUTLA', 52, 11)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(7, 'SAN PEDRO AYAMPUC', 32, 24)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(8, 'MIXCO', 37, 22)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(9, 'SAN PEDRO SACATEPEQUEZ', 80, 23)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(10, 'SAN JUAN SACATEPEQUEZ', 49, 31)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(11, 'SAN RAYMUNDO', 38, 43)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(12, 'CHUARRANCHO', 45, 35)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(13, 'FAIJANES', 63, 33)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(14, 'AMATITLAN', 57, 32)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(15, 'VILLA NUEVA', 45, 19)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(16, 'VILLA CANALES', 70, 21)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(17, 'SAN MIGUEL PETAPA', 62, 20)
--------------------------------------------------------------------------------
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(18, 'GUATEMALA', 41, 5)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(19, 'SANTA CATARINA PINULA', 65, 16)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(20, 'SAN JOSE PINULA', 68, 28)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(21, 'SAN JOSE DEL GOLFO', 69, 30.5)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(22, 'PALENCIA', 44, 30.9)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(23, 'CHINAUTLA', 73, 14)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(24, 'SAN PEDRO AYAMPUC', 43, 24.3)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(25, 'MIXCO', 56, 22.7)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(26, 'SAN PEDRO SACATEPEQUEZ', 48, 23.2)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(27, 'SAN JUAN SACATEPEQUEZ', 40, 31.6)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(28, 'SAN RAYMUNDO', 77, 47)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(29, 'CHUARRANCHO', 42, 39)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(30, 'FAIJANES', 33, 33.4)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(31, 'AMATITLAN', 66, 32.8)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(32, 'VILLA NUEVA', 56, 20.7)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(33, 'VILLA CANALES', 47, 21.2)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(34, 'SAN MIGUEL PETAPA', 68, 20.9)
----------------------------------------------------------------------------------------
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(35, 'GUATEMALA', 66, 3)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(36, 'SANTA CATARINA PINULA', 72, 18)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(37, 'SAN JOSE PINULA', 30, 27)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(38, 'SAN JOSE DEL GOLFO', 38, 29.6)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(39, 'PALENCIA', 67, 30.5)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(40, 'CHINAUTLA', 60, 12)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(41, 'SAN PEDRO AYAMPUC', 52, 22.3)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(42, 'MIXCO', 74, 22.2)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(43, 'SAN PEDRO SACATEPEQUEZ', 46, 30.1)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(44, 'SAN JUAN SACATEPEQUEZ', 55, 30.3)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(45, 'SAN RAYMUNDO', 77, 45)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(46, 'CHUARRANCHO', 40, 36)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(47, 'FAIJANES', 36, 31.9)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(48, 'AMATITLAN', 73, 34.5)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(49, 'VILLA NUEVA', 64, 21.8)
INSERT CONTRO
(ID_CONTROL, MUNICIPIO, VELOCIDAD_MAX, KILOMETRO)
VALUES
(50, 'VILLA CANALES', 71, 21.6)

----------------------------------------------------------------------
CREATE TABLE TABLA_CONTROL
(
	---SON 50 por dia
	ID_TABLAC INT NOT NULL, ---DATOS ENTEROS 1-que acabe
	ID_CONTROL INT NOT NULL,	---DATOS ALEATORIOS ENTRE 1-50
	ID_VEHICULO INT NOT NULL, ---DATOS ALEATORIOS ENTRE 1-5000
	VELOCIDAD INT NOT NULL, ---DATOS ALEATORIOS ENTRE 25-100
	FECHAT DATE NOT NULL, ---DIAS ALEATORIOS ENTRE 1-28 - MENES ALEATORIOS ENTRE 1-12 - A?O ALEATORIO ENTRE 2020-2022**
    HORAT TIME NOT NULL, ---HORA ALEATORIA ENTRE 1-23 : MINUTOS ALEATORIOS ENTRE 1-59 : SEGUNDOS ALEATORIOS ENTRE 1-59
	OCUPANTES INT NOT NULL, ---DATOS ALEATORIOS ENTRE 2-30
	LENTES VARCHAR(2) NOT NULL ---DATOS ALEATORIOS ENTRE SI-NO

	CONSTRAINT PK_ID_TABLAC PRIMARY KEY(ID_TABLAC)
)
BULK --Importa un archivo de datos en una tabla de base de datos o vista en un formato especificado por el usuario en SQL Server
   INSERT TABLA_CONTROL
   FROM 'C:\Users\julio ruiz\Downloads\tabla.csv' 
   WITH 
       ( 
           FIRSTROW = 1, 
           MAXERRORS = 0, 
           FIELDTERMINATOR = ',', 
           ROWTERMINATOR = '\n' 
       )

DROP TABLE VEHICULO
DROP TABLE LICENCIA
DROP TABLE TABLA_CONTROL