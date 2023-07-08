-- DDL
-- (a) Modifique la relación trabajador 
-- agregando la edad del mismo.
/*
 
 trabajador <legajo, nombre, tarifa, oficio, legajo_supv>
 edificio   <id_e, dir, tipo, nivel_calidad, categoria>
 asignacion <legajo, id_e, fecha_inicio, num_dias>
 
 (Una fila por cada vez que un trabajador es asignado a un edificio.)
 (b) Modifique la relación edificio agregando un atributo que permita guardar la ciudad
 del edificio.
 (c) Actualice la relación asignaciones incrementando en 4 los números de dias en las
 asignaciones.
 (d) Actualice el nivel de calidad de los edificios que son oficinas cambiando 4 por 5 y la
 categoría de 1 por 4.
 (e) Elimine todos los plomeros.
 (f) Elimine los edificios que son residencias.
 */
ALTER TABLE
    trabajador
ADD
    COLUMN edad INT;

--b)
ALTER TABLE
    trabajador
ADD
    COLUMN ciudad VARCHAR(55);

--c)
UPDATE
    asignacion
SET
    num_dias = num_dias + 4;

--d)
UPDATE
    edificio
SET
    nivel_calidad = 5
WHERE
    tipo ILIKE 'oficina';

UPDATE
    edificio
SET
    categoria = 5
WHERE
    categoria = 4
    AND tipo ILIKE 'ofi%';

--e)
DELETE FROM
    trabajador
WHERE
    oficio ILIKE 'plo%';

--f)
DELETE FROM
    asignacion
WHERE
    id_e IN (
        SELECT
            id_e
        FROM
            edificio
        WHERE
            tipo ILIKE 'residen%'
    );

DELETE FROM
    edificio
WHERE
    tipo ILIKE 'residen%';

--DML

/* 

 trabajador <legajo PK FK, nombre, tarifa, oficio, legajo_supv>

 edificio   <id_e PK , dir, tipo, nivel_calidad, categoria>

 asignacion <FK legajo PK FK, id_e PK FK , fecha_inicio, num_dias>

*/

/*

 (a) Nombre de los trabajadores cuya tarifa está entre 10 y 12 pesos.

 (b) Cuáles son los oficios de los trabajadores asignados al edificio 435?
 
 (c) Indicar el nombre del trabajador y el de su supervisor. X

 (d) Nombre de los trabajadores asignados a oficinas.

 (e) Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor? X

 (f) Cuál es el número total de días que se han dedicado a plomería en el edificio 312?

 (g) Cuántos tipos de oficios diferentes hay? X

 (h) Para cada supervisor, cuál es la tarifa por hora más alta que se paga a un trabajador
     que informa a ese supervisor?

 (i) Para cada supervisor que supervisa a más de un trabajador, cuál es la tarifa más alta
 que se paga a un trabajador que informa a ese supervisor?

 (j) Para cada tipo de edificio, cuál es el nivel de calidad medio de los edificios con cate-
 goría 1? Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
 máximo no mayor que 3.
 
 (k) Qué trabajadores reciben una tarifa por hora menor que la del promedio?

 (l) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
 jadores que tienen su mismo oficio?

 (m) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
 jadores que dependen del mismo supervisor que él?

 (n) Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
 empezaron a trabajar en él.

 (ñ) 
 Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de los
 12 euros?
 */

--a)
SELECT nombre FROM trabajador WHERE tarifa BETWEEN 10 AND 12;
--b)
SELECT DISTINCT oficio FROM trabajador WHERE legajo IN (SELECT legajo FROM asignacion WHERE id_e = 435 );
SELECT DISTINCT t.oficio FROM trabajador t NATURAL JOIN asignacion a WHERE a.id_e = 435; 
--c)
SELECT DISTINCT t.nombre AS trabajador ,sup.nombre AS supervisor FROM trabajador t JOIN trabajador sup ON t.legajo_supv = sup.legajo;

SELECT t.nombre AS trabajador_nombre, s.nombre AS supervisor_nombre FROM trabajador s JOIN trabajador t ON t.legajo_supv = s.legajo ;


--(d) Nombre de los trabajadores asignados a oficinas.
SELECT DISTINCT  nombre FROM trabajador WHERE legajo IN (SELECT legajo FROM edificio NATURAL JOIN asignacion WHERE tipo ILIKE 'ofi%');

trabajador <legajo PK FK, nombre, tarifa, oficio, legajo_supv>
--e) Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor?

SELECT DISTINCT t.nombre AS trabajador FROM trabajador t JOIN trabajador sup ON t.legajo_supv = sup.legajo AND (t.tarifa > sup.tarifa); 

/*
 trabajador <legajo PK FK, nombre, tarifa, oficio, legajo_supv>
 edificio   <id_e PK , dir, tipo, nivel_calidad, categoria>
 asignacion <FK legajo PK FK, id_e PK FK , fecha_inicio, num_dias>
*/

--f) Cuál es el número total de días que se han dedicado a plomería en el edificio 312?

SELECT DISTINCT a.id_e, SUM (num_dias) AS total_dias_trabajados
FROM trabajador t NATURAL JOIN asignacion a
WHERE a.id_e = 312 AND t.oficio ILIKE 'plo%' GROUP BY a.id_e;

-- g) 

SELECT COUNT(DISTINCT oficio) AS cantidad_de_oficios FROM trabajador;

/* 


 trabajador <legajo PK FK, nombre, tarifa, oficio, legajo_supv>
 
 edificio   <id_e PK , dir, tipo, nivel_calidad, categoria>

 asignacion <FK legajo PK FK, id_e PK FK , fecha_inicio, num_dias>

 (h) Para cada supervisor, cuál es la tarifa por hora más alta que se paga a un trabajador
     que informa a ese supervisor? X

 (i) Para cada supervisor que supervisa a más de un trabajador, cuál es la tarifa más alta
 que se paga a un trabajador que informa a ese supervisor? X

 (j) Para cada tipo de edificio, cuál es el nivel de calidad medio de los edificios con cate-
 goría 1? Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
 máximo no mayor que 3. 
 
 (k) Qué trabajadores reciben una tarifa por hora menor que la del promedio? X

 (l) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
 jadores que tienen su mismo oficio?  X

 (m) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
 jadores que dependen del mismo supervisor que él? X

 (n) Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
 empezaron a trabajar en él.
 
 (ñ) 
 Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de los
 12 euros?

*/

-- (j) Para cada tipo de edificio, cuál es el nivel de calidad medio de los edificios con categoría 1? 
-- Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad máximo no mayor que 3. 

SELECT DISTINCT round(AVG(nivel_calidad)) AS nivel_de_calidad_promedio FROM edificio WHERE nivel_calidad <= 3;

-- (k) Qué trabajadores reciben una tarifa por hora menor que la del promedio?

SELECT DISTINCT * FROM trabajador WHERE tarifa < (SELECT avg(tarifa) FROM trabajador);

-- (l) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los trabajadores que tienen su mismo oficio? 

SELECT DISTINCT * FROM trabajador t JOIN 
(SELECT legajo_supv, avg(tarifa) AS promedio 
FROM trabajador GROUP BY oficio
) AS promedio_oficio 
ON (t.oficio = promedio_oficio.promedio)
WHERE t.tarifa < promedio_oficio.promedio;





 -- (n) Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que empezaron a trabajar en él.

 SELECT DISTINCT t.nombre, a.fecha_inicio
 FROM trabajador t 
 NATURAL JOIN asignacion a 
 WHERE id_e = 435;


 -- (enie) Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de los 12 euros?

SELECT DISTINCT sup.nombre AS supervisor , t.nombre AS trabajador, t.tarifa FROM trabajador t JOIN trabajador sup ON t.legajo_supv = sup.legajo AND (t.tarifa > 12);


(l) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
jadores que tienen su mismo oficio?  X

SELECT t1.*
FROM trabajador t1   
WHERE 
t1.tarifa < 
( 
SELECT AVG(tarifa)
FROM trabajador t2
WHERE t1.oficio = t2.oficio 
);




SELECT t1.legajo, t1.nombre, AVG(t1.tarifa) FROM trabajador t1 GROUP BY t1.legajo ;






(m) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
jadores que dependen del mismo supervisor que él?


SELECT t1.*
FROM trabajador AS t1
WHERE t1.tarifa < 
(
	SELECT avg(s.tarifa)
	FROM trabajador AS s
	WHERE t1.legajo_supv = s.legajo_supv
); 














 legajo |    nombre    | tarifa |    oficio    | legajo_supv | edad 
--------+--------------+--------+--------------+-------------+------
   1235 | M. Fernandez |     13 | electricista |        1311 |     
   1311 | C. Garcia    |     16 | electricista |        1311 |     
   1412 | C. Gonzalez  |     14 | plomero      |        1520 |     
   1520 | H. Caballero |     12 | plomero      |        1520 |     
   2920 | R. Perez     |     10 | albanhil     |        2920 |     
   3001 | J. Gutierrez |      8 | carpintero   |        3231 |     
   3231 | P. Alvarez   |     17 | carpintero   |        3231 | 






 id_e |         dir          |    tipo    | nivel_calidad | categoria | ciudad 
------+----------------------+------------+---------------+-----------+--------
  111 | Av. Paseo Colon 1213 | oficina    |             4 |         1 | 
  210 | Rivadavia 1011       | oficina    |             3 |         1 | 
  312 | Tucuman 123          | oficina    |             2 |         2 | 
  435 | Cabildo 456          | comercio   |             1 |         1 | 
  460 | Santa Fe 1415        | almacen    |             3 |         3 | 
  515 | Chile 789            | residencia |             3 |         2 | 










