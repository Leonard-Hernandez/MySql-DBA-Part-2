/*Curso DBA alura parte 2*/

#Costes de consultas

use jugos_ventas;

#Tardo 0.00077 sec
select codigo_del_producto from tabla_de_productos A;

#Tardo 0.0069 sec
SELECT A.CODIGO_DEL_PRODUCTO, C.CANTIDAD FROM tabla_de_productos A
INNER JOIN items_facturas C
ON A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO;

#Tardo 0.0100 sec
SELECT A.CODIGO_DEL_PRODUCTO, year(F.FECHA_VENTA) as AÑO ,C.CANTIDAD FROM tabla_de_productos A
INNER JOIN items_facturas C
ON A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
INNER JOIN facturas F
on C.NUMERO = F.NUMERO;

#Tardo 2.537 sec
SELECT A.CODIGO_DEL_PRODUCTO, year(F.FECHA_VENTA) as AÑO ,sum( C.CANTIDAD) as cantidad FROM tabla_de_productos A
INNER JOIN items_facturas C
ON A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
INNER JOIN facturas F
on C.NUMERO = F.NUMERO
group by A.CODIGO_DEL_PRODUCTO, year(F.FECHA_VENTA)
order by A.CODIGO_DEL_PRODUCTO, year(F.FECHA_VENTA);