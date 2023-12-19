/*Curso DBA alura parte 2*/

#Costes de consultas

use jugos_ventas;

#Tardo 0.00077 sec / costo 3.75
select codigo_del_producto from tabla_de_productos A;

#Tardo 0.0069 sec / costo 40037.77
SELECT A.CODIGO_DEL_PRODUCTO, C.CANTIDAD FROM tabla_de_productos A
INNER JOIN items_facturas C
ON A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO;

#Tardo 0.0100 sec / costo 130084.99
SELECT A.CODIGO_DEL_PRODUCTO, year(F.FECHA_VENTA) as AÑO ,C.CANTIDAD FROM tabla_de_productos A
INNER JOIN items_facturas C
ON A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
INNER JOIN facturas F
on C.NUMERO = F.NUMERO;

#Tardo 2.537 sec / costo 130084.99
SELECT A.CODIGO_DEL_PRODUCTO, year(F.FECHA_VENTA) as AÑO ,sum( C.CANTIDAD) as cantidad FROM tabla_de_productos A
INNER JOIN items_facturas C
ON A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
INNER JOIN facturas F
on C.NUMERO = F.NUMERO
group by A.CODIGO_DEL_PRODUCTO, year(F.FECHA_VENTA)
order by A.CODIGO_DEL_PRODUCTO, year(F.FECHA_VENTA);

/*
Para poder ver el coste de la consulta podemos usar el comando Explain antes de la consulta en el simbolo de sistemas
pero tenemos que darle un formato json.

la consulta queda de esta manera:
*/
explain fomrat = json select codigo_del_producto from tabla_de_productos A;


/*
Los indices ayudan mucho al tiempo de ejecucion

ejemplo :*/


##coste 8849.05
Explain format = json select * from facturas where fecha_venta='20170101';

##Agregamos el indexado para la fecha y es coste se reduce

alter table facturas add index(fecha_venta);

##coste 25.90 

Explain format = json select * from facturas where fecha_venta='20170101';

##podemos eliminar el indice despues de hacer la consulta

alter table facturas drop index fecha_venta;

/*Tener un indice en la condicion de filtro nos va a ayudar a mejorar el coste y de esta manera
obtener las consultas mas rapido mejorando el rendimineto*/




