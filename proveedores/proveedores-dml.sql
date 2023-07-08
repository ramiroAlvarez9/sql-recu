-- (b) Modifique la relación componentes agregando como atributo la provincia de la ciudad de los Componentes.
ALTER TABLE
    componentes
ADD
    COLUMN prov_comp VARCHAR(50);

-- (c) Modifique la relación artículos agregando un atributo que permita guardar el número de serie de cada artículo.
ALTER TABLE
    articulos
ADD
    COLUMN nserie INT;

-- d)
UPDATE
    componentes
SET
    color = 'Violeta'
WHERE
    color = 'Rojo';

UPDATE
    componentes
SET
    color = 'Marron'
WHERE
    color = 'Azul';

-- e)
ALTER TABLE
    componentes
ADD
    CONSTRAINT CHECK (
        color IN ('rojo', 'verde', 'azul', 'violeta', 'marron')
    );

-- f)
UPDATE
    proveedores
SET
    ciudad = 'Bahia Blanca'
WHERE
    prov_nombre = 'Carlos'
    OR prov_nombre = 'Eva';

--g)
DELETE FROM
    envios
WHERE
    cantidad BETWEEN 200
    AND 300 --h)
    -- (h) Elimine los artículos de La Plata.
    --DELETE FROM envios
    --WHERE id_art IN ( SELECT id_art FROM articulos WHERE ciudad = 'La Plata' );
DELETE FROM
    articulos
WHERE
    ciudad = 'La Plata';

/* 
 (a) Obtener todos los detalles de todos los artículos de Bernal.
 
 (b) Obtener todos los valores de id_prov para los proveedores que abastecen el artículo
 T1.
 id_comp
 (c) Obtener de la tabla de artículos los valores de id_art y ciudad donde el nombre de la
 ciudad acaba en D o contiene al menos una E. X
 (d) Obtener los valores de id_prov para los proveedores que suministran para el artículo
 T1 el componente C1.
 (e) Obtener los valores de art_nombre en orden alfabético para los artículos abastecidos
 por el proveedor P1.
 (f) Obtener los valores de id_comp para los componentes suministrados para cualquier
 artículo de Capital Federal.
 (g) Obtener el id_comp del (o los) componente(s) que tienen el menor peso.
 (h) Obtener los valores de idprov para los proveedores que suministran para un artículo
 de La Plata o Capital Federal un componente Rojo.
 (i) Seleccionar el id_prov de los proveedores que nunca suministraron un componente
 verde.
 (j) Obtener, para los envíos del proveedor P2, el número de suministros realizados, el de
 artículos distintos suministrados y la cantidad total.
 (k) Obtener la cantidad máxima suministrada en un mismo envío, para cada proveedor.
 
 (l) Para cada artículo y componente suministrado obtener los valores de id_comp, id_art y la cantidad total correspondiente. X
 
 (m) Seleccionar los nombres de los componentes que son suministrados en una cantidad
 total superior a 500.

 (n) Obtener los identificadores de artículos, id_art, para los que se ha suministrado algún
 componente del que se haya suministrado una media superior a 420 artículos. X
 (ñ) Seleccionar los identificadores de proveedores que hayan realizado algún envío con
 cantidad mayor que la media de los envíos realizados para el componente a que co-
 rresponda dicho envío. X
 (o) Seleccionar los identificadores de artículos para los cuales todos sus componentes se
 fabrican en una misma Ciudad.++
 (p) Seleccionar los identificadores de artículos para los que se provean envíos de todos los
 componentes existentes en la base de datos.

 */


 --a)
 SELECT DISTINCT id_art, art_nombre FROM articulos WHERE ciudad ILIKE 'La Plata';


--b)
SELECT p.id_prov 
FROM proveedor p 
JOIN envios e 
ON  p.id_prov = e.id_prov 
WHERE id_art = 'T1';


--c)

SELECT DISTINCT a.id_art, a.ciudad
FROM articulos a
WHERE ciudad ILIKE '%e%d';


--d)

SELECT DISTINCT p.id_prov 
FROM proveedores p NATURAL JOIN envios e 
WHERE e.id_art = 'T1' AND e.id_comp = 'C1';

--e)

SELECT DISTINCT a.art_nombre
FROM envios e JOIN articulos a 
ON e.id_art = a.id_art 
WHERE e.id_prov = 'P1' 
ORDER BY a.art_nombre;

--f) Obtener los valores de id_comp para los 
--   componentes suministrados para cualquier
--   artículo de Capital Federal.

SELECT DISTINCT e.id_comp 
FROM envios e NATURAL JOIN componentes c NATURAL JOIN articulos a 
WHERE a.ciudad ILIKE 'cap. fed.';   

--g)

SELECT DISTINCT c.id_comp 
FROM componentes c 
WHERE c.peso <= (SELECT MIN(peso) FROM componentes);


--h)

SELECT DISTINCT e.id_prov 
FROM envios e NATURAL JOIN componentes c 
WHERE color ILIKE 'Rojo' AND 
(ciudad ILIKE 'la plata' OR ciudad ILIKE 'Cap%');



--i)

SELECT e.id_prov 
FROM envios e JOIN componentes c 
ON e.id_comp = e.id_comp 
EXCEPT 
SELECT DISTINCT e.id_prov 
FROM envios e JOIN componentes c 
ON e.id_comp = e.id_comp 
WHERE color = 'Verde' ORDER BY e.id_prov;


-- j)

SELECT e.id_prov, e.id_art ,COUNT(DISTINCT id_art) AS articulos_suministrados, 
(SELECT COUNT(DISTINCT id_art) FROM envios) AS cantidad_total
FROM envios e
WHERE e.id_prov = 'P2' GROUP BY e.id_prov, e.id_art;

 -- (k) Obtener la cantidad máxima suministrada en un mismo envío, para cada proveedor.

SELECT e.id_prov, MAX(e.cantidad) AS cantidad_maxima_por_proveedor
FROM envios e 
GROUP BY e.id_prov ORDER BY e.id_prov;

--- l) Para cada artículo y componente suministrado obtener los valores de id_comp, id_art y la cantidad total correspondiente. X

SELECT DISTINCT e.id_comp, e.id_art,  SUM(e.cantidad) AS cantidad_por_art_comp 
FROM envios e 
GROUP BY e.id_comp, e.id_art;


-- (m) Seleccionar los nombres de los componentes que son suministrados en una cantidad total superior a 500.

SELECT e.id_comp, SUM(e.cantidad) AS cant_total_por_comp FROM envios e GROUP BY e.id_comp HAVING SUM(e.cantidad) > 500  ;


--n) Obtener los identificadores de artículos, id_art, para los que se ha suministrado algún componente del que se haya suministrado una media superior a 420 artículos.

SELECT e.id_art 
FROM envios e 
GROUP BY e.id_art HAVING AVG(e.cantidad) > 420;


-- (ñ) Seleccionar los identificadores de proveedores que hayan realizado algún envío con
-- cantidad mayor que la media de los envíos realizados para el componente a que corresponda dicho envío. X

SELECT e.id_prov



 (o) Seleccionar los identificadores de artículos para los cuales todos sus componentes se
 fabrican en una misma Ciudad.



