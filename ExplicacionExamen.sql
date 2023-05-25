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

------------------------------------------------------------
Ejemplo de RLIKE



*/


-- Relacion 9

-- Ejercicio 1
/*
select nomde, count(*) from departamentos
left join empleados on departamentos.numde= empleados.numde
group by departamentos.numde;


-- Ejercio 2

select departamentos.numde, departamentos.nomde, empleados.nomem -- , dirigir.fecfindir
from departamentos
left join dirigir on departamentos.numde = dirigir.numdepto
left join empleados on dirigir.numempdirec = empleados.numem
where ifnull(dirigir.fecfindir,curdate()) >= curdate()

union

select distinct departamentos.numde, departamentos.nomde,null-- , dirigir.fecfindir
from departamentos
left join dirigir on departamentos.numde = dirigir.numdepto
left join empleados on dirigir.numempdirec = empleados.numem
where ifnull(dirigir.fecfindir,curdate()) < curdate()
	and departamentos.numde not in (select numde
									from departamentos join dirigir on departamentos.numde = dirigir.numdepto
									where ifnull(dirigir.fecfindir,curdate()) >= curdate()
									);


-- Ejercicio 3

select codreserva , codcasa, feciniestancia, numdiasestancia,null from reservas
where fecanulacion is not null

union

select reservas.codreserva , codcasa, feciniestancia, numdiasestancia, devoluciones.importedevol from reservas
join devoluciones on reservas.codreserva=devoluciones.codreserva
where year(fecanulacion) between year(curdate()) and year(curdate()+1);


select reservas.codreserva, reservas.codcasa, reservas.feciniestancia,
	date_add(reservas.feciniestancia, interval reservas.numdiasestancia day),
	reservas.numdiasestancia,
	ifnull(devoluciones.importedevol, 0)
from reservas left  join devoluciones on reservas.codreserva = devoluciones.codreserva
where year(reservas.fecreserva) = year(curdate()) and
	reservas.fecanulacion is not null;

    -- Ejercicio 4

    select nomcasa,ifnull(count(reservas.codreserva),0) from casas
     join reservas on casas.codcasa= reservas.codcasa
     join zonas on casas.codzona= zonas.numzona
    where zonas.numzona=1
    group by casas.codcasa;

*/
/*
Examen triggers

/* EJER 1 *//*
drop trigger if exists pregDifInsercion;
delimiter $$
create trigger pregDifInsercion
	before insert on preguntas
for each row
begin
	if (select count(*) from preguntas where codtest = new.codtest and textopreg = new.textopreg) > 0 then
	begin
		signal sqlstate '45000' set message_text = 'la pregunta ya existe';
    end;
    end if;

end $$

drop trigger if exists pregDifModificacion $$

create trigger pregDifModificacion
	before update on preguntas
for each row
begin
	if old.textopreg <> new.textopreg
		and (select count(*) from preguntas where codtest = new.codtest and textopreg = new.textopreg) > 0 then
	begin
		set new.textopreg = old.textopreg;
		signal sqlstate '01000' set message_text = 'la pregunta ya existe, por lo que no se modificará';
    end;
    end if;

end $$
delimiter ;

/* EJER 2 */
/* APARTADO A *//*

drop procedure if exists incrementaNotas;
delimiter $$
create procedure incrementaNotas()
begin
	-- update matriculas
	-- set nota = nota + 1
	 select codmateria, nota
	 from matriculas
	where numexped in (select numexped
					   from respuestas
                       where respuestas.codmateria = matriculas.codmateria
					   group by numexped
					   having count(distinct codtest) >= 10); -- para probar he usado >= 2);
end $$
delimiter ;

/* APARTADO B */
/*
drop event if exists subirNotas;
create event subirNotas
on schedule
	every 1 year
    starts '2023/6/20'
    ends '2023/6/20' + interval 10 year
do
	call incrementaNotas();

/* EJER 3 */
/*
drop trigger if exists maxNotaActualiza;
delimiter $$
create trigger maxNotaActualiza
	before insert on matriculas
for each row
begin
	if old.nota <> new.nota and new.nota > 10 then
    begin
		set new.nota = 10;
        signal sqlstate '01000' set message_text = 'Se asignará una nota de 10 ya que la nota no puede ser superior a 10';
    end;
    end if;
end $$

delimiter ;
*/
/* EJER 4 */
/*
El nombre de usuario no debe comenzar por números y debe contener mayúsculas,
minúsculas, números y alguno e los siguientes caracteres especiales: =,_,?,!.
El email debe contener una @, y debe terminar con un punto seguido de 2 o 3 caracteres desde
la ‘a’ a la ‘z’.
El teléfono debe comenzar por 6, 7 o 9 y debe estar formado por 3 grupos de 3 números separados por un espacio
en blanco.
*/
-- Vamos a comprobar nuestros patrones mediante sentencias select:
-- Apartado a:
/*
select  numexped, password
from alumnos
-- where password rlike '.{6}.*' and password rlike '^[^0-9]' and password  rlike '[a-z]+'
-- 	and password rlike '[0-9]+' and password  rlike '[=_?!]+';
where password  rlike '.{6,}' and password rlike '^[^0-9]([a-z])+([0-9])+([=_?!])+'
order by numexped;

select numexped, password
from alumnos
where password rlike '^[^0-9]([a-z]+)([0-9]+)([=_?!]+)(.{6}.*)'
order by numexped;

-- Apartado b:
select *
from alumnos
where -- email rlike '@' and email rlike '([.][a-z]{2,3})$';
			-- email rlike '@' and email rlike '([.][a-z]{2,3})$|([.][a-z]{3})$';
			 -- email rlike '@.*([.][a-z]{2,3})$';
             email rlike ".+@.+([.][a-z]{2,3})$";

-- Apartado c:
select *
from alumnos
where telefono rlike '^[679][0-9]{2} [0-9]{3} [0-9]{3}';

-- Ahora hacemos lo que nos pide realmente el enunciado:

drop trigger if exists insercionAlumnado;
delimiter $$
create trigger insercionAlumnado
	before insert on alumnado
for each row
begin/*
	if /*(new.nomuser not rlike '.{6}.*' or new.nomuser not rlike '^[^0-9]' or new.nomuser not rlike '[a-z]+'
			or new.nomuser not rlike '[0-9]+' or new.nomuser not rlike '[=_?!]+')*//*
		new.password not rlike '^[^0-9]([a-z]+)([=_?!]+)([0-9]+).{3,}' or
		new.email not rlike '@.*([.][a-z]{2,3})$' or
        new.telefono rlike '^[679][0-9]{2} [0-9]{3} [0-9]{3}'
        then
    begin
		set new.nota = 10;
        signal sqlstate '45000' set message_text = 'Los datos del alumno/a no cumplen los requisitos';
    end;
    end if;
end $$

delimiter ;
*/
/* EJER 5 */
/*
drop trigger if exists pregDifInsercion;
delimiter $$
create trigger pregDifInsercion
	before insert on preguntas
for each row
begin
	if (select count(*) from preguntas where codtest = new.codtest and textopreg = new.textopreg) > 0 then
	begin
		signal sqlstate '45000' set message_text = 'la pregunta ya existe';
    end;
    end if;
	if new.resa = new.resb or new.resb = new.resc or new.resa = new.resc then
	begin
		signal sqlstate '45000' set message_text = 'No puede haber dos respuestas iguales en una pregunta';
    end;
    end if;
end $$

drop trigger if exists pregDifModificacion $$

create trigger pregDifModificacion
	before update on preguntas
for each row
begin
	if old.textopreg <> new.textopreg
		and (select count(*) from preguntas where codtest = new.codtest and textopreg = new.textopreg) > 0 then
	begin
		set new.textopreg = old.textopreg;
		signal sqlstate '01000' set message_text = 'la pregunta ya existe, por lo que no se modificará. No se ha ejecutado la inserción';
    end;
    end if;
	if (new.resa <> old.resa or new.resb <> old.resb or new.resc <> old.resc) and
		(new.resa = new.resb or new.resb = new.resc or new.resa = new.resc) then
	begin
		signal sqlstate '45000' set message_text = 'No puede haber dos respuestas iguales en una pregunta. No se ha ejecutado la modificación';
    end;
    end if;

end $$
delimiter ;
*/

/* EJER 1 */

select codtest, nommateria
from tests join materias on tests.codmateria = materias.codmateria
where date_add(feccreacion, interval 3 month) < ifnull(fecpublicacion, curdate());

/* EJER 2 */
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
select obtenNota(1,1);


/* EJER 3*/
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

/* EJER 4 */
select materias.nommateria, materias.cursomateria, respuestas.codtest, respuestas.numexped -- , count(distinct respuestas.codtest)
from materias join tests on materias.codmateria = tests.codmateria
	join respuestas on tests. codtest = respuestas.codtest
group by materias.nommateria
having count(distinct respuestas.numexped) > 2;

/* EJER 5 */

/*
tests que ha hecho cada alumno y materia de dicho test:
*/
select numexped, codtest, codmateria
from respuestas join tests on respuestas.codtest = tests.codtest
    join materias on tests.codmateria = materias.codmateria
/* por tanto: */
select alumnos.numexped, concat_ws(nomalum,ape1alum, ape2alum)
from alumnos join respuestas on alumnos.numexped = respuestas.numexped
    join tests on respuestas.codtest = tests.codtest
    join materias on tests.codmateria = materias.codmateria
where materias.codmateria not in
    (select codmateria
     from matriculas
     where matriculas.numexped = alumnos.numexped);

/* EJER 6*/
drop view if exists catalogoTests;
create view catalogoTests
	(codMateria, NombreMateria, codTest, descripTest, respuestaValida, repetible, numPreguntas)
AS
	select materias.codmateria, materias.nommateria,
		tests.codtest, tests.descrip,
        if(resvalida='a',resa, if(resvalida ='b',resb,resc)),
        if(repetible > 0,'repetible','no repetible'), count(*)
    from materias join tests on materias.codmateria = tests.codmateria
		join preguntas on tests.codtest = preguntas.codtest

	group by materias.codmateria, tests.codtest;

select * from catalogoTests;



/* EJER 7 */
/*
Prepara una función que, dado un alumno/a y una materia, nos devuelva la nota de dicho alumno/a en dicha materia.
La nota se calculará obteniendo la media entre el número de respuestas correctas y el num. de preguntas de cada test
de la materia. Solo se utilizarán los tests no repetibles (estos tendrán en el campo repetible de la tabla
tests el valor 1, indicando así que solo se puede hacer una vez).
Los alumnos que no hayan hecho alguno de los tests no repetibles de la materia,
obtendrán una puntuación de cero en dicho test y esta nota entrará en la media..
*/

drop function if exists obtenNota;
delimiter $$
create function obtenNota
	(numeroExpediente int, codMateria int)
returns decimal(4,2)
deterministic
begin
	declare nota decimal(4,2);
	select count(*)/count(distinct respuestas.codtest) into nota
    from respuestas join preguntas on respuestas.codtest = preguntas.codtest and respuestas.numpreg = preguntas.numpreg
		join tests on tests.codtest = preguntas.codtest
    where numexped = numeroExpediente and tests.codmateria = codMateria
		and tests.repetible = 0 and respuestas.respuesta = preguntas.resvalida;

    return nota;
end $$
delimiter ;
