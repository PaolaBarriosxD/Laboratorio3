

SELECT P.DESCRIPCION,P.PRECIO, C.NOMBRE AS CATEGORIA FROM PRODUCTOS AS P
INNER JOIN CATEGORIAS AS C ON P.IDCategoria = C.ID

--Listar las categorías de producto de las cuales no se registren productos.

SELECT C.NOMBRE AS CATEGORIA FROM Categorias AS C 
LEFT JOIN Productos AS P ON C.ID=P.IDCategoria
WHERE P.IDCategoria IS NULL

--Listar el nombre de la categoría de producto de aquel o aquellos productos que más tiempo lleven en construir.
SELECT MAX(P.DIASCONSTRUCCION) AS DIASDECONSTRUCCION, C.NOMBRE AS CATEGORIA  FROM Productos AS P
INNER JOIN Categorias AS C ON P.IDCategoria=C.ID
GROUP BY P.DiasConstruccion, C.Nombre
ORDER BY P.DiasConstruccion DESC


SELECT MAX(P.DiasConstruccion) AS DIASDECONSTRUCCION, C.NOMBRE
FROM Productos AS P 
INNER JOIN Categorias AS C
ON P.IDCategoria=C.ID
GROUP BY  C.Nombre



SELECT TOP 3 C.NOMBRE, MAX(P.DIASCONSTRUCCION) AS TIEMPOCONSTRUCCION
FROM Productos AS P 
INNER JOIN Categorias AS C  
ON P.IDCategoria=C.ID
GROUP BY  C.Nombre, P.DiasConstruccion
ORDER BY P.DiasConstruccion DESC


--Listar apellidos y nombres y dirección de mail de aquellos clientes que no hayan registrado pedidos.

SELECT C.APELLIDOS,C.NOMBRES, C.MAIL 
FROM CLIENTES AS C
LEFT JOIN PEDIDOS AS P
ON C.ID=P.IDCliente
WHERE P.IDCliente IS NULL

--Listar apellidos y nombres, mail, teléfono y celular de aquellos clientes que hayan realizado algún pedido cuyo costo supere $1000000

SELECT DISTINCT C.APELLIDOS, C.NOMBRES, C.MAIL, C.TELEFONO, C.CELULAR
FROM CLIENTES C INNER JOIN PEDIDOS P ON 
C.ID=P.IDCliente
WHERE P.Costo>1000000

--Listar IDPedido, Costo, Fecha de solicitud y fecha de finalización, descripción del producto,
--costo y apellido y nombre del cliente. Sólo listar aquellos registros de pedidos que hayan sido pagados.

SELECT PED.ID AS IDPEDIDO, PED.COSTO AS COSTOPEDIDO,PED.FECHASOLICITUD,PED.FECHAFINALIZACION, PROD.DESCRIPCION, PROD.COSTO AS COSTOPRODUCTO,C.APELLIDOS,C.NOMBRES
FROM CLIENTES C INNER JOIN PEDIDOS PED ON C.ID =PED.IDCliente INNER JOIN PRODUCTOS PROD ON PED.IDProducto= PROD.ID
WHERE PED.PAGADO = 1


--Listar IDPedido, Fecha de solicitud, fecha de finalización, días de construcción del producto,
--días de construcción del pedido (fecha de finalización - fecha de solicitud) 
--y una columna llamada Tiempo de construcción con la siguiente información:
--'Con anterioridad' → Cuando la cantidad de días de construcción del pedido sea menor a los días de construcción del producto.
--'Exacto'' → Si la cantidad de días de construcción del pedido y el producto son iguales
--'Con demora' → Cuando la cantidad de días de construcción del pedido sea mayor a los días de construcción del producto.

SELECT PED.ID, PED.FECHASOLICITUD,PED.FECHAFINALIZACION,PROD.DIASCONSTRUCCION, DATEDIFF(DAY,PED.FECHASOLICITUD,PED.FECHAFINALIZACION) AS 'DIAS ARMADO PEDIDO',
CASE 
WHEN DATEDIFF(DAY,PED.FECHASOLICITUD,PED.FECHAFINALIZACION) < PROD.DIASCONSTRUCCION THEN 'CON ANTERIORIDAD'
WHEN DATEDIFF(DAY,PED.FECHASOLICITUD,PED.FECHAFINALIZACION) > PROD.DIASCONSTRUCCION THEN 'CON DEMORA'
WHEN DATEDIFF(DAY,PED.FECHASOLICITUD,PED.FECHAFINALIZACION) = PROD.DIASCONSTRUCCION THEN 'EXACTO'
ELSE 'PROCESANDO'
END 'TIEMPO DE CONSTRUCCION'
FROM PEDIDOS PED INNER JOIN PRODUCTOS PROD
ON PED.IDProducto = PROD.ID
WHERE PED.FechaFinalizacion IS NOT NULL

---8
---Listar por cada cliente el apellido y nombres y los nombres de las categorías de aquellos productos de los cuales hayan realizado pedidos.
---No deben figurar registros duplicados.







