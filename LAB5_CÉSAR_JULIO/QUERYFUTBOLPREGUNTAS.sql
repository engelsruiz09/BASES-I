--------------------------CÉSAR SILVA-----------------------------------
--------------------------JULIO RUIZ------------------------------------
--Cuantos partidos por jornada han quedado empatados.
SELECT  P.JORNADA, COUNT(1) AS TOTAL_EMPATES
FROM PARTIDO P
WHERE P.MARCADOR = 'EMPATE'
GROUP BY P.JORNADA

--De los equipos que han jugado como local, cuantos goles en promedio han anotado.
SELECT  AVG(GOL_LOCAL) AS PROMEDIO_LOCAL
FROM PARTIDO P

--Qué jugadores han cambiado de equipo durante la presente temporada.
SELECT *
FROM JUGADOR
WHERE CAMBIO_EQUIPO = 'SI'

--Listado de todos los jugadores que son delanteros, con la cantidad de goles anotados, durante todas las temporadas.
SELECT J.NOMBRE, J.POSICION, J.GOLES
FROM JUGADOR J
WHERE POSICION = 'DELANTERO'

--Por equipo, cuantos partidos han jugado como local y como visita.
SELECT DISTINCT E.NOMBRE, COUNT(P.CELOCAL) TOTAL_LOCAL
FROM EQUIPO E
INNER JOIN PARTIDO P ON E.CODIGO = P.CELOCAL
GROUP BY E.NOMBRE

SELECT DISTINCT E.NOMBRE, COUNT(P.CELOCAL) TOTAL_VISITA
FROM EQUIPO E
INNER JOIN PARTIDO P ON E.CODIGO = P.CEVISITA
GROUP BY E.NOMBRE