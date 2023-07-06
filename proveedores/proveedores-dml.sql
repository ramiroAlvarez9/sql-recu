-- (b) Modifique la relación componentes agregando como atributo la provincia de la ciudad de los Componentes.
ALTER TABLE componentes
ADD COLUMN prov_comp VARCHAR(50);

-- (c) Modifique la relación artículos agregando un atributo que permita guardar el número de serie de cada artículo.
ALTER TABLE articulos
ADD COLUMN nserie INT;

-- d)
UPDATE componentes
SET color = 'Violeta'
WHERE color = 'Rojo';

UPDATE componentes
SET color = 'Marron'
WHERE color = 'Azul';

-- e)
ALTER TABLE componentes
ADD CONSTRAINT CHECK ( color IN ('rojo', 'verde', 'azul', 'violeta', 'marron') );

-- f)
UPDATE proveedores
SET ciudad = 'Bahia Blanca'
WHERE prov_nombre = 'Carlos' OR prov_nombre = 'Eva';

--g)
DELETE FROM envios
WHERE cantidad BETWEEN 200 AND 300 

--h)
-- (h) Elimine los artículos de La Plata.

--DELETE FROM envios
--WHERE id_art IN ( SELECT id_art FROM articulos WHERE ciudad = 'La Plata' );

DELETE FROM articulos
WHERE ciudad = 'La Plata';






















