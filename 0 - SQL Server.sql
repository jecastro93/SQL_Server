
/*https://www.tutorialesprogramacionya.com/sqlserverya/
/*------------------------------------------ TIPOS DE DATOS ------------------------------------------
-------------- 1. TEXTO --------------
	VARCHAR(X) -> Permite caracteres de 1 a 8000
	CHAR(X) -> Permite caracteres de 1 a 8000, se usa especialmente en valores que no son cambiantes, por ejemplo campo sexo "M-F"
	TEXT -> permite caracteres hasta de 2mil millones
	NVARCHAR(X) -> es similar a "varchar", excepto que permite almacenar caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
	NCHAR(X) -> es similar a "char" excpeto que acepta caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
	NTEXT -> es similar a "text" excepto que permite almacenar caracteres Unicode, puede contener hasta 1000000000 caracteres. No admite argumento para especificar su longitud.		

-------------- 2. NUMERICOS --------------
	VALORES ENTEROS
	INT / INTEGER -> su rango es de -2.000.000.000 a 2.000.000.000
	SMALLINT -> Puede contener hasta 5 digitos. Su rango va desde -32000 hasta 32000 aprox
	TINYINY -> Puede almacenar valores entre 0 y 255
	BIGINT -> su rango es de -9.000.000.000.000.000.000 hasta 9.000.000.000.000.000.000

	VALORES EXACTOS con decimales
	DECIMAL(4,2) -> Este tipo numerico redondea el valor al mas cercano, es decir, el valor "12.686", guardara "12.69" o el valor "12.682", guardara "12.67"

	VALORES APROXIMADOS con decimales
	FLOAT -> 
	REAL ->

	VALORES MONETARIOS
	MONEY -> Puede tener hasta 19 digitos y solo 4 de ellos puede ir luego del separador decimal; entre -900000000000000.5808 aprox y 900000000000000.5807
	SMALLMONEY -> Entre -200000.3648 y 200000.3647 aprox

-------------- 3. FECHA Y HORA --------------
	DATETIME -> puede almacenar valores desde 01 de enero de 1753 hasta 31 de diciembre de 9999
	SMALLDATETIEM -> el rango va de 01 de enero de 1900 hasta 06 de junio de 2079

	SQL Server reconoce varios formatos de entrada de datos de tipo fecha. PODEMOS INGRESAR DATOS CON "/", "-", "."
	Para establecer el orden de las partes de una fecha (dia, mes y anio) empleamos "set dateformat". Estos son los formatos:

	-mdy: 4/15/96 (mes y dia con 1 o 2 digitos y anio con 2 o 4 digitos),
	-myd: 4/96/15,
	-dmy: 15/4/1996
	-dym: 15/96/4,
	-ydm: 96/15/4,
	-ydm: 1996/15/4

	set dateformat dmy
*/

-- IF OBJECT_ID -> Sirve para verificar si la tabla que vamos a crear existe o no existe
if object_id('peliculas') is not null
	drop table peliculas;

-- CREAR TABLA
create table peliculas(
  oid integer IDENTITY(1,1) PRIMARY KEY NOT NULL, -- LLAVE PRIMARIA e IDENTITY para AUTOINCREMENTAR
	nombre varchar(50) NOT NULL,
	actor varchar(50) NOT NULL,
	duracion integer NOT NULL,
	cantidad integer NULL,
	precios float NULL
);

-- Sirve para dividir el lote de sentencias
/*"go" es un signo de finalizacion de un lote de sentencias SQL. No es una sentencia, es un comando.
El lote de sentencias esta compuesto por todas las sentencias antes de "go" o todas las sentencias entre dos "go"*/

GO

-- SP_COLUMNS -> Procedimiento almacenado para ver el detalle de las tablas
exec sp_columns peliculas;

-- INSERTAR DATOS
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 1', 'Tom Cruise', 128, 3, 120.50);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 2', 'Tom Cruise', 150, 2, 150);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mujer bonita', 'Julia Roberts', 118, 3, 95.50);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Elsa y Fred', 'China Zorrilla', 110, 2, 50);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 1', 'Tom Cruise', 118, 3, 120.50);
INSERT INTO peliculas VALUES ('Mision Imposible 1', 'Tom Cruise', 118, 3, 2000); --DE ESTA MANERA PODEMOS INSERTAR DATOS SIN NECESIDAD DE DECLARAR LOS CAMPOS
INSERT INTO peliculas (nombre, actor, duracion) VALUES ('Mision Imposible 1', 'Tom Cruise', 2222); -- DE ESTA MANERA INSERTAMOS LOS DATOS QUE QUEREMOS

-- CONSULTAR DATOS
SELECT * FROM peliculas;
SELECT nombre, actor, cantidad FROM peliculas;
SELECT nombre, duracion, precios FROM peliculas;
SELECT * FROM peliculas WHERE cantidad = 2;
SELECT nombre, actor, cantidad FROM peliculas WHERE actor = 'Tom Cruise';
SELECT * FROM peliculas WHERE duracion = 118;
SELECT nombre, actor, cantidad FROM peliculas WHERE actor <> 'Tom Cruise';--> DIFERENTE <>
SELECT nombre, actor, cantidad FROM peliculas WHERE precios >=120.5;--> MAYOR O MAYOR Y IGUAL >=
SELECT nombre+'-'+actor FROM peliculas; --> USAMOS "+" PARA CONCATENAR DOS CAMPOS
SELECT nombre, (cantidad*precios)  FROM peliculas --> USAMOS * PARA MULTIPLICAR CANTIDAD Y PRECIO 
SELECT nombre, (cantidad*precios)  AS precio FROM peliculas --> USAMOS "AS" PARA PONER ALIAS AL RESULTADO
SELECT nombre+'-'+actor AS 'nombre total' FROM peliculas;  --> USAMOS "AS" PARA PONER ALIAS AL RESULTADO Y "'" SE USA CUANDO EL ALIAS TIENE MAS DE UNA PALABRA

-- ELIMINAR DATOS
DELETE FROM peliculas; --> ELIMINA TODOS LOS REGISTROS
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 1', 'Tom Cruise', 118, 15, 500);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 1', 'Tom Cruise', 222, 15, 650);
DELETE FROM peliculas WHERE precios >=500;
DELETE FROM peliculas WHERE duracion = 222;
DELETE FROM peliculas WHERE oid = 7;
DELETE FROM peliculas WHERE cantidad = 15; 

-- ACTUALISAR DATOS
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 4', 'Tom Cruise', 118, 15, 500);
UPDATE peliculas SET nombre='AVENGERS' WHERE nombre = 'Mision Imposible 4' AND duracion = 118;
UPDATE peliculas SET cantidad=12 WHERE nombre = 'AVENGERS';
UPDATE peliculas SET duracion=90 WHERE cantidad = 12;
UPDATE peliculas SET duracion=190, actor='JHON C' WHERE precios = 500;
UPDATE peliculas SET duracion=999, actor='JHON CASTRO' WHERE actor LIKE 'JHON%'; --> % NOS SIRVE PARA ACTUALIZAR TODOS LOS REGISTROS QUE TENGAN JHON

-- VALORES NULL
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 4', 'Tom Cruise', 118, 15, NULL);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES (' ', 'Tom Cruise', 118, 15, NULL);
SELECT * FROM peliculas WHERE precios is NULL
DELETE FROM peliculas WHERE precios is NULL

-- CLAVE/LLAVE PRIMARIA
if OBJECT_ID ('usuarios') is not null
	drop table usuarios;

create table usuarios(
	nombre varchar (20),
	clave varchar (10),
	PRIMARY KEY (nombre) -- MANERA 1 PARA ASIGNAR LLAVE PRIMARIA
);
create table usuarios(
	nombre varchar (20) PRIMARY KEY,-- MANERA 2 PARA ASIGNAR LLAVE PRIMARIA
	clave varchar (10)
);

/*
IDENTITY sirve para poner un campo INTEGER en AUTOINCREMENTAR
AL PONER (100,2) INDICAMOS EL NUMERO EN Q EMPEZARA Y EL NUMERO EN QUE CONTINUARA, INICIA EN 100 Y EL SIGUIENTE REGISTRO SERA 102
*/
create table peliculas(
  oid integer IDENTITY(1,1) PRIMARY KEY NOT NULL, -- LLAVE PRIMARIA e IDENTITY para AUTOINCREMENTAR
	nombre varchar(50) NOT NULL,
);

SELECT IDENT_SEED ('PELICULAS') --> EL COMANDO IDENT_SEED NOS INDICA EL INICIO DEL CAMPO QUE CREAMOS
SELECT IDENT_INCR ('PELICULAS') --> EL COMANDO IDENT_INCR NOS INDICA DE CUANTO ES EL INCREMENTO DEL CAMPO
SET IDENTITY_INSERT peliculas ON --> EL COMANDO IDENTITY_INSERT PERMITE INGRESAR UN VALOR EN EL CAMPO QUE TENEMOS IDENTITY
INSERT INTO peliculas (OID, nombre, actor, duracion, cantidad, precios) VALUES (12,'Mision Imposible 4', 'Tom Cruise', 118, 15, NULL);
DELETE FROM peliculas WHERE OID = 12
SET IDENTITY_INSERT peliculas OFF --> DESACTIVAMOS EL COMANDO IDENTITY_INSERT

-- TRUNCATE TABLE Vacia toda la tabla y adicional reinicia el conteo autoincrement
TRUNCATE TABLE peliculas;

-- DATE TIPO DE DATOS DATETIME
if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  nombre varchar(20),
  documento varchar(20) DEFAULT 'Pendiente',
  fechaingreso datetime
  cantidad integer DEFAULT 0
);
set dateformat dmy; --LE DAMOS FORMATO A LA FECHA

insert into empleados values('Ana Gomez','22222222','12-01-1980');
insert into empleados values('Bernardo Huerta','23333333','15-03-81');
insert into empleados values('Carla Juarez','24444444','20/05/1983');
insert into empleados values('Daniel Lopez','25555555','2.5.1990')

select * from empleados;
select * from empleados where fechaingreso < '01-01-1985';
update empleados set nombre='Maria Carla Juarez' where fechaingreso = '20.5.83';
delete from empleados where fechaingreso <> '20/05/1983';

-- VALORES DEFAULT
if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  nombre varchar(20),
  documento varchar(20) DEFAULT 'Pendiente', --AL NO INGRESAR VALORES LOS DEFAULT VAN A TENER UN VALOR POR DEFECTO
  fechaingreso datetime,
  cantidad integer NULL DEFAULT 0 --AL NO INGRESAR VALORES LOS DEFAULT VAN A TENER UN VALOR POR DEFECTO
);
set dateformat dmy;

insert into empleados values('Ana Gomez','22222222','12-01-1980',2);
insert into empleados values('Bernardo Huerta','23333333','15-03-81',3);
insert into empleados (nombre, fechaingreso) values('Carla Juarez','20/05/1983');
insert into empleados (nombre, documento, fechaingreso)values('Daniel Lopez','25555555','2.5.1990');

select * from empleados;


/*------------------------------------------ FUNCIONES ------------------------------------------
Una funcion es un conjunto de sentencias que operan como una unidad logica.
Una funcion tiene un nombre, retorna un parametro de salida y opcionalmente acepta parametros de entrada. 
Las funciones de SQL Server no pueden ser modificadas, las funciones definidas por el usuario si.
SQL Server ofrece varios tipos de funciones para realizar distintas operaciones.

-------------- 1 . FUNCIONES PARA MANEJO DE CARACTERES --------------
	SUBSTRING(cadena,inicio,longitud) --> Devuelve una parte de la cadena especificada, empezando desde el inicio y termina con la longitud estipulada
		ejem: select substring('Buenas tardes',8,6); --> retorna "tardes" --> Dado que empieza en la posicion 8 que es "T" y termina con la longitud que son 6.
	STR(numero,longitud,cantidaddecimales) --> Convierte un numero a caracteres
		ejem: select str(123.456,7,2); --> retorna '123.46' --> Dado que el numero a convertir solo permite 2 decimales y su longitud es de 7.
	STUFF(cadena1,inicio,cantidad,cadena2) --> inserta la cadena enviada como cuarto argumento, en la posicion indicada en el segundo argumento, reemplazando la cantidad de caracteres indicada por el tercer argumento
		ejem: select stuff('abcde',3,2,'opqrs'); --> retorna "abopqrse". Es decir, coloca en la posicion 3 la cadena "opqrs" y reemplaza 2 caracteres de la primer cadena
	LEN(cadena) --> retorna la longitud de la cadena, cantidad de caracteres
		ejem: select len('Hola'); --> retorna 4
	CHAR(x) --> retorna un caracter en codigo ASCII del entero enviado
		ejem: select char(65); --> retorna A
	LEFT(cadena,longitud): retorna la cantidad de caracteres de la cadena comenzando desde la izquierda
		ejem: select left('buenos dias',8); --> retorna "buenos d"
	RIGHT(cadena,longitud): retorna la cantidad de caracteres de la cadena comenzando desde la derecha
		ejem: select right('buenos dias',8); --> retorna "nos dias
	LOWER(cadena): retornan la cadena con todos los caracteres en minusculas
		ejem: select lower('HOLA ESTUDIAnte'); --> retorna "hola estudiante"
	UPPER(cadena): retornan la cadena con todos los caracteres en mayusculas
		ejem: select upper('HOLA ESTUDIAnte'); --> retorna "HOLA ESTUDIANTE"
	LTRIM(cadena): retorna la cadena con los espacios de la izquierda eliminados
		ejem: select ltrim('     Hola     '); --> retorna "Hola     "
	RTRIM(cadena): retorna la cadena con los espacios de la derecha eliminados
		ejem: select rtrim('     Hola     '); --> retorna "     Hola"
	REPLACE(cadena,cadenareemplazo,cadenareemplazar) --> reemplaza todas las cadenas definidas en el 3 parametro por la del 2 parametro
		ejem: select replace('xxx.sqlserverya.com','x','w'); --> retorna "www.sqlserverya.com'
	REVERSE(cadena)--> devuelve la cadena invirtiendo el order de los caracteres
		ejem: select reverse('Hola'); --> retorna "aloH"
	PATINDEX(patron,cadena) --> devuelve la posicion de comienzo del patron especificado.
		ejem: select patindex('%Luis%', 'Jorge Luis Borges'); --> retorna 7
	CHARINDEX(subcadena,cadena,inicio) --> devuelve la posicion donde comienza la subcadena en la cadena, comenzando la busqueda desde la posicion indicada por "inicio"
		ejem: select charindex('or','Jorge Luis Borges',5); --> retorna 13
	REPLICATE(cadena,cantidad) --> repite una cadena la cantidad de veces especificada
		ejem: select replicate ('Hola ',3); --> retorna "HolaHolaHola"
	SPACE(cantidad) --> retorna una cadena de espacios de longitud indicada por cantidad
		ejem: select 'Hola'+space(1)+'que tal'; --> retorna "Hola que tal"

-------------- 2. FUNCIONES MATEMATICAS --------------
	ABS(x): retorna el valor absoluto del argumento "x"
		ejem: select abs(-20); --> retorna 20
	CEILING(x): redondea hacia arriba el argumento "x"
		ejem: select ceiling(12.34); --> retorna 13
	FLOOR(x): redondea hacia abajo el argumento "x"
		ejem: select floor(12.34); --> retorna 12
	%: devuelve el resto de una division
		ejem: select 10%3; --> retorna 1
	POWER(x,y): retorna el valor de "x" elevado a la "y" potencia
		ejem: select power(2,3); --> retorna 8
	ROUND(numero,longitud): retorna un numero redondeado a la longitud especificada
		ejem1: select round(123.456,1); --> retorna "123.400", es decir, redondea desde el primer decimal
		ejem2: select round(123.456,2); --> retorna "123.460", es decir, redondea desde el segundo decimal
		ejem3: select round(123.456,-1); --> retorna "120.000", es decir, redondea desde el primer valor entero (hacia la izquierda)
	SIGN(x): si el argumento es un valor positivo devuelve 1;-1 si es negativo y si es 0, 0
		ejem: select sign(5); --> retorna 1, dado que el numero es positivo
	SQUARE(x): retorna el cuadrado del argumento
		ejem: select square(3); retorna 9
	SRQT(x): devuelve la raiz cuadrada del valor enviado como argumento
		ejem: select srqt(49);

-------------- 3. FUNCIONES PARA FECHAS Y HORAS --------------
	GETDATE(): retorna la fecha y hora actuales
		ejem: select getdate();
	DATEPART(partedefecha,fecha): retorna la parte especifica de una fecha, el anio, trimestre, dia, hora, etc
								  Los valores para "partedefecha" pueden ser: year (anio), quarter (cuarto), 
								  month (mes), day (dia), week (semana), hour (hora), minute (minuto), second (segundo) y millisecond (milisegundo)
		ejem1: select datepart(month,getdate()); --> retorna el numero de mes actual
		ejem2: select datepart(day,getdate()); --> retorna el dia actual
		ejem3: select datepart(hour,getdate()); --> retorna la hora actual
	DATENAME(partedefecha,fecha): retorna el nombre de una parte especifica de una fecha
		ejem1: select datename(month,getdate()); --> retorna el nombre del mes actual
		ejem2: select datename(day,getdate()); --> retorna el nombre del dia actual
	DATEADD(partedelafecha,numero,fecha): agrega un intervalo a la fecha especificada, es decir, retorna una fecha adicionando a la fecha enviada como tercer argumento
		ejem1: select dateadd(day,3,'1980/11/02'); --> retorna "1980/11/05", agrega 3 dias
		ejem2: select dateadd(month,3,'1980/11/02'); --> retorna "1981/02/02", agrega 3 meses
		ejem3: select dateadd(hour,2,'1980/11/02'); --> retorna "1980/02/02 2:00:00", agrega 2 horas
	DATEDIFF(partedelafecha,fecha1,fecha2): calcula el intervalo de tiempo (segun el primer argumento) entre las 2 fechas
		ejem1: select datediff (day,'2005/10/28','2006/10/28'); --> retorna 365 (dias)
		ejem2: select datediff(month,'2005/10/28','2006/11/29'); --> retorna 13 (meses)
		ejem3: select titulo, datediff(year,edicion,getdate()) from libros; --> Mostramos el titulo del libro y los anios que tienen de editados
		ejem4: select titulo from libros where datepart(day,edicion)=9 --> Muestre los titulos de los libros que se editaron el dia 9, de cualquier mes de cualquier anio
	DAY(fecha): retorna el dia de la fecha especificada
		ejem: select day(getdate()); 
	MONTH(fecha): retorna el mes de la fecha especificada. 
		ejem: select month(getdate());
	YEAR(fecha): retorna el anio de la fecha especificada. 
		ejem: select year(getdate());

-------------- 4. FUNCIONES DE AGRUPAMIENTO (COUNT - SUM - MIN - MAX - AVG - TOP) --------------
	El tipo de dato del campo determina las funciones que se pueden emplear con ellas
	COUNT(campo): se puede emplear con cualquier tipo de dato
	MIN(campo) - MAX(campo): con cualquier tipo de dato, retorna el valor maximo o minimo de un campo
	SUM(campo) y AVG(campo): solo en campos de tipo numerico, retorna la suma o el valor promedio de los valores que contiene el campo especificado
	
	TOP ->  Se emplea para obtener solo una cantidad limitada de registros, los primeros n registros de una consulta
		select top 3 titulo,autor from libros order by autor --> Consulta los titulos y autores de los 3 primeros libros, ordenados por autor

		Cuando se combina con "order by" es posible emplear tambien la clausula "with ties". 
		Esta clausula permite incluir en la seleccion, todos los registros que tengan el mismo valor del campo por el que se ordena en la ultima posicion
		select top 3 with ties * from libros order by autor --> Consulta los titulos y autores de los libros q cumplan con la misma condicion de ordenamiento

-------------- 5. FUNCIONES DE AGRUPAMIENTO AVANZADOS (GROUP BY/GROUP BY ALL - HAVING - WITH ROLLUP y CUBE - GROUPING) --------------
-- GROUP BY/GROUP BY ALL  -> Agrupa registros para consultas detalladas
		Note que las editoriales que no tienen libros que cumplan la condicion, no aparecen en la salida. 
		Para que aparezcan todos los valores de editorial, incluso los que devuelven cero o "null" en la columna de agregado, 
		debemos emplear la palabra clave "all" al lado de "group by"
		ejem1: select editorial, count(*) from libros where precio<30 group by editorial;
		ejem2: select editorial, count(*) from libros where precio<30 group by all editorial;
 
-- HAVING -> Permite seleccionar (o rechazar) un grupo de registros
		ejem1: select editorial, count(*) from libros group by editorial -> Cantidad de libros agrupados por editorial
		ejem2: select editorial, count(*) from libros group by editorial having count(*)>2 -> Cantidad de libros agrupados por editorial y que devuelvan un valor mayor a 2

		Ambas devuelven el mismo resultado, pero son diferentes
		La primera, selecciona todos los registros rechazando los de editorial "Planeta" y luego los agrupa para contarlos
			ejem3 where: select editorial, count(*) from libros where editorial<>'Planeta' group by editorial;
		La segunda, selecciona todos los registros, los agrupa para contarlos y finalmente rechaza fila con la cuenta correspondiente a la editorial "Planeta"
			ejem 4: select editorial, count(*) from libros group by editorial having editorial<>'Planeta';

-- MODIFICADOR DEL GROUP BY (WITH ROLLUP y CUBE)
	Podemos combinar "group by" con los operadores "rollup" y "cube"
	ROLLUP -> El operador "rollup" agrega filas extras mostrando resultados de resumen por cada grupo y subgrupo
		Entonces, "rollup" es un modificador para "group by" que agrega filas extras mostrando resultados de resumen de los subgrupos
		Si necesitamos la cantidad de visitantes por ciudad empleamos la siguiente sentencia:
			select ciudad,count(*) as cantidad from visitantes group by ciudad;
		Esta consulta muestra el total de visitantes agrupados por ciudad
		Pero si queremos ademas la cantidad total de visitantes, debemos realizar otra consulta:
			select count(*) as total from visitantes;
		Para obtener ambos resultados en una sola consulta podemos usar "with rollup" que nos devolvera ambas salidas en una sola consulta:
			select ciudad,count(*) as cantidad from visitantes group by ciudad with rollup;
		
		La clausula "group by" permite agregar el modificador "with rollup", el cual agrega registros extras al resultado de una consulta, que muestran operaciones de resumen
			select ciudad,sexo,count(*) as cantidad from visitantes group by ciudad,sexo with rollup;
		
		Es posible incluir varias funciones de agrupamiento, por ejemplo, queremos la cantidad de visitantes y la suma de sus compras agrupados por ciudad y sexo
			select ciudad,sexo, count(*) as cantidad, sum(montocompra) as total from visitantes group by ciudad,sexo with rollup;
	CUBE -> El operador "cube" genera filas de resumen de subgrupos para todas las combinaciones posibles de los valores de los campos por los que agrupamos
		Es decir, "cube" genera filas de resumen de subgrupos para todas las combinaciones posibles de los valores de los campos por los que agrupamos

		Ejem RollUp: select sexo,estadocivil,seccion, count(*) from empleados group by sexo,estadocivil,seccion with rollup;
			SQL Server genera varias filas extras con informacion de resumen para los siguientes subgrupos:
				- sexo y estadocivil (seccion seteado a "null")
				- sexo (estadocivil y seccion seteados a "null")
				- total (todos los campos seteados a "null").
		Ejem Cube: select sexo,estadocivil,seccion, count(*) from empleados group by sexo,estadocivil,seccion with cube;	
			Retorna mas filas extras ademas de las anteriores:
				- sexo y seccion (estadocivil seteado a "null")
				- estadocivil y seccion (sexo seteado a "null")
				- seccion (sexo y estadocivil seteados a "null")
				- estadocivil (sexo y seccion seteados a "null")
-- FUNCION GROUPING
	La funcion "grouping" se emplea con los operadores "rollup" y "cube" para distinguir los valores de detalle y de resumen en el resultado. 
	Es decir, permite diferenciar si los valores "null" que aparecen en el resultado son valores nulos de las tablas o si son una fila generada por 
	los operadores "rollup" o "cube"
	Con esta funcion aparece una nueva columna en la salida, una por cada "grouping"; 
	Retorna el valor 1 para indicar que la fila representa los valores de resumen de "rollup" o "cube" y el valor 0 para representar los valores de campo

		Si tenemos una tabla "visitantes" y contamos la cantidad agrupando por ciudad
			select ciudad, count(*) as cantidad from visitantes group by ciudad with rollup;
		La ultima fila es la de resumen generada por "rollup", pero no es posible distinguirla de la primera fila, en la cual "null" es un valor del campo. 
		Para diferenciarla empleamos "grouping
			select ciudad, count(*) as cantidad, grouping(ciudad) as resumen from visitantes group by ciudad with rollup
		
		La ultima fila contiene en la columna generada por "grouping" el valor 1, indicando que es la fila de resumen generada por "rollup"; 
		La primera fila, contiene en dicha columna el valor 0, que indica que el valor "null" es un valor del campo "ciudad"
*/

-- ORDER BY --> Podemos ordenar el resultado de un "select" para que los registros se muestren ordenados por algun campo

/*
-- ORDENADORES LOGICOS ( AND - OR - NOT)
	AND, significa "y"
		ejem: select * from libros where (autor='Borges') and (precio<=20); --> Calculamos los libros cuyo autor sea igual a "Borges" y cuyo precio no supere los 20
	OR, significa "y/o",
		ejem: select * from libros where autor='Borges' or editorial='Planeta'; --> Calculamos los libros cuyo autor sea "Borges" y/o cuya editorial sea "Planeta"
	NOT, significa "no", invierte el resultado
		ejem: select * from libros where not editorial='Planeta'; --> Calculamos los libros que NO cumplan la condicion, aquellos cuya editorial NO sea "Planeta"
	(), parentesis agrupa las condiciones que se quieren usar
		ejem: select * from libros where (autor='Borges') or (editorial='Paidos' and precio<20);
*/

/*
-- OPERADORES RELACIONALES (IS NULL - BETWEEN - IN)
	IS NULL --> Se emplea el operador "is null" para consultar los registros en los cuales este almacenado el valor "null"
		ejem: select * from libros where editorial is null
	BETWEEN --> Este operador se puede emplear con tipos de datos (numericos y money) y (fecha y hora)
		ejem1: select * from libros where precio between 20 and 40 --> Consultamos los libros con precio mayor o igual a 20 y menor o igual a 40
		ejem2: select *from libros where precio not between 20 and 35 --> Consultamos los libros cuyo precio NO se este entre 20 y 35, es decir, los menores a 15 y mayores a 25
	IN --> Se utiliza "in" para averiguar si el valor de un campo esta incluido en una lista de valores especificada
		ejem guia: select *from libros where autor='Borges' or autor='Paenza';
		ejem: select * from libros where autor in('Borges','Paenza')
*/

/*
-- BUSQUEDA LIKE Y NOT LIKE
	Se usa para realizar comparaciones exclusivamente de cadenas y utiliza varios comodines
		% --> El simbolo "%" (porcentaje) reemplaza cualquier cantidad de caracteres
			ejem1: select * from libros where autor like "%Borges%" --> Consulta todos los libros que contengan en autor el apellido BORGES
			ejem2: select * from libros where titulo like 'M%' --> Consulta todos los libros que comiencen con "M"
			ejem3: select titulo,precio from libros where precio like '1_.%' --> Consulta los libros cuyo precio se encuentre entre 10.00 y 19.99
		_ --> el guion bajo "_" reemplaza un caracters
			ejem: select * from libros where autor like '%Carrol_' --> Consulta los libros de "Lewis Carroll" pero no recordamos si se escribe "Carroll" o "Carrolt"
		[] --> reemplaza cualquier caracter contenido en el conjunto especificado dentro de los corchetes
			ejem1: select titulo,editorial from libros where editorial like '[P-S]%' --> Consulta los libros cuya editorial comienza con las letras entre la "P" y la "S"
			ejem2: select titulo,editorial from libros where editoriallike '[a-cf-i]%'--> Consulta cadenas que comiencen con a,b,c,f,g,h o i;
			ejem3: select titulo,editorial from libros where editoriallike '[-acfi]%'--> Consulta cadenas que comiencen con -,a,c,f o i;
			ejem4: select titulo,editorial from libros where editoriallike 'A[_]9%'--> Consulta cadenas que comiencen con 'A_9';
			ejem5: select titulo,editorial from libros where editoriallike 'A[nm]%'--> Consulta cadenas que comiencen con 'An' o 'Am'
		[^] --> reemplaza cualquier caracter NO presente en el conjunto especificado dentro de los corchetes
			select titulo,autor,editorial from libros where editorial like '[^PN]%' --> Consulta los libros cuya editorial NO comienza con las letras "P" ni "N"
*/

-- COUNT/COUNT_BIG -> La funcion "count()" cuenta la cantidad de registros de una tabla, incluyendo los que tienen valor nulo
-- DISTINCT -> Se especifica que los registros con ciertos datos duplicados sean obviadas en el resultado

/*
-- CLAVE/LLAVE PRIMARIA COMPUESTA
	Las claves primarias pueden ser simples, formadas por un solo campo o compuestas, mas de un campo
	Existe un estacionamiento que almacena cada dia los datos de los vehiculos que ingresan en la tabla llamada "vehiculos"*/
		create table vehiculos(
			patente char(6) not null,
			tipo char(1),--'a'=auto, 'm'=moto
			horallegada datetime,
			horasalida datetime,
			primary key(patente,horallegada)
		);
		insert into vehiculos values('AIC124','a','8:05','12:30');
		insert into vehiculos values('CAA258','a','8:05',null);
		insert into vehiculos values('DSE367','m','8:30','18:00');
		insert into vehiculos values('FGT458','a','9:00',null);
		insert into vehiculos values('AIC124','a','16:00',null);
		insert into vehiculos values('LOI587','m','18:05','19:55');

/*	
	Necesitamos definir una clave primaria para una tabla con los datos descriptos arriba. 
	No podemos usar solamente la patente porque un mismo auto puede ingresar mas de una vez en el dia a la playa
	Tampoco podemos usar la hora de entrada porque varios autos pueden ingresar a una misma hora.
	
	Definimos una clave compuesta cuando ningun campo por si solo cumple con la condicion para ser clave
	En este ejemplo, un auto puede ingresar varias veces en un dia a la playa, pero siempre sera a distinta hora
	Usamos 2 campos como clave, la patente junto con la hora de llegada, asi identificamos univocamente cada registro
*/

/*------------------------------------------ INTEGRIDAD DE LOS DATOS ------------------------------------------
	Recuerde que cuando agregamos una restriccion a una tabla que contiene informacion
	SQL Server controla los datos existentes para confirmar que cumplen la condicion de la restriccion
	Si no los cumple, la restriccion no se aplica y aparece un mensaje de error.

---------------------------- 1. RESTRICCIONES (CONSTRAINTS) --------------
	Las restricciones (constraints) son un metodo para mantener la integridad de los datos, asegurando que los valores ingresados sean validos 
	y que las relaciones entre las tablas se mantenga. Se establecen a los campos y las tablas
	Pueden definirse al crear la tabla ("create table") o agregarse a una tabla existente (empleando "alter table") y se pueden aplicar a un campo o a varios
	El procedimiento almacenado del sistema "sp_helpconstraint" junto al nombre de la tabla, nos muestra informacion acerca de las restricciones de dicha tabla
	Hay varios tipos de restricciones:

-------------- 1.2. RESTRICCION CAMPO (DEFAULT) --------------
	La restriccion "default" especifica un valor por defecto para un campo cuando no se inserta explicitamente en un comando "insert"
	Anteriormente, para establecer un valor por defecto para un campo empleabamos la clausula "default" al crear la tabla:
		ejem: create table libros(...autor varchar(30) default 'Desconocido', ...);
		Dicha restriccion, a la cual no le dabamos un nombre, recibia un nombre dado por SQL Server que consiste "DF" (por default), 
		seguido del nombre de la tabla, el nombre del campo y letras y numeros aleatorios
		Podemos agregar una restriccion "default" a una tabla existente con la sintaxis basica siguiente:
			sintaxis: alter table NOMBRETABLA add constraint NOMBRECONSTRAINT default VALORPORDEFECTO for CAMPO;
			Cuando demos el nombre a las restricciones "default" formato similar al que le da SQL Server: "DF_NOMBRETABLA_NOMBRECAMPO"
		
		La restriccion "default" acepta valores tomados de funciones del sistema, por ejemplo:
		Podemos establecer que el valor por defecto de un campo de tipo datetime sea "getdate()".

		Podemos ver informacion referente a las restriciones de una tabla con el procedimiento almacenado "sp_helpcontraint":
			exec sp_helpconstraint libros;
			Aparecen varias columnas con la siguiente informacion:
				- constraint_type: el tipo de restriccion y sobre que campo esta establecida (DEFAULT on column autor)
				- constraint_name: el nombre de la restriccion (DF_libros_autor)
				- delete_action y update_action: no tienen valores para este tipo de restriccion
				- status_enabled y status_for_replication: no tienen valores para este tipo de restriccion
				- constraint_keys: el valor por defecto (Desconocido)

-------------- 1.3. RESTRICCION CAMPO (CHECK) --------------
	La restriccion "check" especifica los valores que acepta un campo, evitando que se ingresen valores inapropiados
	La sintaxis basica es la siguiente:
		sintaxis: alter table NOMBRETABLA add constraint NOMBRECONSTRAINT check CONDICION

		Trabajamos con la tabla "libros" de una libreria que tiene los siguientes campos: codigo, titulo, autor, editorial, preciomin, preciomay
		Los campos de los precios (minorista y mayorista) se definen de tipo decimal(5,2), es decir, aceptan valores entre -999.99 y 999.99. 
		Podemos controlar que no se ingresen valores negativos para dichos campos agregando una restriccion "check"
			ejem: alter table libros add constraint CK_libros_precio_positivo check (preciomin>=0 and preciomay>=0)

		La condicion puede hacer referencia a otros campos de la misma tabla. 
		Por ejemplo, podemos controlar que el precio mayorista no sea mayor al precio minorista
			ejem: alter table libros add constraint CK_libros_preciominmay check (preciomay<=preciomin)
		
		Las condiciones para restricciones "check" tambien pueden pueden incluir un patron o una lista de valores. 
		Por ejemplo establecer que cierto campo conste de 4 caracteres, 2 letras y 2 digitos
			ejem: alter table libros add constraint CK_libros_nombre check (CAMPO like '[A-Z][A-Z][0-9][0-9]');

		O establecer que cierto campo asuma solo los valores que se listan
			ejem: alter table libros add constraint CK_libros_dias check (CAMPO in ('lunes','miercoles','viernes'));

-------------- 1.4. DESAHBILITAR RESTRICCION CAMPO (WITH CHECK - NO CHECK) --------------
	La restriccion "check" a una tabla para que SQL Server acepte los valores ya almacenados que infringen la restriccion. 
	Para ello debemos incluir la opcion "with nocheck" en la instruccion "alter table"
		ejem: alter table libros with nocheck add constraint CK_libros_precio check (precio>=0);
	
		La restriccion no se aplica en los datos existentes, pero si intentamos ingresar un nuevo valor que no cumpla la restriccion, SQL Server no lo permite

	Para evitar la comprobacion de datos existentes al crear la restriccion, la sintaxis basica es la siguiente
		sintaxis: alter table TABLA with nocheck add constraint NOMBRERESTRICCION check (CONDICION);

	Tambien podemos deshabilitar las restricciones para agregar o actualizar datos sin comprobarla:
		ejem: alter table libros nocheck constraint CK_libros_precio;

	Para habilitar una restriccion deshabilitada se ejecuta la misma instruccion pero con la clausula "check" o "check all":
		ejem: alter table libros check constraint CK_libros_precio;

	Si se emplea "check constraint all" no se coloca nombre de restricciones, habilita todas las restricciones que tiene la tabla nombrada

	Para saber si una restriccion esta habilitada o no, podemos ejecutar el procedimiento almacenado "sp_helpconstraint" y fijarnos lo que informa la columna "status_enabled".

-------------- 1.5. RESTRICCION TABLA(PRIMARY KEY) --------------
	Hemos visto las restricciones que se aplican a los campos, "default" y "check".
	Ahora veremos las restricciones que se aplican a las tablas, que aseguran valores unicos para cada registro.
	-- PRIMARY KEY
		Para establecer una clave primaria para una tabla empleabamos la siguiente sintaxis al crear la tabla, por ejemplo:
			ejem: create table libros(codigo int not null, titulo varchar(30),primary key(codigo));
		
		Podemos agregar una restriccion "primary key" a una tabla existente con la sintaxis basica siguiente:
			ejem: alter table NOMBRETABLA add constraint NOMBRECONSTRAINT primary key (CAMPO);

			En el siguiente ejemplo definimos una restriccion "primary key" para nuestra tabla "libros"
				ejem: alter table libros add constraint PK_libros_codigo primary key(codigo);
		
		Por convencion, cuando demos el nombre a las restricciones "primary key" seguiremos el formato 
			sintaxis: PK_NOMBRETABLA_NOMBRECAMPO
		
-------------- 1.6. RESTRICCION TABLA(UNIQUE) --------------
	La restriccion "unique" impide la duplicacion de claves alternas (no primarias), es decir, especifica que dos registros no puedan tener el mismo valor en un campo. 
	Se permiten valores nulos. Se pueden aplicar varias restricciones de este tipo a una misma tabla, y pueden aplicarse a uno o varios campos que no sean clave primaria.

	Se emplea cuando ya se establecio una clave primaria (como un numero de legajo) pero se necesita asegurar que otros datos 
	tambien sean unicos y no se repitan (como numero de documento).

		sintaxis: alter table NOMBRETABLA add constraint NOMBRERESTRICCION unique (CAMPO);
		ejem: alter table alumnos add constraint UQ_alumnos_documento unique (documento);
		
		En el ejemplo anterior se agrega una restriccion "unique" sobre el campo "documento" de la tabla "alumnos"
		Esto asegura que no se pueda ingresar un documento si ya existe. Esta restriccion permite valores nulos

		Por convencion, cuando demos el nombre a las restricciones "unique" seguiremos la misma estructura
			sintaxis: UQ_NOMBRETABLA_NOMBRECAMPO

-------------- 1.7. INFORMACION DE RESTRICCIONES TABLA(sp_helpconstraint) --------------
	El procedimiento almacenado "sp_helpconstraint" seguido del nombre de una tabla muestra la informacion referente a todas las restricciones establecidas en dicha tabla, 
	devuelve las siguientes columnas:
		- constraint_type: tipo de restriccion. Si es una restriccion de campo (default o check) indica sobre que campo fue establecida. 
			Si es de tabla (primary key o unique) indica el tipo de indice creado.
		- constraint_name: nombre de la restriccion.
		- delete_action: solamente es aplicable para restricciones de tipo "foreign key".
		- update_action: solo es aplicable para restricciones de tipo "foreign key".
		- status_enabled: solamente es aplicable para restricciones de tipo "check" y "foreign key". 
			Indica si esta habilitada (Enabled) o no (Disabled). Indica "n/a" en cualquier restriccion para la que no se aplique.
		- status_for_replication: solamente es aplicable para restricciones de tipo "check" y "foreign key". Indica "n/a" en cualquier restriccion para la que no se aplique.
		- constraint_keys: Si es una restriccion "check" muestra la condicion de chequeo; si es una restriccion "default", el valor por defecto
			Si es una "primary key" o "unique" muestra el/ los campos a los que se aplicaron la restriccion.

-------------- 1.8. ELIMINAR RESTRICCIONES TABLA(sp_helpconstraint) --------------
	Para eliminar una restriccion, la sintaxis basica es la siguiente:
		sintaxis: alter table NOMBRETABLA drop NOMBRERESTRICCION;
	
	Para eliminar la restriccion "DF_libros_autor" de la tabla libros tipeamos:
		ejem: alter table libros drop DF_libros_autor;
	
	Pueden eliminarse varias restricciones con una sola instruccion separandolas por comas.
	Cuando eliminamos una tabla, todas las restricciones que fueron establecidas en ella, se eliminan tambien

---------------------------- 2. REGLAS (RULES) --------------
	Las reglas especifican los valores que se pueden ingresar en un campo, asegurando que los datos se encuentren en un intervalo de valores especifico
	coincidan con una lista de valores o sigan un patron, Una regla se asocia a un campo de una tabla, un campo puede tener solamente UNA regla asociado a el
		SQL Server NO controla los datos existentes para confirmar que cumplen con la regla como lo hace al aplicar restricciones
		Si no los cumple, la regla se asocia igualmente; pero al ejecutar una instruccion "insert" o "update" muestra un mensaje de error
		Actua en inserciones y actualizaciones.
	Podemos dejar un comentario para identificar que hace una regla, al ponerlo con "--" antes de ejecutar create

	Sintaxis basica es la siguiente:
		sintaxis: create rule NOMBREREGLA as @VARIABLE CONDICION
	Por convencion, nombraremos las reglas comenzando con "RG"

	Creamos una regla para restringir los valores que se pueden ingresar en un campo "sueldo" de una tabla llamada "empleados", estableciendo un intervalo de valores:
		ejem: create rule RG_sueldo_intervalo as @sueldo between 100 and 1000
	
	Luego de crear la regla, debemos asociarla a un campo ejecutando un procedimiento almacenado del sistema empleando la siguiente sintaxis basica:
		exec sp_bindrule NOMBREREGLA, 'TABLA.CAMPO';

		Asociamos la regla creada anteriormente al campo "sueldo" de la tabla "empleados":
		ejem: exec sp_bindrule RG_sueldo_intervalo, 'empleados.sueldo'
	
	La funcion que cumple una regla es basicamente la misma que una restriccion "check", las siguientes caracteristicas explican algunas diferencias entre ellas:
		- Podemos definir varias restricciones "check" sobre un campo, un campo solamente puede tener una regla asociada a el
		- Una restriccion "check" se almacena con la tabla, cuando esta se elimina, las restricciones tambien se borran. 
			Las reglas son objetos diferentes e independientes de las tablas, si eliminamos una tabla, las reglas siguen existiendo en la base de datos
		- Una restriccion "check" puede incluir varios campos; una regla puede asociarse a distintos campos
		- Una restriccion "check" puede hacer referencia a otros campos de la misma tabla, una regla no

	Recuerde que las reglas son objetos independientes de las tablas (no se eliminan al borrar la tabla), asi que debemos eliminarlas con las siguientes intrucciones
		if object_id ('RG_documento_patron') is not null drop rule RG_documento_patron

	EJEMPLOS:
		create table empleados (
			documento varchar(8) not null,
			nombre varchar(30),
			seccion varchar(20),
			fechaingreso datetime,
			fechanacimiento datetime,
			hijos tinyint,
			sueldo decimal(6,2)
		);
			VARCHAR - Creamos una regla que establezca un patron para el documento:
				create rule RG_documento_patron as @documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';
					exec sp_bindrule RG_documento_patron, 'empleados.documento';
			VARCHAR - Creamos una regla para restringir los valores que se pueden ingresar en un campo "seccion":
				create rule RG_empleados_seccion as @seccion in ('Secretaria','Contaduria','Sistemas','Gerencia');
					exec sp_bindrule RG_empleados_seccion, 'empleados.seccion';
			DATETIME - Creamos una regla para restringir los valores que se pueden ingresar en el campo "fechaingreso", para que no sea posterior a la fecha actual:
				create rule RG_empleados_fechaingreso as @fecha <= getdate();
					exec sp_bindrule RG_empleados_fechaingreso, 'empleados.fechaingreso';
					exec sp_bindrule RG_empleados_fechaingreso, 'empleados.fechanacimiento';
			INT - Creamos una regla para restringir los valores que se pueden ingresar en el campo "hijos":
				create rule RG_hijos as @hijos between 0 and 20;
					exec sp_bindrule RG_hijos, 'empleados.hijos';
			DECIMAL - Creamos una regla para restringir los valores que se pueden ingresar en un campo "sueldo":
				create rule RG_empleados_sueldo as @sueldo>0 and @sueldo<= 5000;
					exec sp_bindrule RG_empleados_sueldo, 'empleados.sueldo';
	
	Para eliminar una regla, primero se debe deshacer la asociacion, ejecutando el procedimiento almacenado del sistema "sp_unbindrule":
		sintaxis: exec sp_unbindrule 'TABLA.CAMPO'
	No es posible eliminar una regla si esta asociada a un campo. Si intentamos hacerlo, aparece un mensaje de error y la eliminacion no se realiza
	Con la instruccion "drop rule" eliminamos la regla:
		sintaxis: drop rule NOMBREREGLA

	Quitamos la asociacion de la regla "RG_sueldo_intervalo" con el campo "sueldo" de la tabla "empleados" tipeando:	
		ejem: exec sp_unbindrule 'empleados.sueldo';
	Luego de quitar la asociacion la eliminamos:
		ejem drop rule RG_sueldo_100a1000;
	

	Podemos utilizar el procedimiento almacenado "sp_help" con el nombre del objeto del cual queremos informacion, en este caso el nombre de una regla:
		sintaxis: exec sp_help NOMBREREGLA;

		sintaxis: exec sp_helpconstraint NOMBRETABLA;
			- constraint_type: indica que es una regla con "RULE", nombrando el campo al que esta asociada
			- constraint_name: nombre de la regla
			- constraint_keys: muestra el texto de la regla
	
	select * from sysobjects -> Nos muestra el nombre y varios datos de todos los objetos de la base de datos actual. La columna "xtype" indica el tipo de objeto, en caso de ser una regla aparece el valor "R"
	select * from sysobjects where xtype='R' and-- tipo regla name like 'RG%';--busqueda con comodin

	Para ver el texto de una regla empleamos el procedimiento almacenado "sp_helptext" seguido del nombre de la regla:
		sintaxis: exec sp_helptext NOMBREREGLA;

---------------------------- 3. VALORES PREDETERMINADOS (CREATE DEFAULT) --------------

	Los valores predeterminados se asocian con uno o varios campos (o tipos de datos definidos por el usuario) Se definen una sola vez y se pueden usar muchas veces
		sintaxis: create default NOMBREVALORPREDETERMINADO as VALORPREDETERMINADO;

		"VALORPREDETERMINADO" no puede hacer referencia a campos de una tabla (u otros objetos) y debe ser compatible con el tipo de datos y longitud del campo al cual se asocia
		Si esto no sucede, SQL Server no lo informa al crear el valor predeterminado ni al asociarlo, pero al ejecutar una instruccion "insert" muestra un mensaje de error.
		En el siguiente ejemplo creamos un valor predeterminado llamado "VP_datodesconocido' con el valor "Desconocido"
			ejem: create default VP_datodesconocido as 'Desconocido'

			Luego de crear un valor predeterminado, debemos asociarlo a un campo (o a un tipo de datos definido por el usuario) ejecutando el procedimiento almacenado: 
				sintaxis:  exec sp_bindefault NOMBRE, 'NOMBRETABLA.CAMPO';
				ejem: create default VP_datodesconocido as 'Desconocido' -> creamos un valor predeterminado llamado "VP_datodesconocido' con el valor "Desconocido"
				ejem: exec sp_bindefault VP_datodesconocido, 'empleados.domicilio'; -> Asocia el valor predeterminado creado anteriormente al campo "domicilio" de la tabla "empleado"

			Podemos asociar un valor predeterminado a varios campos. Asociamos el valor predeterminado "VP_datodesconocido" al campo "barrio" de la tabla "empleados":
				ejem: exec sp_bindefault VP_datodesconocido, 'empleados.barrio';
		
		La funcion que cumple un valor predeterminado es basicamente la misma que una restriccion "default"
		Las siguientes caracteristicas explican algunas semejanzas y diferencias entre ellas:
			- un campo solamente puede tener definida UNA restriccion "default", un campo solamente puede tener UN valor predeterminado asociado a el
			- una restriccion "default" se almacena con la tabla, cuando esta se elimina, las restricciones tamben. 
				Los valores predeterminados son objetos diferentes e independientes de las tablas, si eliminamos una tabla, las asociaciones desaparecen, 
				pero los valores predeterminados siguen existiendo en la base de datos
			- una restriccion "default" se establece para un solo campo; un valor predeterminado puede asociarse a distintos campos (inclusive, de diferentes tablas)
			- No se puede asociar un valor predeterminado a un campo que tiene una restriccion "default"

			Veamos otros ejemplos.
				Creamos un valor predeterminado que inserta el valor "0" en un campo de tipo numerico
					ejem: create default VP_cero as 0
				En el siguiente creamos un valor predeterminado que inserta ceros con el formato valido para un numero de telefono:
					ejem: create default VP_telefono as '(0000)0-000000';
		
		Para deshacer una asociacion empleamos el procedimiento almacenado "sp_unbindefault" seguido de la tabla y campo al que esta asociado:
			sintaxis: exec sp_unbindefault 'TABLA.CAMPO';
			
				Quitamos la asociacion al campo "sueldo" de la tabla "empleados"
					ejem: exec sp_unbindefault 'empleados.sueldo'
				
			Con la instruccion "drop default" podemos eliminar un valor predeterminado
				sintaxis: drop default NOMBREVALORPREDETERMINADO
				
				Eliminamos el valor predeterminado llamado "VP_cero"
					ejem: drop default VP_cero;
*/

/*------------------------------------------ INDICES ------------------------------------------
	El objetivo de un indice es acelerar la consulta de informacion. 
	La indexacion es una tecnica que optimiza el acceso a los datos, mejora el rendimiento acelerando las consultas y otras operaciones. 
	Es util cuando la tabla contiene miles de registros, cuando se realizan operaciones de ordenamiento y agrupamiento y cuando se combinan varias tablas
	SQL Server accede a los datos de dos maneras:
		Recorriendo las tablas --> Comenzando el principio y extrayendo los registros que cumplen las condiciones de la consulta
		Empleando indices --> Recorriendo la estructura de arbol del indice para localizar los registros y extrayendo los que cumplen las condiciones de la consulta
	Los indices se emplean para facilitar la obtencion de informacion de una tabla
	El indice de una tabla desempena la misma funcion que el indice de un libro: permite encontrar datos rapidamente
		Una tabla se indexa por un campo (o varios)
		Un indice posibilita el acceso directo y rapido haciendo mas eficiente las busquedas
		Sin indice, SQL Server debe recorrer secuencialmente toda la tabla para encontrar un registro
	La desventaja es que consume espacio en el disco y genera costo de mantenimiento (tiempo y recursos)
	SQL Server permite crear dos tipos de indices: 1) agrupados y 2) no agrupados
	-- 1. INDICE AGRUPADO (CLUSTERED)
		Es similar a una guia telefonica, los registros con el mismo valor de campo se agrupan juntos
		Un indice agrupado determina la secuencia de almacenamiento de los registros en una tabla
		Se utilizan para campos por los que se realizan busquedas con frecuencia o se accede siguiendo un orden
		Una tabla solo puede tener UN indice agrupado
	-- 2. INDICE NO AGRUPADO (NONCLUSTERED)
		Es como el indice de un libro, los datos se almacenan en un lugar diferente al del indice, 
		los punteros indican el lugar de almacenamiento de los elementos indizados en la tabla
		Un indice no agrupado se emplea cuando se realizan distintos tipos de busquedas frecuentemente, con campos en los que los datos son unicos
		Una tabla puede tener hasta 249 indices no agrupados
	
	Es recomendable crear los indices agrupados antes que los no agrupados, porque los primeros modifican el orden fisico de los registros, ordenandolos secuencialmente
	Resumiendo, los indices facilitan la recuperacion de datos, permitiendo el acceso directo y acelerando las busquedas, consultas y otras operaciones que optimizan el rendimiento general

----------------- 1. CREACION DE INDICES
		La sintaxis basica es la siguiente:
			sintaxis: create TIPODEINDICE index NOMBREINDICE on TABLA(CAMPO);
				"TIPODEINDICE" indica si es agrupado (clustered) o no agrupado (nonclustered). Si no especificamos crea uno No agrupado
		
		En este ejemplo se crea un indice agrupado unico para el campo "codigo" de la tabla "libros":
			ejem: create unique clustered index I_libros_codigo on libros(codigo);
				Para identificar los indices facilmente, podemos agregar un prefijo al nombre del indice, por ejemplo "I" y luego el nombre de la tabla y/o campo

		En este ejemplo se crea un indice no agrupado para el campo "titulo" de la tabla "libros":
			ejem: create nonclustered index I_libros_titulo on libros(titulo);

		Un indice puede tener mas de un campo como clave, son indices compuestos
		Los campos de un indice compuesto tienen que ser de la misma tabla (excepto cuando se crea en una vista)

			Creamos un indice compuesto para el campo "autor" y "editorial":
			ejem: create index I_libros_autoreditorial on libros(autor,editorial);
		
		SQL Server crea automaticamente indices cuando se establece una restriccion "primary key" o "unique" en una tabla. 
		Al crear una restriccion "primary key", si no se especifica, el indice sera agrupado (clustered) a menos que ya exista un indice agrupado para dicha tabla. 
		Al crear una restriccion "unique", si no se especifica, el indice sera no agrupado (non-clustered)

		Para ver los indices de una tabla:
		ejem: exec sp_helpindex libros

----------------- 2. REGENERAR INDICES
		Empleando la opcion "drop_existing" junto con "create index" permite regenerar un indice, con ello evitamos eliminarlo y volver a crearlo. 
		La sintaxis es la siguiente:
-			sintaxis: create TIPODEINDICE index NOMBREINDICE on TABLA(CAMPO) with drop_existing;

		Tambien podemos modificar alguna de las caracteristicas de un indice con esta opcion
			- tipo: cambiandolo de no agrupado a agrupado (siempre que no exista uno agrupado para la misma tabla)
				No se puede convertir un indice agrupado en No agrupado
			- campo: se puede cambiar el campo por el cual se indexa, agregar campos, eliminar algun campo de un indice compuesto
			- unico: se puede modificar un indice para que los valores sean unicos o dejen de serlo
		
		En este ejemplo se crea un indice no agrupado para el campo "titulo" de la tabla "libros":
			ejem: create nonclustered index I_libros on libros(titulo)
		
		Regeneramos el indice "I_libros" y lo convertimos a agrupado:
			ejem: create clustered index I_libros on libros(titulo) with drop_existing;

		Agregamos un campo al indice "I_libros": 
			ejem: create clustered index I_libros on libros(titulo,editorial) with drop_existing;

----------------- 3. ELIMINAR INDICES
		Los indices creados con "create index" se eliminan con "drop index"; la siguiente es la sintaxis basica:
			sintaxis: drop index NOMBRETABLA.NOMBREINDICE;
		Eliminamos el indice "I_libros_titulo":
			ejem: drop index libros.I_libros_titulo;
		
		Podemos averiguar si existe un indice para eliminarlo, consultando la tabla del sistema "sysindexes":
			if exists (select name from sysindexes where name = 'NOMBREINDICE') drop index NOMBRETABLA.NOMBREINDICE;
		Eliminamos el indice "I_libros_titulo" si existe:
			if exists (select *from sysindexes where name = 'I_libros_titulo') drop index libros.I_libros_titulo
*/
/*------------------------------------------ VARIAS TABLAS (JOIN) ------------------------------------------
	Un join es una operacion que relaciona dos o mas tablas para obtener un resultado que incluya datos (campos y registros) de ambas
	Las tablas participantes se combinan segun los campos comunes a ambas tablas
	Hay tres tipos de combinaciones:
		- combinaciones internas (INNER JOIN o JOIN)
		- combinaciones externas (LEFT JOIN - RIGHT JOIN - FULL JOIN)
		- combinaciones cruzadas (CROSS JOIN)
	Para evitar la repeticion de datos y ocupar menos espacio, se separa la informacion en varias tablas. 
	Cada tabla almacena parte de la informacion que necesitamos registrar

	Por ejemplo, los datos de nuestra tabla "libros" podrian separarse en 2 tablas, una llamada "libros" y otra "editoriales" que guardara la informacion de las editoriales
*/
	create table libros(
		codigo int identity,
		titulo varchar(40) not null,
		autor varchar(30) not null default 'Desconocido',
		codigoeditorial tinyint not null,
		precio decimal(5,2),
		primary key (codigo)
	);

	create table editoriales(
		codigo tinyint identity,
		nombre varchar(20) not null,
		primary key(codigo)
	);
/*
	Cuando obtenemos informacion de mas de una tabla decimos que hacemos un "join" (combinacion).
	Veamos un ejemplo:
		ejem: select * from libros join editoriales on libros.codigoeditorial=editoriales.codigo;
--------------- 1. COMBINACION INTERNA (INNER JOIN)
		La combinacion interna emplea "join", que es la forma abreviada de "inner join". 
		Se emplea para obtener informacion de dos tablas y combinar dicha informacion en una salida.
		La sintaxis basica es la siguiente:
			sintaxis: select CAMPOS from TABLA1 join TABLA2 on CONDICIONdeCOMBINACION
			ejem: select * from libros join editoriales on libros.codigoeditorial=editoriales.codigo;

--------------- 2. COMBINACION EXTERNA IZQUIERDA (LEFT JOIN)
		Si queremos saber que registros de una tabla NO encuentran correspondencia en la otra, es decir, no existe valor coincidente en la segunda, 
		necesitamos otro tipo de combinacion, "outer join" (combinacion externa)
		Las combinaciones externas combinan registros de dos tablas que cumplen la condicion, mas los registros de la segunda tabla que no la cumplen; 
		Es decir, muestran todos los registros de las tablas relacionadas, aun cuando no haya valores coincidentes entre ellas

		Se emplea una combinacion externa izquierda para mostrar todos los registros de la tabla de la izquierda. 
		Si no encuentra coincidencia con la tabla de la derecha, el registro muestra los campos de la segunda tabla seteados a "null"

		Entonces, un "left join" se usa para hacer coincidir registros en una tabla (izquierda) con otra tabla (derecha)
		Si un valor de la tabla de la izquierda no encuentra coincidencia en la tabla de la derecha, se genera una fila extra (una por cada valor no encontrado) 
		con todos los campos correspondientes a la tabla derecha seteados a "null". 
		La sintaxis basica es la siguiente:
			sintaxis: select CAMPOS from TABLAIZQUIERDA left join TABLADERECHA on CONDICION
			ejem1: select titulo,nombre from editoriales as e left join libros as l on codigoeditorial = e.codigo
			ejem2: select titulo,nombre from libros as l left join editoriales as e on codigoeditorial = e.codigo

--------------- 3. COMBINACION EXTERNA DERECHA (RIGHT JOIN)
		Una combinacion externa derecha opera del mismo modo solo que la tabla derecha es la que localiza los registros en la tabla izquierda.
		En el siguiente ejemplo solicitamos el titulo y nombre de la editorial de los libros empleando un "right join":
			ejem: select titulo,nombre from libros as l right join editoriales as e on codigoeditorial = e.codigo

		Un "right join" hace coincidir registros en una tabla (derecha) con otra tabla (izquierda)
		Si un valor de la tabla de la derecha no encuentra coincidencia en la tabla izquierda, se genera una fila extra (una por cada valor no encontrado) 
		con todos los campos correspondientes a la tabla izquierda seteados a "null". La sintaxis basica es la siguiente:
		sintaxis: select CAMPOS from TABLAIZQUIERDA right join TABLADERECHA on CONDICION;

--------------- 4. COMBINACION EXTERNA COMPLETA (FULL JOIN)
		Una combinacion externa completa ("full outer join" o "full join") retorna todos los registros de ambas tablas
		Veamos un ejemplo:
			ejem: select titulo,nombre from editoriales as e full join libros as l on codigoeditorial = e.codigo

--------------------------------EJEMPLOS DE COMBINACIONES EXTERNAS
		select titulo,nombre from libros as l left join editoriales as e on codigoeditorial = e.codigo;
		select titulo,nombre from libros as l right join editoriales as e on codigoeditorial = e.codigo;
		select titulo,nombre from editoriales as e full join libros as l on codigoeditorial = e.codigo;

--------------- 5. COMBINACION CRUZADAS (CROSS JOIN)
		Las combinaciones cruzadas (cross join) muestran todas las combinaciones de todos los registros de las tablas combinadas 
		Para este tipo de join no se incluye una condicion de enlace
		Se genera el producto cartesiano en el que el numero de filas del resultado es igual al numero de registros de la primera tabla 
		multiplicado por el numero de registros de la segunda tabla, es decir, si hay 5 registros en una tabla y 6 en la otra, retorna 30 filas
		La sintaxis basica es esta:
			sintaxis: select CAMPOS from TABLA1 cross join TABLA2
			ejem: select titulo,nombre from libros as l cross join editoriales as e

--------------- 6. AUTOCOMBINACION
		Es posible combinar una tabla consigo misma
		Un pequeno restaurante tiene almacenadas sus comidas en una tabla llamada "comidas" que consta de los siguientes campos:
			- nombre varchar(20),
			- precio decimal (4,2) y
			- rubro char(6)-- que indica con 'plato' si es un plato principal y 'postre' si es postre.
				
				Podemos obtener la combinacion de platos empleando un "cross join" con una sola tabla:
					ejem1: select c1.nombre as 'plato principal',c2.nombre as postre,c1.precio+c2.precio as total from comidas as c1 join comidas as c2;
				
				En la consulta anterior aparecen filas duplicadas, para evitarlo debemos emplear un "where": 
					ejem2: select c1.nombre as 'plato principal',c2.nombre as postre,c1.precio+c2.precio as total from comidas as c1 join comidas as c2
						where c1.rubro='plato' and c2.rubro='postre';

--------------- 7. COMBINACIONES CON UPDATE Y DELETE
		Las combinaciones no solo se utilizan con la sentencia "select", tambien podemos emplearlas con "update" y "delete"
		En el siguiente ejemplo aumentamos en un 10% los precios de los libros de cierta editorial, 
		necesitamos un "join" para localizar los registros de la editorial "Planeta" en la tabla "libros"
			ejem: update libros set precio=precio+(precio*0.1) from libros  join editoriales as e on codigoeditorial=e.codigo where nombre='Planeta';
		

		Eliminamos todos los libros de editorial "Emece":
			ejem: delete libros from libros join editoriales on codigoeditorial = editoriales.codigo where editoriales.nombre='Emece';

--------------- 7. COMBINACIONES (UNION - UNION ALL)
	El operador "union" combina el resultado de dos o mas instrucciones "select" en un unico resultado
	Se usa cuando los datos que se quieren obtener pertenecen a distintas tablas y no se puede acceder a ellos con una sola consulta
	No se incluyen las filas duplicadas en el resultado, a menos que coloque la opcion "all"
	Puede dividir una consulta compleja en varias consultas "select" y luego emplear el operador "union" para combinarlas

		Una academia de ensenanza almacena los datos de los alumnos en una tabla llamada "alumnos" y los datos de los profesores en otra denominada "profesores"
		La academia necesita el nombre y domicilio de profesores y alumnos para enviarles una tarjeta de invitacion
		Para obtener los datos necesarios de ambas tablas en una sola consulta necesitamos realizar una union
			ejem1: select nombre, domicilio from alumnos
					union
				select nombre, domicilio from profesores
			
		Para obtener los datos de los datos duplicados entre alumons y profesores
			ejem2: select nombre, domicilio from alumnos
					union all
				select nombre, domicilio from profesores;
		
		Agregar una columna extra a la consulta con el encabezado "condicion" en la que aparezca el literal "profesor" o "alumno" segun si la persona es uno u otro
			ejem3: select nombre, domicilio, 'alumno' as condicion from alumnos
					union
				select nombre, domicilio,'profesor' from profesores
					order by condicion;

*/



/*------------------------------------------ RESTRICCION - LLAVES/CLAVES FORANEAS (FOREIGN KEY) ------------------------------------------
	Un campo que no es clave primaria en una tabla y sirve para enlazar sus valores con otra tabla en la cual es clave primaria se denomina clave foranea, externa o ajena
	Con la restriccion "foreign key" se define un campo (o varios) cuyos valores coinciden con la clave primaria de la misma tabla o de otra

	La siguiente es la sintaxis parcial general para agregar una restriccion "foreign key" 
		sintaxis: alter table NOMBRETABLA1 add constraint NOMBRERESTRICCION foreign key (CAMPOCLAVEFORANEA) references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA);
	
		Para agregar una restriccion "foreign key" al campo "codigoeditorial" de "libros", tipeamos
			ejem: alter table libros add constraint FK_libros_codigoeditorial foreign key (codigoeditorial) references editoriales(codigo)

	Una restriccion "foreign key" no puede modificarse, debe eliminarse y volverse a crear
	

--------------- 1. RESTRICCION FOREIGN KEY (MISMA TABLA)
		Un ejemplo en el cual definimos esta restriccion dentro de la misma tabla
			Una mutual almacena los datos de sus afiliados en una tabla llamada "afiliados"
			Algunos afiliados inscriben a sus familiares. La tabla contiene un campo que hace referencia al afiliado que lo incorporo a la mutual, del cual dependen

				La estructura de la tabla es la siguiente:	
					create table afiliados(
						numero int identity not null,
						documento char(8) not null,
						nombre varchar(30),
						afiliadotitular int,
						primary key (documento),
						unique (numero)
					);
			En caso que un afiliado no haya sido incorporado a la mutual por otro afiliado, el campo "afiliadotitular" almacenara "null"
			Establecemos una restriccion "foreign key" para asegurarnos que el numero de afiliado que se ingrese en el campo "afiliadotitular" exista en la tabla "afiliados"
				ejem: alter table afiliados add constraint FK_afiliados_afiliadotitular foreign key (afiliadotitular) references afiliados (numero)

--------------- 2. RESTRICCION FOREIGN KEY (ACCIONES)
		Si intentamos eliminar un registro de la tabla referenciada por una restriccion "foreign key" cuyo valor de clave primaria existe referenciada 
		en la tabla que tiene dicha restriccion, la accion no se ejecuta y aparece un mensaje de error
		La restriccion "foreign key" tiene las clausulas "on delete" y "on update" que son opcionales
			Las opciones para estas clausulas son las siguientes
				- "no action": indica que si intentamos eliminar o actualizar un valor de la clave primaria de la tabla referenciada (TABLA2) 
						que tengan referencia en la tabla principal (TABLA1), se genere un error y la accion no se realiza
				- "cascade": indica que si eliminamos o actualizamos un valor de la clave primaria en la tabla referenciada (TABLA2), 
						los registros coincidentes en la tabla principal (TABLA1), tambien se eliminen o modifiquen
						Es decir, si eliminamos o modificamos un valor de campo definido con una restriccion "primary key" o "unique", 
						dicho cambio se extiende al valor de clave externa de la otra tabla
		
		La sintaxis completa para agregar esta restriccion a una tabla es la siguiente
			sintaxis: alter table TABLA1 add constraint NOMBRERESTRICCION 
						foreign key (CAMPOCLAVEFORANEA) references TABLA2(CAMPOCLAVEPRIMARIA) on delete OPCION on update OPCION;
		
		Al agregar una foreign key:
			- no se especifica accion para eliminaciones (o se especifica "no action"), y se intenta eliminar un registro de la tabla referenciada (editoriales) 
				cuyo valor de clave primaria (codigo) existe en la tabla principal (libros), la accion no se realiza
			- se especifica "cascade" para eliminaciones ("on delete cascade") y se elimina un registro de la tabla referenciada (editoriales) 
				cuyo valor de clave primaria (codigo) existe en la tabla principal(libros), la eliminacion de la tabla referenciada (editoriales) 
				se realiza y se eliminan de la tabla principal (libros) todos los registros cuyo valor coincide con el registro eliminado de la tabla referenciada (editoriales)
			- no se especifica accion para actualizaciones (o se especifica "no action"), y se intenta modificar un valor de clave primaria (codigo) 
				de la tabla referenciada (editoriales) que existe en el campo clave foranea (codigoeditorial) de la tabla principal (libros), la accion no se realiza
			- se especifica "cascade" para actualizaciones ("on update cascade") y se modifica un valor de clave primaria (codigo) de la tabla referenciada (editoriales) 
				que existe en la tabla principal (libros), SQL Server actualiza el registro de la tabla referenciada (editoriales) y todos los registros coincidentes en la tabla principal (libros)
		
		Veamos un ejemplo. Definimos una restriccion "foreign key" a la tabla "libros" estableciendo el campo "codigoeditorial" como clave foranea 
		que referencia al campo "codigo" de la tabla "editoriales". La tabla "editoriales" tiene como clave primaria el campo "codigo"
			Especificamos la accion en cascada para las actualizaciones y eliminaciones
				ejem: alter table libros add constraint FK_libros_codigoeditorial foreign key (codigoeditorial) references editoriales(codigo) on update cascade on delete cascade
			
			Si luego de establecer la restriccion anterior, eliminamos una editorial de "editoriales" de las cuales hay libros, 
			se elimina dicha editorial y todos los libros de tal editorial. Y si modificamos el valor de codigo de una editorial de "editoriales", 
			se modifica en "editoriales" y todos los valores iguales de "codigoeditorial" de libros tambien se modifican

--------------- 3. RESTRICCION FOREIGN KEY (DESHABILITAR Y ELIMINAR)
		Se pueden deshabilitar las restricciones "check" y "foreign key", a las demas se las debe eliminas
		La sintaxis basica al agregar la restricccion "foreign key" es la siguiente
			sintaxis: alter table NOMBRETABLA1 with OPCIONDECHEQUEO add constraint NOMBRECONSTRAINT foreign key (CAMPOCLAVEFORANEA)
					 references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA) on update OPCION on delete OPCION

			La opcion "with OPCIONDECHEQUEO" especifica si se controlan los datos existentes o no con "check" y "nocheck" respectivamente
			Por defecto, si no se especifica, la opcion es "check"

		En el siguiente ejemplo agregamos una restriccion "foreign key" que controla que todos los codigos de editorial tengan un codigo valido, es decir, 
		Dicho codigo exista en "editoriales". La restriccion no se aplica en los datos existentes pero si en los siguientes ingresos, modificaciones y actualizaciones
			ejem: alter table libros with nocheck add constraint FK_libros_codigoeditorial foreing key (codigoeditorial) references editoriales(codigo)

		La comprobacion de restricciones se puede deshabilitar para modificar, eliminar o agregar datos a una tabla sin comprobar la restriccion
			La sintaxis general es
				sintaxis: alter table NOMBRETABLA OPCIONDECHEQUEO constraint NOMBRERESTRICCION
			
				En el siguiente ejemplo deshabilitamos la restriccion creada anteriormente
					ejem: alter table libros nocheck constraint FK_libros_codigoeditorial
				
				Para habilitar una restriccion deshabilitada se ejecuta la misma instruccion pero con la clausula "check" o "check all"
					ejem: alter table libros check constraint FK_libros_codigoeditorial
		
		Entonces, las clausulas "check" y "nocheck" permiten habilitar o deshabilitar restricciones "foreign key" (y "check")
		Pueden emplearse para evitar la comprobacion de datos existentes al crear la restriccion o para deshabilitar la comprobacion de datos al ingresar, 
		actualizar y eliminar algun registro que infrinja la restriccion

		Podemos eliminar una restriccion "foreign key" con "alter table"
		La sintaxis basica es la misma que para cualquier otra restriccion
			sintaxis: alter table TABLA drop constraint NOMBRERESTRICCION

			Eliminamos la restriccion de "libros"
				ejem: alter table libros drop constraint FK_libros_codigoeditorial

--------------- 4. RESTRICCION FOREIGN KEY (AL CREAR TABLA)
		Hasta el momento hemos agregado restricciones a tablas existentes con "alter table" (manera aconsejada), 
		tambien pueden establecerse al momento de crear una tabla (en la instruccion "create table")

		En el siguiente ejemplo creamos la tabla "libros" con varias restricciones:

			create table libros(
				codigo int identity,
				titulo varchar(40),
				codigoautor int not null,
				codigoeditorial tinyint not null,
				precio decimal(5,2)
				constraint DF_precio default (0),
				constraint PK_libros_codigo
				primary key clustered (codigo),
				constraint UQ_libros_tituloautor
					unique (titulo,codigoautor),
				constraint FK_libros_editorial
				foreign key (codigoeditorial)
				references editoriales(codigo)
				on update cascade,
				constraint FK_libros_autores
				foreign key (codigoautor)
				references autores(codigo)
				on update cascade,
				constraint CK_precio_positivo check (precio>=0)
			);
		
		En el ejemplo anterior creamos:

			- una restriccion "default" para el campo "precio" (restriccion a nivel de campo);
			- una restriccion "primary key" con indice agrupado para el campo "codigo" (a nivel de tabla);
			- una restriccion "unique" con indice no agrupado (por defecto) para los campos "titulo" y "codigoautor" (a nivel de tabla);
			- una restriccion "foreign key" para establecer el campo "codigoeditorial" como clave externa que haga referencia al campo "codigo" de "editoriales 
					y permita actualizaciones en cascada y no eliminaciones (por defecto "no action");
			- una restriccion "foreign key" para establecer el campo "codigoautor" como clave externa que haga referencia al campo "codigo" de "autores" y 
					permita actualizaciones en cascada y no eliminaciones;
			- una restriccion "check" para el campo "precio" que no admita valores negativos
*/

/*------------------------------------------ MODIFICACION TABLAS ------------------------------------------
--------------- 1. AGREGAR Y ELIMINAR CAMPOS (ALTER TABLE - ADD - DROP)
		"ALTER TABLE" permite modificar la estructura de una tabla
		Podemos utilizarla para agregar, modificar y eliminar campos de una tabla

		Para agregar un nuevo campo a una tabla empleamos la siguiente sintaxis basica:
			sintaxis: alter table NOMBRETABLA add NOMBRENUEVOCAMPO DEFINICION
		
			En el siguiente ejemplo agregamos el campo "cantidad" a la tabla "libros", de tipo tinyint, que acepta valores nulos
				ejem: alter table libros add cantidad tinyint
							
			SQL Server no permite agregar campos "not null" a menos que se especifique un valor por defecto
				ejem: alter table libros add autor varchar(20) not null default 'Desconocido'
		
		Para eliminar campos de una tabla la sintaxis basica es la siguiente:
			sintaxis: alter table NOMBRETABLA drop column NOMBRECAMPO

				En el siguiente ejemplo eliminamos el campo "precio" de la tabla "libros"
					ejem: alter table libros drop column precio
				
				Podemos eliminar varios campos en una sola sentencia
					ejem: alter table libros drop column editorial,edicion

--------------- 2. MODIFICAR CAMPOS
		Hemos visto que "alter table" permite modificar la estructura de una tabla. Tambien podemos utilizarla para modificar campos de una tabla
		La sintaxis basica para modificar un campo existente es la siguiente
			sintaxis: alter table NOMBRETABLA alter column CAMPO NUEVADEFINICION

			Modificamos el campo "titulo" extendiendo su longitud y para que NO admita valores nulos
				ejem: alter table libros alter column titulo varchar(40) not null
			
			En el siguiente ejemplo alteramos el campo "precio" de la tabla "libros" que fue definido "decimal(6,2) not null" para que acepte valores nulos
				ejem: alter table libros alter column precio decimal(6,2) null

--------------- 3. AGREGAR CAMPOS Y RESTRICCIONES
		Podemos agregar un campo a una tabla y en el mismo momento aplicarle una restriccion
		Para agregar un campo y establecer una restriccion, la sintaxis basica es la siguiente
			sintaxis: alter table TABLA add CAMPO DEFINICION constraint NOMBRERESTRICCION TIPO

			Agregamos a la tabla "libros", el campo "titulo" de tipo varchar(30) y una restriccion "unique" con indice agrupado
				ejem: alter table libros add titulo varchar(30) constraint UQ_libros_autor unique clustered

			Agregamos a la tabla "libros", el campo "codigo" de tipo int identity not null y una restriccion "primary key" con indice no agrupado
				ejem: alter table libros add codigo int identity not null constraint PK_libros_codigo primary key nonclustered
			
			Agregamos a la tabla "libros", el campo "precio" de tipo decimal(6,2) y una restriccion "check"
				ejem: alter table libros add precio decimal(6,2) constraint CK_libros_precio check (precio>=0)

--------------- 4. CAMPOS CALCULADOS
		Un campo calculado es un campo que no se almacena fisicamente en la tabla
		SQL Server emplea una formula que detalla el usuario al definir dicho campo para calcular el valor segun otros campos de la misma tabla
			Un campo calculado no puede
				- definirse como "not null"
				- ser una subconsulta
				- tener restriccion "default" o "foreign key"
				- insertarse ni actualizarse
			
			Creamos un campo calculado denominado "sueldototal" que suma al sueldo basico de cada empleado la cantidad abonada por los hijos (100 por cada hijo)
				ejem create table empleados(
						documento char(8),
						nombre varchar(10),
						domicilio varchar(30),
						sueldobasico decimal(6,2),
						cantidadhijos tinyint default 0,
						sueldototal as sueldobasico + (cantidadhijos*100)
					)
			
			Tambien se puede agregar un campo calculado a una tabla existente
				sintaxis: alter table NOMBRETABLA add NOMBRECAMPOCALCULADO as EXPRESION
				
				ejem: alter table empleados add sueldototal as sueldo+(cantidadhijos*100)
				
		Los campos de los cuales depende el campo calculado no pueden eliminarse, se debe eliminar primero el campo calculado

--------------- 5.1 TIPO DE DATOS DEFINIDOS POR EL USUARIO (CREAR - INFORMACION)
		Cuando definimos un campo de una tabla debemos especificar el tipo de datos
		Se pueden crear y eliminar tipos de datos definidos por el usuario
		Se emplean cuando varias tablas deben almacenar el mismo tipo de datos en un campo y se quiere garantizar que todas tengan el mismo tipo y longitud
		Para darle un nombre a un tipo de dato definido por el usuario debe considerar las mismas reglas que para cualquier identificador
		No puede haber dos objetos con igual nombre en la misma base de datos

		Para crear un tipo de datos definido por el usuario se emplea el procedimiento almacenado del sistema "sp_addtype". Sintaxis basica
			sintaxis: exec sp_addtype NOMBRENUEVOTIPO, 'TIPODEDATODELSISTEMA', 'OPCIONNULL'
		
			Creamos un tipo de datos definido por el usuario llamado "tipo_documento" que admite valores nulos
				exec sp_addtype tipo_documento, 'char(8)', 'null'

--------------- 5.2 TIPO DE DATOS DEFINIDOS POR EL USUARIO (ASOCIACION DE REGLAS)
		Se puede asociar una regla a un tipo de datos definido por el usuario. Luego de crear la regla se establece la asociacion
		La sintaxis es la siguiente
			sintaxis: exec sp_bindrule NOMBREREGLA, 'TIPODEDATODEFINIDOPORELUSUARIO', 'futureonly'
			El parametro "futureonly" es opcional, especifica que si existen campos (de cualquier tabla) con este tipo de dato, no se asocien a la regla

			SQL Server NO controla los datos existentes para confirmar que cumplen con la regla, si no los cumple, la regla se asocia igualmente
			Pero al ejecutar una instruccion "insert" o "update" muestra un mensaje de error
			Si asocia una regla a un tipo de dato definido por el usuario que tiene otra regla asociada, esta ultima la reemplaza

			Para quitar la asociacion, empleamos el mismo procedimiento almacenado que aprendimos cuando quitamos asociaciones a campos, 
			ejecutamos el procedimiento almacenado "sp_unbindrule" seguido del nombre del tipo de dato al que esta asociada la regla
				ejm: exec sp_unbindrule 'TIPODEDATODEFINIDOPORELUSUARIO'
		
		Si asocia una regla a un campo cuyo tipo de dato definido por el usuario ya tiene una regla asociada, la nueva regla se aplica al campo, 
		pero el tipo de dato continua asociado a la regla. La regla asociada al campo prevalece sobre la asociada al tipo de dato
		Por ejemplo, tenemos un campo "precio" de un tipo de dato definido por el usuario "tipo_precio", este tipo de dato tiene asociada 
		una regla "RG_precio0a99" (precio entre 0 y 99), luego asociamos al campo "precio" la regla "RG_precio100a500" (precio entre 100 y 500)
		Al ejecutar una instruccion "insert" admitira valores entre 100 y 500, es decir, tendra en cuenta la regla asociada al campo, 
		aunque vaya contra la regla asociada al tipo de dato

--------------- 5.3 TIPO DE DATOS DEFINIDOS POR EL USUARIO (VALORES PREDETERMINADOS)
		Se puede asociar un valor predeterminado a un tipo de datos definido por el usuario
		Luego de crear un valor predeterminado, se puede asociar a un tipo de dato definido por el usuario con la siguiente sintaxis
			sintaxis: exec sp_bindefault NOMBREVALORPREDETERMINADO, 'TIPODEDATODEFINIDOPORELUSUARIO','futureonly'
		
			El parametro "futureonly" es opcional, especifica que si existen campos (de cualquier tabla) con este tipo de dato, no se asocien al valor predeterminado
			Si no se especifica este parametro, todos los campos de este tipo de dato, existentes o que se creen posteriormente (de cualquier tabla), quedan asociados al valor predeterminado
		
		Si asocia un valor predeterminado a un tipo de dato definido por el usuario que tiene otro valor predeterminado asociado, el ultimo lo reemplaza
		Para quitar la asociacion, empleamos el mismo procedimiento almacenado que aprendimos cuando quitamos asociaciones a campos
			sintaxis: sp_unbindefault 'TIPODEDATODEFINIDOPORELUSUARIO'	
		
		Un tipo de dato definido por el usuario puede tener un solo valor predeterminado asociado	

--------------- 5.3 TIPO DE DATOS DEFINIDOS POR EL USUARIO (ELIMINAR)
		Podemos eliminar un tipo de dato definido por el usuario con el procedimiento almacenado "sp_droptype"
			sintaxis: exec sp_droptype TIPODEDATODEFINIDOPORELUSUARIO
			
			Eliminamos el tipo de datos definido por el usuario llamado "tipo_documento"
				ejem: exec sp_droptype tipo_documento
		
		Los tipos de datos definidos por el usuario se almacenan en la tabla del sistema "systypes"
		Podemos averiguar si un tipo de dato definido por el usuario existe para luego eliminarlo
			if exists (select *from systypes where name = 'NOMBRETIPODEDATODEFINIDOPORELUSUARIO')
				exec sp_droptype TIPODEDATODEFINIDOPORELUSUARIO
		
		Consultamos la tabla "systypes" para ver si existe el tipo de dato "tipo_documento", si es asi, lo eliminamos
			if exists (select *from systypes where name = 'tipo_documento')
				exec sp_droptype tipo_documento
*/

/*------------------------------------------ SUBCONSULTAS (SUBQUERY) ------------------------------------------
	Una subconsulta (subquery) es una sentencia "select" anidada en otra sentencia "select", "insert", "update" o "delete" (o en otra subconsulta)
	Las subconsultas se emplean cuando una consulta es muy compleja, entonces se la divide en varios pasos logicos y se obtiene el resultado con una unica instruccion 
	y cuando la consulta depende de los resultados de otra consulta
	Las subconsultas se DEBEN incluir entre parentesis
	Puede haber subconsultas dentro de subconsultas, se admiten hasta 32 niveles de anidacion

		Hay tres tipos basicos de subconsultas:
			- las que retornan un solo valor escalar que se utiliza con un operador de comparacion o en lugar de una expresion
			- las que retornan una lista de valores, se combinan con "in", o los operadores "any", "some" y "all"
			- los que testean la existencia con "exists"
		
		Reglas a tener en cuenta al emplear subconsultas:
		- la lista de seleccion de una subconsulta que va luego de un operador de comparacion puede incluir solo una expresion o campo (excepto si se emplea "exists" y "in")
		- si el "where" de la consulta exterior incluye un campo, este debe ser compatible con el campo en la lista de seleccion de la subconsulta
		- no se pueden emplear subconsultas que recuperen campos de tipos text o image
		- las subconsultas luego de un operador de comparacion (que no es seguido por "any" o "all") no pueden incluir clausulas "group by" ni "having"
		- "distinct" no puede usarse con subconsultas que incluyan "group by"
		- no pueden emplearse las clausulas "compute" y "compute by"
		- "order by" puede emplearse solamente si se especifica "top" tambien
		- una vista creada con una subconsulta no puede actualizarse
		- una subconsulta puede estar anidada dentro del "where" o "having" de una consulta externa o dentro de otra subconsulta
		- si una tabla se nombra solamente en un subconsulta y no en la consulta externa, los campos no seran incluidos en la salida 
			(en la lista de seleccion de la consulta externa)


--------------- 1. SUBCONSULTAS COMO EXPRESION
		Una subconsulta puede reemplazar una expresion. Dicha subconsulta debe devolver un valor escalar (o una lista de valores de un campo)
		Las subconsultas que retornan un solo valor escalar se utiliza con un operador de comparacion o en lugar de una expresion
			sintaxis1: select CAMPOS from TABLA where CAMPO OPERADOR (SUBCONSULTA)
			sintaxis2: select CAMPO OPERADOR (SUBCONSULTA) from TABLA

			Si queremos saber el precio de un determinado libro y la diferencia con el precio del libro mas costoso, 
			anteriormente debiamos averiguar en una consulta el precio del libro mas costoso y luego, en otra consulta, 
			calcular la diferencia con el valor del libro que solicitamos. Podemos conseguirlo en una sola sentencia combinando dos consultas
				ejem: select titulo,precio, precio-(select max(precio) from libros) as diferencia from libros where titulo='Uno'

			Queremos saber el titulo, autor y precio del libro mas costoso
				ejem: select titulo,autor, precio from libros where precio = (select max(precio) from libros)

		Se pueden emplear en "select", "insert", "update" y "delete"
		Para actualizar un registro empleando subconsulta la sintaxis basica es la siguiente
			sintaxis: update TABLA set CAMPO=NUEVOVALOR where CAMPO= (SUBCONSULTA)
		
		Para eliminar registros empleando subconsulta empleamos la siguiente sintaxis basica
			sintaxis: delete from TABLA where CAMPO=(SUBCONSULTA)

--------------- 2. SUBCONSULTAS CON IN
		Vimos que una subconsulta puede reemplazar una expresion. Dicha subconsulta debe devolver un valor escalar o una lista de valores de un campo
		Las subconsultas que retornan una lista de valores reemplazan a una expresion en una clausula "where" que contiene la palabra clave "in"
		El resultado de una subconsulta con "in" (o "not in") es una lista. Luego que la subconsulta retorna resultados, la consulta exterior los usa
			La sintaxis basica es la siguiente:
			sintaxis: ...where EXPRESION in (SUBCONSULTA)

			Este ejemplo muestra los nombres de las editoriales que ha publicado libros de un determinado autor
				ejem: select nombre from editoriales where codigo in (select codigoeditorial from libros where autor='Richard Bach')
			
			Podemos reemplazar por un "join" la consulta anterior
				ejem: select distinct nombre from editoriales as e join libros on codigoeditorial=e.codigo where autor='Richard Bach'

--------------- 3. SUBCONSULTAS CON ANY/SOME - ALL
		"any" y "some" son sinonimos. Chequean si alguna fila de la lista resultado de una subconsulta se encuentra el valor especificado en la condicion
		El tipo de datos que se comparan deben ser compatibles
		La sintaxis basica es
			sintaxis: ...VALORESCALAR OPERADORDECOMPARACION ANY (SUBCONSULTA)
		
			Queremos saber los titulos de los libros de "Borges" que pertenecen a editoriales que han publicado tambien libros de "Richard Bach", 
			es decir, si los libros de "Borges" coinciden con ALGUNA de las editoriales que publico libros de "Richard Bach"
				ejem: select titulo from libros where autor='Borges' and codigoeditorial = any 
					(select e.codigo from editoriales as e join libros as l on codigoeditorial=e.codigo where l.autor='Richard Bach')
			
					La consulta interna (subconsulta) retorna una lista de valores de un solo campo luego, 
					la consulta externa compara cada valor de "codigoeditorial" con cada valor de la lista devolviendo los titulos de "Borges" que coinciden
			
			"all" tambien compara un valor escalar con una serie de valores.
			Chequea si TODOS los valores de la lista de la consulta externa se encuentran en la lista de valores devuelta por la consulta interna sintaxis
				sintaxis: VALORESCALAR OPERADORDECOMPARACION all (SUBCONSULTA)

				Veamos otro ejemplo con un operador de comparacion diferente
				Queremos saber si ALGUN precio de los libros de "Borges" es mayor a ALGUN precio de los libros de "Richard Bach"
					ejem: select titulo,precio from libros where autor='Borges' and precio > any (select precio from libros where autor='Bach')
				
				Veamos la diferencia si empleamos "all" en lugar de "any"
					ejem: select titulo,precio from libros where autor='borges' and precio > all (select precio from libros where autor='bach')
					El precio de cada libro de "Borges" es comparado con cada valor de la lista de valores retornada por la subconsulta
					Si cumple la condicion, es decir, si es mayor a TODOS los precios de "Richard Bach" (o al mayor), se lista

--------------- 4. SUBCONSULTAS CORRELACIONADAS
		Un almacen almacena la informacion de sus ventas en una tabla llamada "facturas" en la cual guarda el numero de factura, la fecha y el nombre del cliente 
		y una tabla denominada "detalles" en la cual se almacenan los distintos items correspondientes a cada factura: el nombre del articulo, el precio  y la cantidad
		Se necesita una lista de todas las facturas que incluya el numero, la fecha, el cliente, la cantidad de articulos comprados y el total
			ejem: select f.*, (select count(d.numeroitem) from Detalles as d where f.numero=d.numerofactura) as cantidad,
					(select sum(d.preciounitario*cantidad) from Detalles as d where f.numero=d.numerofactura) as total from facturas as f
				
				El segundo "select" retorna una lista de valores de una sola columna con la cantidad de items por factura (el numero de factura lo toma del "select" exterior)
				El tercer "select" retorna una lista de valores de una sola columna con el total por factura (el numero de factura lo toma del "select" exterior)
				El primer "select" (externo) devuelve todos los datos de cada factura

		A este tipo de subconsulta se la denomina consulta correlacionada
		La consulta interna se evalua tantas veces como registros tiene la consulta externa, se realiza la subconsulta para cada registro de la consulta externa

--------------- 5. SUBCONSULTAS EXISTS y NOT EXISTS
		Los operadores "exists" y "not exists" se emplean para determinar si hay o no datos en una lista de valores
		Estos operadores pueden emplearse con subconsultas correlacionadas para restringir el resultado de una consulta exterior a los registros que 
		cumplen la subconsulta (consulta interior). Estos operadores retornan "true" (si las subconsultas retornan registros) o 
		"false" (si las subconsultas no retornan registros)
		Cuando se coloca en una subconsulta el operador "exists", SQL Server analiza si hay datos que coinciden con la subconsulta, 
		no se devuelve ningun registro, es como un test de existencia
		SQL Server termina la recuperacion de registros cuando por lo menos un registro cumple la condicion "where" de la subconsulta
			La sintaxis basica es la siguiente
				sintaxis: ... where exists (SUBCONSULTA)

				En este ejemplo se usa una subconsulta correlacionada con un operador "exists" en la clausula "where" 
				para devolver una lista de clientes que compraron el articulo "lapiz"
					ejem: select cliente,numero from facturas as f where exists (select * from Detalles as d where f.numero=d.numerofactura and d.articulo='lapiz')

--------------- 6. SUBCONSULTAS SIMIL AUTOCOMBINACION
		Algunas sentencias en las cuales la consulta interna y la externa emplean la misma tabla pueden reemplazarse por una autocombinacion
			Por ejemplo, queremos una lista de los libros que han sido publicados por distintas editoriales
				ejem: select distinct l1.titulo from libros as l1 where l1.titulo in (select l2.titulo from libros as l2 where l1.editorial <> l2.editorial)

			En el ejemplo anterior empleamos una subconsulta correlacionada y las consultas interna y externa emplean la misma tabla
			La subconsulta devuelve una lista de valores por ello se emplea "in" y sustituye una expresion en una clausula "where"
			Con el siguiente "join" se obtiene el mismo resultado
				ejem: select distinct l1.titulo from libros as l1 join libros as l2 on l1.titulo=l2.titulo and l1.autor=l2.autor where l1.editorial<>l2.editorial

			Otro ejemplo: Buscamos todos los libros que tienen el mismo precio que "El aleph" empleando subconsulta
				ejem: select titulo from libros where titulo<>'El aleph' and precio = (select precio from libros where titulo='El aleph')
				La subconsulta retorna un solo valor
			
			Buscamos los libros cuyo precio supere el precio promedio de los libros por editorial
				ejem: select l1.titulo,l1.editorial,l1.precio from libros as l1 where l1.precio > (select avg(l2.precio) from libros as l2 where l1.editorial= l2.editorial)
				Por cada valor de l1, se evalua la subconsulta, si el precio es mayor que el promedio
			
--------------- 7. SUBCONSULTAS EN LUGAR DE UNA TABLA (TABLA DERIVADA)
		Se pueden emplear subconsultas que retornen un conjunto de registros de varios campos en lugar de una tabla
		Se la denomina tabla derivada y se coloca en la clausula "from" para que la use un "select" externo
		La tabla derivada debe ir entre parantesis y tener un alias para poder referenciarla. La sintaxis basica es la siguiente
			sintaxis: select ALIASdeTABLADERIVADA.CAMPO from (TABLADERIVADA) as ALIAS

		La tabla derivada es una subsonsulta
			Podemos probar la consulta que retorna la tabla derivada y luego agregar el "select" externo	
			ejem: select f.*, (select sum(d.precio*cantidad) from Detalles as d where f.numero=d.numerofactura) as total from facturas as f

			La consulta anterior contiene una subconsulta correlacionada. Retorna todos los datos de "facturas" y el monto total por factura de "detalles"
			
			Esta consulta retorna varios registros y varios campos y sera la tabla derivada que emplearemos en la siguiente consulta
				ejem: select td.numero,c.nombre,td.total from clientes as c join (select f.*, (select sum(d.precio*cantidad) 
				from Detalles as d where f.numero=d.numerofactura) as total from facturas as f) as td on td.codigocliente=c.codigo
				
				La consulta anterior retorna, de la tabla derivada (referenciada con "td") el numero de factura y el monto total, y de la tabla "clientes", 
				el nombre del cliente. Note que este "join" no emplea 2 tablas, sino una tabla propiamente dicha y una tabla derivada, que es en realidad una subconsulta

--------------- 8. SUBCONSULTAS UPDATE - DELETE
		La sintaxis basica para realizar actualizaciones con subconsulta es la siguiente
			sintaxis: update TABLA set CAMPO=NUEVOVALOR where CAMPO= (SUBCONSULTA)
			
			Actualizamos el precio de todos los libros de editorial "Emece"
				ejem: update libros set precio=precio+(precio*0.1) where codigoeditorial=(select codigo from editoriales where nombre='Emece')
		
		La sintaxis basica para realizar eliminaciones con subconsulta es la siguiente
			sintaxis: delete from TABLA where CAMPO in (SUBCONSULTA)
			
			Eliminamos todos los libros de las editoriales que tiene publicados libros de "Juan Perez"
				delete from libros where codigoeditorial in (select e.codigo from editoriales as e join libros on codigoeditorial=e.codigo where autor='Juan Perez')

--------------- 9. SUBCONSULTAS	INSERT
		Podemos ingresar registros en una tabla empleando un "select"
		La sintaxis basica es la siguiente
			sintaxis: insert into TABLAENQUESEINGRESA (CAMPOSTABLA1) select (CAMPOSTABLACONSULTADA) from TABLACONSULTADA

		Un profesor almacena las notas de sus alumnos en una tabla llamada "alumnos"
		Tiene otra tabla llamada "aprobados", con algunos campos iguales a la tabla "alumnos" pero en ella solamente almacenara los alumnos que han aprobado el ciclo
			Ingresamos registros en la tabla "aprobados" seleccionando registros de la tabla "alumnos"
				ejem: insert into aprobados (documento,nota) select (documento,nota) from alumnos
			
		La cantidad de columnas devueltas en la consulta debe ser la misma que la cantidad de campos a cargar en el "insert"

--------------- 10. SUBCONSULTAS CREAR TABLA A PARTIR DE OTRA(CREATE TABLE) 
		Podemos crear una tabla e insertar datos en ella en una sola sentencia consultando otra tabla (o varias) con esta sintaxis
			sintaxis: select CAMPOSNUEVATABLA into NUEVATABLA from TABLA where CONDICION
		
		Es decir, se crea una nueva tabla y se inserta en ella el resultado de una consulta a otra tabla
			Tenemos la tabla "libros" de una libreria y queremos crear una tabla llamada "editoriales" que contenga los nombres de las editoriales
			La tabla "editoriales", que no existe, contendra solamente un campo llamado "nombre". La tabla libros contiene varios registros
			Podemos crear la tabla "editoriales" con el campo "nombre" consultando la tabla "libros" y en el mismo momento insertar la informacion
				ejem: select distinct editorial as nombre into editoriales from libros
				
				La tabla "editoriales" se ha creado con el campo "nombre" seleccionado del campo "editorial" de "libros"
				
*/
/*------------------------------------------ VISTAS (VIEWS) ------------------------------------------
		AL MODIFICAR LOS DATOS DE UNA VISTA SE MODIFICAN LOS DATOS DE UNA TABLA
		Una vista es una alternativa para mostrar datos de varias tablas. Una vista es como una tabla virtual que almacena una consulta	
		Los datos accesibles a traves de la vista no estan almacenados en la base de datos como un objeto
		Podemos crear vistas con: 
			- un subconjunto de registros y campos de una tabla
			- una union de varias tablas
			- una combinacion de varias tablas
			- un resumen estadistico de una tabla
			- un subconjunto de otra vista
			- una combinacion de vistas y tablas

		Entonces, una vista almacena una consulta como un objeto para utilizarse posteriormente
		Las tablas consultadas en una vista se llaman tablas base. En general, se puede dar un nombre a cualquier consulta y almacenarla como una vista
		Una vista suele llamarse tambien tabla virtual porque los resultados que retorna y la manera de referenciarlas es la misma que para una tabla

		Las vistas permiten
			- ocultar informacion: permitiendo el acceso a algunos datos y manteniendo oculto el resto de la informacion que no se incluye en la vista
					El usuario opera con los datos de una vista como si se tratara de una tabla, pudiendo modificar tales datos
			- simplificar la administracion de los permisos de usuario: se pueden dar al usuario permisos para que solamente pueda acceder a los datos a traves de vistas, 
					en lugar de concederle permisos para acceder a ciertos campos, asi se protegen las tablas base de cambios en su estructura
			- mejorar el rendimiento: se puede evitar tipear instrucciones repetidamente almacenando en una vista el resultado de una consulta 
					compleja que incluya informacion de varias tablas
		
		Una vista se define usando un "select"
		La sintaxis basica parcial para crear una vista es la siguiente
			sintaxis1: create view NOMBREVISTA as SENTENCIASSELECT from TABLA

			En el siguiente ejemplo creamos la vista "vista_empleados", que es resultado de una combinacion en la cual se muestran 4 campos
				ejem: create view vista_empleados as 
						select (apellido+' '+e.nombre) as nombre,sexo, s.nombre as seccion, cantidadhijos
						from empleados as e join secciones as s on codigo=seccion
			
		Otra sintaxis es la siguiente
			sintaxis2: create view NOMBREVISTA (NOMBRESDEENCABEZADOS) as SENTENCIASSELECT from TABLA
		
			Creamos otra vista de "empleados" denominada "vista_empleados_ingreso" que almacena la cantidad de empleados por anio
				ejem: create view vista_empleados_ingreso (fecha,cantidad) as select datepart(year,fechaingreso),count(*) from empleados group by datepart(year,fechaingreso)
			
		La diferencia es que se colocan entre parentesis los encabezados de las columnas que apareceran en la vista
		Si no los colocamos y empleamos la sintaxis vista anteriormente, se emplean los nombres de los campos o alias colocados en el "select" que define la vista

		Existen algunas restricciones para el uso de "create view", a saber
			- no puede incluir las clausulas "compute" ni "compute by" ni la palabra clave "into"
			- no se pueden crear vistas temporales ni crear vistas sobre tablas temporales
			- no se pueden asociar reglas ni valores por defecto a las vistas
			- no puede combinarse con otras instrucciones en un mismo lote
		
		Se pueden construir vistas sobre otras vistas

--------------- 1. VISTAS (VIEWS) INFORMACION / CREAR VISTAS 

		A partir del object explorer podemos administrar las vistas creadas (modificarlas, borrarlas, renombrarlas etc.)
		El SQL Server Management Studio incluye una herramienta visual para crear vistas mediante la seleccion de tablas y campos, 
		debemos presionar el boton derecho del mouse sobre "View" y seleccionar "New View..."		
		
		https://www.tutorialesprogramacionya.com/sqlserverya/temarios/descripcion.php?inicio=100&cod=110&punto=104

--------------- 2. VISTAS ENCRIPTAR (WITH ENCRYPTION)
		Podemos ver el texto que define una vista ejecutando el procedimiento almacenado del sistema "sp_helptext" seguido del nombre de la vista
			exec sp_helptext NOMBREVISTA
		
		Podemos ocultar el texto que define una vista empleando la siguiente sintaxis al crearla
			sintaxis: create view NOMBREVISTA with encryption as SENTENCIASSELECT from TABLA
		
		"with encryption" indica a SQL Server que codifique las sentencias que definen la vista
			Creamos una vista con su definicion oculta
				ejem: create view vista_empleados with encryption as select (apellido+' '+e.nombre) as nombre,sexo,
						s.nombre as seccion, cantidadhijos from empleados as e join secciones as s on codigo=seccion

--------------- 3. VISTAS ELIMINAR 
		Para quitar una vista se emplea "drop view"
			sintaxis: drop view NOMBREVISTA
		Si se elimina una tabla a la que hace referencia una vista, la vista no se elimina, hay que eliminarla explicitamente
		Solo el propietario puede eliminar una vista

		Antes de eliminar un objeto, se recomienda ejecutar el procedimiento almacenado de sistema "sp_depends" para averiguar si hay objetos que hagan referencia a el
			Eliminamos la vista denominada "vista_empleados"
				ejem: drop view vista_empleados

--------------- 4. VISTAS CON RESTRICCION (WITH CHECK OPTION)
		Es posible obligar a todas las instrucciones de modificacion de datos que se ejecutan en una vista a cumplir ciertos criterios
			Por ejemplo, creamos la siguiente vista
				ejem: create view vista_empleados as select apellido, e.nombre, sexo, s.nombre as seccion 
					from empleados as e join secciones as s on seccion=codigo where s.nombre='Administracion' with check option

				La vista definida anteriormente muestra solamente algunos de los datos de los empleados de la seccion "Administracion"
				Ademas, solamente se permiten modificaciones a los empleados de esa seccion
				Podemos actualizar el nombre, apellido y sexo a traves de la vista, pero no el campo "seccion" porque esta restringuido
					update vista_empleados set nombre='Ana2' where nombre='Marcos'; -- NO LO PERMITIRA ACTUALIZAR DADO QUE NO ES DE ADMIN
					update vista_empleados set nombre='Edinson' where nombre='jhon'; -- LO ACTUALIZA

--------------- 5. VISTAS MODIFICAR TABLAS ATRAVES DE VISTAS
		Si se modifican los datos de una vista, se modifica la tabla base
		Se puede insertar, actualizar o eliminar datos de una tabla a traves de una vista, 
		Teniendo en cuenta lo siguiente, las modificaciones que se realizan a las vistas:
			- no pueden afectar a mas de una tabla consultada. 
			- pueden modificarse datos de una vista que combina varias tablas pero la modificacion solamente debe afectar a una sola tabla
			- no se pueden cambiar los campos resultado de un calculo
			- pueden generar errores si afectan a campos a las que la vista no hace referencia
				Por ejemplo, si se ingresa un registro en una vista que consulta una tabla que tiene campos not null que no estan incluidos en la vista
			- la opcion "with check option" obliga a todas las instrucciones de modificacion que se ejecutan en la vista a cumplir ciertos criterios que se especifican al definir la vista
			- para eliminar datos de una vista solamente UNA tabla puede ser listada en el "from" de la definicion de la misma

--------------- 6. VISTAS MODIFICAR (ALTER VIEW)
		Para modificar una vista puede eliminarla y volver a crearla o emplear "alter view"
		Con "alter view" se modifica la definicion de una vista sin afectar los procedimientos almacenados y los permisos
		Si elimina una vista y vuelve a crearla, debe reasignar los permisos asociados a ella
		
		Sintaxis basica para alterar una vista	
			sintaxis: alter view NOMBREVISTA with encryption--opcional as SELECT

			En el ejemplo siguiente se altera vista_empleados para agregar el campo "domicilio"
				ejem: alter view vista_empleados with encryption as select (apellido+' '+e.nombre) as nombre,sexo, s.nombre as seccion, 
					cantidadhijos,domicilio from empleados as e join secciones as s on codigo=seccion
*/

/*------------------------------------------ LENGUAJE DE CONTROL DE FLUJO (CASE - IF - IFF) ------------------------------------------
--------------- 1. CASE
		La sentencia "case" compara 2 o mas valores y devuelve un resultado
		La sintaxis es la siguiente
			sintaxis: case VALORACOMPARAR 
						when VALOR1 then RESULTADO1 
						when VALOR2 then RESULTADO2  ...
						else RESULTADO3
					end
			
		Por cada valor hay un "when" y un "then"
		Si encuentra un valor coincidente en algun "when" ejecuta el "then" correspondiente a ese "when", si no encuentra ninguna coincidencia, se ejecuta el "else"
		Si no hay parte "else" retorna "null"
		Finalmente se coloca "end" para indicar que el "case" ha finalizado

			Esta es la sentencia
			ejem: select nombre,nota, resultado=
					case nota when 0 then 'libre'
						when 1 then 'libre'
						when 2 then 'libre'
						when 3 then 'libre'
						when 4 then 'regular'
						when 5 then 'regular'
						when 6 then 'regular'
						when 7 then 'promocionado'
						when 8 then 'promocionado'
						when 9 then 'promocionado'
						when 10 then 'promocionado'
					end from alumnos
		
		Tambien se pueden utilizar operadores en la sentencia
			select nombre, nota, condicion=
					case when nota<4 then 'libre'
						when nota >=4 and nota<7 then 'regular'
						when nota>=7 then 'promocionado' 
						else 'sin nota' 
					end from alumnos
--------------- 2. IIF (BEGIN - END - GOTO - IF - ELSE - RETURN - WAITFOR - WHILE - BREAK - CONTINUE)
		Existen palabras especiales que pertenecen al lenguaje de control de flujo que controlan la ejecucion de las sentencias, 
		los bloques de sentencias y procedimientos almacenados
		Tales palabras son: begin... end, goto, if... else, return, waitfor, while, break y continue
			- "begin... end" -> encierran un bloque de sentencias para que sean tratados como unidad
			- "if... else" -> testean una condicion
							Se emplean cuando un bloque de sentencias debe ser ejecutado si una condicion se cumple y si no se cumple, 
							se debe ejecutar otro bloque de sentencias diferente
			- "while": ejecuta repetidamente una instruccion siempre que la condicion sea verdadera
			- "break" y "continue": controlan la operacion de las instrucciones incluidas en el bucle "while"
		
			Veamos un ejemplo. Tenemos nuestra tabla "libros"
			Queremos mostrar todos los titulos de los cuales no hay libros disponibles (cantidad=0), si no hay, mostrar un mensaje indicando tal situacion
				ejem: if exists (select * from libros where cantidad=0) (select titulo from libros where cantidad=0) else select 'No hay libros sin stock'
			
		Podemos emplear "if...else" en actualizaciones
			Por ejemplo, queremos hacer un descuento en el precio, del 10% a todos los libros de una determinada editorial; si no hay, mostrar un mensaje
				ejem: if exists (select * from libros where editorial='Emece')
						begin
							update libros set precio=precio-(precio*0.1) where editorial='Emece'
							select 'libros actualizados'
						end else
						select 'no hay registros actualizados'
		
		A partir de la version 2012 de SQL Server disponemos de la funcion integrada iif
			ejem: select titulo,costo=iif(precio<38,'barato','caro') from libros
*/





















/*------------------------------------------ PROCEDIMIENTOS ALMACENADOS ------------------------------------------
	exec sp_helpconstraint tabla -> Junto al nombre de la tabla, nos muestra informacion acerca de las restricciones de dicha tabla
	exec sp_columns tabla -> Nos muestra el detalle de la estructura de la tabla
	exec sp_tables BD -> 
	exec sp_helpconstraint -> Podemos ver todos los objetos de la base de datos
	exec sp_helpconstraint tabla -> Para saber si una restriccion esta habilitada o no de una tabla
	exec sp_bindrule NOMBREREGLA, 'TABLA.CAMPO' - > Luego de crear la regla, debemos asociarla a un campo ejecutando un procedimiento almacenado del sistema empleando
		exec sp_bindrule RG_sueldo_intervalo, 'empleados.sueldo'
	exec sp_help -> Podemos ver todos los objetos de la base de datos activa, incluyendo las reglas
	exec sp_help NOMBREREGLA -> Podemos utilizar el procedimiento almacenado "sp_help" con el nombre del objeto del cual queremos informacion
	exec sp_unbindrule 'TABLA.CAMPO' -> Quitamos la asociacion de la regla "RG_sueldo_intervalo" con el campo "sueldo" de la tabla "empleados" tipeando:	
		exec sp_unbindrule 'empleados.sueldo'
	select * from sysobjects -> Nos muestra el nombre y varios datos de todos los objetos de la base de datos actual. La columna "xtype" indica el tipo de objeto, en caso de ser una regla aparece el valor "R"
	select * from sysobjects where xtype='R' and-- tipo regla name like 'RG%';--busqueda con comodin

	exec sp_helptext NOMBREREGLA -> Para ver el texto de una regla empleamos el procedimiento almacenado "sp_helptext" seguido del nombre de la regla
	exec sp_bindefault NOMBRE, 'NOMBRETABLA.CAMPO' -> Luego de crear un valor predeterminado, debemos asociarlo a un campo (o a un tipo de datos definido por el usuario)
		exec sp_bindefault VP_datodesconocido, 'empleados.domicilio'
	exec sp_unbindefault 'TABLA.CAMPO' ->  Para deshacer una asociacion
		exec sp_unbindefault 'empleados.domicilio'
	exec sp_help NOMBREVALORPREDETERMINADO
		ejem: exec sp_helpindex libros -> Para ver los indices de una tabla:
		
	exec sp_addtype NOMBRENUEVOTIPO, 'TIPODEDATODELSISTEMA', 'OPCIONNULL'
		ejem: exec sp_addtype tipo_documento, 'char(8)', 'null';
	exec sp_droptype NOMBRENUEVOTIPO
		ejem: exec sp_droptype tipo_documento;
	select name from systypes -> almacena informacion de todos los tipos de datos

	exec sp_depends VISTA -> Aparecen las tablas (y demas objetos) de las cuales depende la vista, es decir, las tablas referenciadas en la misma
	exec sp_helptext VISTA -> Podemos ver la sentencia que se utilizo para crear la vista
*/