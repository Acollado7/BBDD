/*
Ejemplos de REGEXP

^: Coincide con el inicio de una cadena.
Ejemplo: SELECT * FROM tabla WHERE columna REGEXP '^abc' busca todas las filas donde la columna comienza con "abc".

$: Coincide con el final de una cadena.
Ejemplo: SELECT * FROM tabla WHERE columna REGEXP 'xyz$' busca todas las filas donde la columna termina con "xyz".

.: Coincide con cualquier carácter, excepto un salto de línea.
Ejemplo: SELECT * FROM tabla WHERE columna REGEXP 'a.b' busca todas las filas donde la columna contiene una "a", seguida de cualquier carácter, y luego una "b".

*: Coincide con cero o más repeticiones del elemento anterior.
Ejemplo: SELECT * FROM tabla WHERE columna REGEXP 'ab*' busca todas las filas donde la columna contiene una "a", seguida de cero o más "b".

+: Coincide con una o más repeticiones del elemento anterior.
Ejemplo: SELECT * FROM tabla WHERE columna REGEXP 'ab+' busca todas las filas donde la columna contiene una "a", seguida de una o más "b".

?: Coincide con cero o una repetición del elemento anterior.
Ejemplo: SELECT * FROM tabla WHERE columna REGEXP 'ab?' busca todas las filas donde la columna contiene una "a" seguida opcionalmente de una "b".

[ ]: Coincide con cualquier carácter dentro de los corchetes.
Ejemplo: SELECT * FROM tabla WHERE columna REGEXP '[aeiou]' busca todas las filas donde la columna contiene una vocal.

[^ ]: Coincide con cualquier carácter que no esté dentro de los corchetes.
Ejemplo: SELECT * FROM tabla WHERE columna REGEXP '[^0-9]' busca todas las filas donde la columna no contiene dígitos numéricos.

(): Agrupa una serie de elementos para que se pueda aplicar un cuantificador a ellos.

|: Coincide con cualquiera de las expresiones separadas por el operador.

{m,n}: Coincide con cualquier carácter que aparezca al menos m veces y no más de n veces.

Ejemplo de Validar el nombre de usuario:

SELECT * FROM tabla WHERE nombre_usuario REGEXP '^[^0-9][A-Za-z0-9=_?!]+$'

------------------------------------------------------------
Ejemplo de Evento

CREATE EVENT optimizaDuracionProyEvent
ON SCHEDULE
    EVERY 3 MONTH
    STARTS CURRENT_DATE + INTERVAL 3 - WEEKDAY(CURRENT_DATE) DAY + INTERVAL 4 DAY
    ENDS CURRENT_DATE + INTERVAL 5 YEAR
DO
    CALL OptimizaDuracionProy();

------------------------------------------------------------
Ejemplo de Trigger

CREATE TRIGGER validar_email_trigger
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.Email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo electrónico no es válido.';
    END IF;
END;

------------------------------------------------------------
Ejemplo de Funcion

drop function if exists obtenCuenta;
delimiter $$
create function obtenCuenta
	(numeroExpediente int)
returns varchar(100)
deterministic
begin
	declare cuenta varchar(100);
	select concat(left(nomalum,1),
	              right(nomalum,1),
	              substring(ape1em,(length(ape1em) div 2),3),
	              month(fecnacim))
	    into cuenta
    from alumnos
    where numexped = numeroExpediente;
    return concat(cuenta,'@micentro.es');
end $$
delimiter ;

------------------------------------------------------------
Ejemplo de Procedimiento

drop procedure if exists exam_u7new_3_2022_2023;
delimiter $$
create procedure exam_u7new_3_2022_2023
	(in codigoExpediente int)
begin
	Select  respuestas.codtest, numrepeticion, count(*)
	from respuestas join preguntas on respuestas.codtest = preguntas.codtest
		and respuestas.numpreg = preguntas.numpreg
	where respuestas.numexped = codigoExpediente
		and respuestas.respuesta = preguntas.resvalida
	group by respuestas.codtest, respuestas.numrepeticion
	having count(*) >= 4;
end $$
delimiter ;

call exam_u7new_3_2022_2023(1);

------------------------------------------------------------
Ejemplo de Select

select codtest, nommateria
from tests join materias on tests.codmateria = materias.codmateria
where date_add(feccreacion, interval 3 month) < ifnull(fecpublicacion, curdate());

*/