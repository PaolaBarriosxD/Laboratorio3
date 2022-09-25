--ACTIVIDAD 2.3
--1
--La cantidad de colaboradores que nacieron luego del año 1995.

SELECT COUNT(*) AS COLABORADORESMAYOR1995 FROM COLABORADORES
WHERE YEAR(FECHANACIMIENTO) >1995

--2
--El costo total de todos los pedidos que figuren como Pagado.

SELECT SUM(COSTO) AS TOTALPEDIDOS FROM PEDIDOS
WHERE PAGADO =1

--3
--La cantidad total de unidades pedidas del producto con ID igual a 30.

