/* 
 
 alumno <legajo: int PK, apellido: varchar(30), nombre: varchar(30), aniodeingreso: int, trabaja: boolean>
 
 inscripto <cod_curso: varchar(6) PK, legajo: int PK>
 
 curso <cod_curso: varchar(6) PK, legajo_prof: int, cod_materia: varchar(30), dia: varchar(3), turno: int>
  
 profesor <legajo_prof: int PK, cuil: varchar(30), apellido: varchar(30), nombre: varchar(30), marca: varchar(20), aniodeingreso: int,polizaart: varchar(30), salario: int>
 
 materia <cod_materia: varchar(15) PK, materia: varchar(150), semestre: int>
 
 puede_dar <cod_materia: varchar(15) PK, legajo_prof: int PK>
 
 profesor_trabaja_industria <legajo_prof: int PK, sueldo: int>


 Revise el archivo profesores-tpi--creacion.sql para la creación de las tablas. En
 este ejercicio no se proveen las inserciones de prueba.
 
 1. DML

 (a) Listar <cod_curso, legajo, apellido, nombre> donde aparezcan aquellos alumnos y docentes que participan del curso 2 de la materia Bases de Datos. X
 
 (b) Listar el sueldo promedio de los profesores de Bases de Datos y que trabajan en la
 industria.
 
 (c) Listar <legajo-prof, apellido, nombre, añodeingreso> que no pueden dar una materia del semestre 1.
 
 (d) Listar <legajo-prof> que no trabajen en la industria.
 
 (e) Considerando que una materia tiene diferentes profesores en una misma materia, lis-
 tar <cod-materia, salario-promedio> de los profesores de cada materia.
 
 */


 --a)

 SELECT DISTINCT c.cod_curso, a.legajo, a.apellido, a.nombre
 FROM materia m NATURAL JOIN curso c NATURAL JOIN profesor p NATURAL JOIN alumno a WHERE cod_curso ILIKE 'C002' AND (materia = 'base de datos')


 -- b)

-- atr: nombre(profesor),sueldo(profe_trabaja), materia (base de datos)

SELECT DISTINCT AVG(sueldo) AS sueldo_promedio
FROM profesor p NATURAL JOIN profesor_trabaja_industria NATURAL JOIN curso c NATURAL JOIN materia m 
WHERE m.materia = 'Historia';

--Promedio de sueldo profesores que trabajan en la industria.

SELECT DISTINCT p.nombre, AVG(sueldo) AS promedio_salario 
FROM profesor_trabaja_industria pi NATURAL JOIN profesor p 
GROUP BY p.nombre;

--c)


SELECT DISTINCT p.legajo_prof, p.apellido, p.nombre, p.aniodeingreso
FROM profesor p NATURAL JOIN materia m NATURAL JOIN puede_dar
WHERE semestre <> 1;




--d)

SELECT p.legajo_prof FROM profesor p
EXCEPT 
SELECT pi.legajo_prof FROM profesor_trabaja_industria pi;

--e) 
SELECT DISTINCT pd.cod_materia, AVG(salario) AS salario_promedio
FROM profesor p NATURAL JOIN puede_dar pd 
GROUP BY pd.cod_materia;
