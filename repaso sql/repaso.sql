--DDL

-- INSERT INTO --
CARS<id PK INT ,color VARCHAR(55) , brand VARCHAR(55)> 

INSERT INTO cars VALUES 
(1, 'RED', 'FORD')

--Display table:
SELECT * FROM cars;

--insert multiple values

INSERT INTO cars VALUES 
(1, 'BLUE', 'volvo'),
(2,'green', 'toyota'),
(3, 'black', 'volkswagen');

-- ALTER TABLE --
/*
The ALTER TABLE statement is used to add, delete, 
or modify columns in an existing table.
The ALTER TABLE statement is also used to add and 
drop various constraints on an existing table.
*/
-- ADD COLUMN --
ALTER TABLE cars
ADD COLUMN year INT;


-- UPDATE --
-- The UPDATE statement is used to modify the value(s) in existing records in a table.

UPDATE cars
SET color = 'green'
WHERE color = 'red' OR color = 'black';
-- Never forgive use the WHERE clause

-- ALTER COLUMN --
-- ALTER TABLE + ALTER COLUMN --

ALTER TABLE cars 
ALTER COLUMN year TYPE VARCHAR(100);

-- DROP COLUMN --  

ALTER TABLE cars 
DROP COLUMN year;

-- DELETE -- 

DELETE FROM cars 
WHERE brand = 'Ford';

DELETE FROM cars = TRUNCATE TABLE cars -- Truncate it is like DELETE without 
                                       -- WHERE condition.


-- MORE ABOUT DELETE STATEMENT


--DELETE TABLE
DROP TABLE cars;

-----------------------------------------------------------------------------

--DML

-- LIKE --
-- The LIKE operator is used when you want to 
-- return all records where a column is equal to a specified pattern.


SELECT prov_nombre FROM proveedores WHERE prov_nombre LIKE 'J%' ;

-- ILIKE (insensitive LIKE) --

-- IT is equal to LIKE but ILIKE is case insensitive

SELECT prov_nombre FROM proveedores WHERE prov_nombre ILIKE 'j%' ;

-- BETWEEN -- 

SELECT * FROM cars
WHERE year BETWEEN 1970 AND 1980;




-- IS NULL -- 
SELECT * FROM cars
WHERE model IS NULL;

-- NOT (NOT LIKE, NOT ILIKE, NOT IN, NOT BEETWEN, NOT NULL ,IS NOT NULL)
SELECT prov_nombre FROM proveedores WHERE prov_nombre IN('Juan','Carlos');


-- TABLA PROVEEDORES COMO EJEMPLO
-- IN, NOT IN --

SELECT prov_nombre FROM proveedores WHERE prov_nombre IN('Juan','Carlos');

SELECT prov_nombre FROM proveedores WHERE prov_nombre NOT IN('Juan');


-- SELECT DISTINCT -- 

SELECT DISTINCT COUNT(prov_nombre) FROM proveedores;
-- is equal than:
SELECT COUNT (DISTINCT country) FROM proveedores;

-- ORDER BY (ASC by default) --
SELECT id_prov FROM proveedores WHERE id_prov ILIKE 'p%' ORDER BY id_prov DESC;

SELECT DISTINCT id_prov FROM proveedores WHERE id_prov ILIKE 'p%' ORDER BY id_prov;



-- YEAR(date) -- 

SELECT YEAR('01/01/2023') AS year;


-- LIMIT OFFSET --

SELECT * FROM proveedores
LIMIT 3 OFFSET 1;

-- MIN() , MAX()

--min value

SELECT MIN(DISTINCT categoria) FROM proveedores;

SELECT MAX(DISTINCT categoria) FROM proveedores;

-- COUNT -- 

-- cantidad de proveedore


SELECT COUNT(DISTINCT categoria) FROM proveedores;


-- SUM --
-- valor total de una columna;
-- el DISTINCT no funciona en este caso.
SELECT SUM(categoria) FROM 