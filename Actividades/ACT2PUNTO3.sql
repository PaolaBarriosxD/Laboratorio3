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

SELECT SUM(PED.CANTIDAD) AS 'CANTIDAD TOTAL ID 30' FROM PEDIDOS PED
WHERE PED.IDProducto=30

--4
--La cantidad de clientes distintos que hicieron pedidos en el año 2020.

SELECT COUNT(DISTINCT IDCLIENTE) AS 'CLIENTES 2020' FROM PEDIDOS 
WHERE YEAR(FechaSolicitud) = 2020

--5
--Por cada material, la cantidad de productos que lo utilizan.

---que material??????????????????????

--6
--Para cada producto, listar el nombre y la cantidad de pedidos pagados.

SELECT DISTINCT PROD.DESCRIPCION AS NOMBREPRODUCTO, SUM(PED.CANTIDAD) AS CANTIDADPAGADOS FROM PEDIDOS PED
LEFT JOIN Productos PROD ON PROD.ID=PED.IDProducto
WHERE PED.PAGADO=1
GROUP BY PROD.Descripcion

--7
--Por cada cliente, listar apellidos y nombres de los clientes y la cantidad de productos distintos que haya pedido.

SELECT DISTINCT C.APELLIDOS, C.NOMBRES, COUNT(DISTINCT PED.IDPRODUCTO) AS CANTIDADPRODUCTOSDISTINTOS FROM CLIENTES C
INNER JOIN PEDIDOS PED ON C.ID= PED.IDCliente
GROUP BY C.APELLIDOS, C.NOMBRES
ORDER BY C.Apellidos ASC

--8
--Por cada colaborador y tarea que haya realizado, listar apellidos y nombres, nombre de la tarea y la cantidad de veces que haya realizado esa tarea.

SELECT COL.APELLIDOS, COL.NOMBRES, COL.MODALIDADTRABAJO, COUNT(COL.MODALIDADTRABAJO)
FROM COLABORADORES COL
GROUP BY COL.Apellidos, COL.Nombres, COL.ModalidadTrabajo

----NO LA ENTENDI...¿ TAREA REALIZADA=?

---9
---Por cada cliente, listar los apellidos y nombres y el importe individual más caro que hayan abonado en concepto de pago.

SELECT C.APELLIDOS,C.NOMBRES,MAX(DISTINCT  PED.COSTO) FROM CLIENTES AS C
INNER JOIN PEDIDOS AS PED ON PED.IDCLIENTE=C.ID
GROUP BY C.APELLIDOS, C.NOMBRES, PED.COSTO


--10 
---Por cada colaborador, apellidos y nombres y la menor cantidad de unidades solicitadas en un pedido individual en el que haya trabajado.

---no entiendooooo

--11
---Listar apellidos y nombres de aquellos clientes que no hayan realizado ningún pedido. Es decir, que contabilicen 0 pedidos.

SELECT distinct C.APELLIDOS, C.NOMBRES FROM CLIENTES C LEFT JOIN 
PEDIDOS P ON c.ID = p.IDCliente 
where P.IDCliente IS NULL


--12
---Obtener un listado de productos indicando descripción y precio de aquellos productos que hayan registrado más de 15 pedidos.
SELECT DISTINCT PROD.DESCRIPCION, PROD.PRECIO FROM PRODUCTOS PROD
INNER JOIN PEDIDOS PED ON PROD.ID=PED.IDProducto
GROUP BY PROD.Descripcion, PROD.PRECIO
HAVING COUNT(PED.IDProducto) > 15


--13
---Obtener un listado de productos indicando descripción y nombre de categoría de los productos que tienen un precio promedio de pedidos mayor a $25000

SELECT DISTINCT PROD.DESCRIPCION, CAT.NOMBRE FROM PRODUCTOS PROD
INNER JOIN PEDIDOS PED ON PROD.ID=PED.IDPRODUCTO 
INNER JOIN CATEGORIAS CAT ON CAT.ID=PROD.IDCATEGORIA
GROUP BY PROD.DESCRIPCION, CAT.NOMBRE
HAVING AVG(PED.COSTO)>25000


--14
---Apellidos y nombres de los clientes que hayan registrado más de 15 pedidos que superen los $15000.

SELECT DISTINCT C.APELLIDOS, C.NOMBRES FROM CLIENTES C
INNER JOIN PEDIDOS PED ON C.ID = PED.IDCliente
GROUP BY C.APELLIDOS, C.NOMBRES
HAVING (COUNT(PED.IDCliente) > 15 AND SUM(PED.Costo) >15000)

