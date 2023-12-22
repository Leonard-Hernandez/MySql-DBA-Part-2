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

/*Mysqlslap

nos sirve para emular conexiones a la base de datos y ver las estadisticas en tiempo de esa interracion

mysqlslap -uroot -p --concurrency=100 --iterations=10 --create-schema=jugos_ventas --query="select * from facturas where fecha_venta = '20170101'";

resultado:
	Benchmark
        Average number of seconds to run all queries: 3.056 seconds
        Minimum number of seconds to run all queries: 3.031 seconds
        Maximum number of seconds to run all queries: 3.083 seconds
        Number of clients running queries: 100
        Average number of queries per client: 1
*/

select * from facturas where fecha_venta = '20170101';

/* Gestion de ususarios 

vamos a administration y a user y privileges

le damos a add user y le ponemos un usuario y contraseña y los privilegios

tambien la podemos crear con lineas de comando
*/

#creamos el usuario
create user 'admin02'@'localhost' identified by 'Soy_admin02';

#le damos todos los provilegios
grant all privileges on *.* to 'admin02'@'localhost' with grant option;


# Creando usuarios con menos privilegios

create user 'user01'@'localhost' identified by 'Soy_user01';

#le damos los privilegios necesarios
grant select, insert, update, delete, execute, lock tables, create temporary tables 
on *.* to 'admin02'@'localhost';


#Creando un usuario de solo lectura

create user 'read01'@'localhost' identified by 'Soy_read01';

#le damos privilegios de lectura y de ejecutar storedprocedure
grant select, execute 
on *.* to 'read01'@'localhost';

# Creando un ususario de backup

create user 'backup01'@'localhost' identified by 'Soy_backup01';

#le damos privilegios de lbackup
grant select, reload, lock tables, replication client
on *.* to 'backup01'@'localhost';





