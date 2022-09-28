# PRACTICA 1 DE BASES DE DATOS - PARCIAL 1

# 1. Mostrar los datos de los empleados que pertenezcan al mismo departamento que ‘GIL’.
SELECT *
FROM emple
WHERE dept_no=(
    SELECT dept_no 
    FROM emple 
    WHERE apellido='GIL');

# 2. Mostrar los datos de los empleados que tengan el mismo oficio que
# ‘CEREZO’. El resultado debe ir ordenado por apellido.
SELECT *
FROM emple
WHERE oficio=(
    SELECT oficio
    FROM emple
    WHERE apellido='CEREZO')
    ORDER BY apellido;

# 3. Mostrar los empleados (nombre, oficio, salario y fecha de alta) que desempeñen 
# el mismo oficio que ‘JIMÉNEZ’ o que tengan un salario mayor o igual que ‘FERNÁNDEZ’.
SELECT apellido, oficio, salario, fecha_alt
FROM emple
WHERE oficio=(
        SELECT oficio
        FROM emple
        WHERE apellido='JIMENEZ')
    OR salario>=(
        SELECT salario
        FROM emple
        WHERE apellido='FERNANDEZ');

# 4. Mostrar en pantalla el apellido, oficio y salario de los empleados del departamento
# de ‘FERNÁNDEZ’ que tengan su mismo salario.
SELECT apellido, oficio, salario
FROM emple
WHERE salario=(
    SELECT salario 
    FROM emple 
    WHERE apellido='FERNANDEZ');

# 5. Mostrar los datos de los empleados que tengan un salario mayor que ‘GIL’ y 
# que pertenezcan al departamento número 10.
SELECT *
FROM emple
WHERE salario >= (
    SELECT salario 
    FROM emple 
    WHERE apellido='GIL')
    AND dept_no=10;

# 6. Mostrar los apellidos, oficios y localizaciones de los departamentos de cada uno 
# de los empleados.
SELECT apellido, oficio, loc 
FROM emple 
JOIN depart 
USING(dept_no);

# 7. Seleccionar el apellido, el oficio y la localidad de los departamentos donde trabajan 
# los ANALISTAS.
SELECT apellido, oficio, loc 
FROM emple 
JOIN depart 
USING(dept_no)
WHERE oficio='ANALISTA';

# 8. Seleccionar el apellido, el oficio y salario de los empleados que trabajan en Madrid.
SELECT apellido, oficio, salario 
FROM emple 
JOIN depart 
USING(dept_no)
WHERE loc='Madrid';

# 9. Seleccionar el apellido, salario y localidad donde trabajan de los empleados que tengan 
# un salario entre 200000 y 300000.
SELECT apellido, salario, loc 
FROM emple 
JOIN depart 
USING(dept_no)
WHERE salario 
    BETWEEN 200000 AND 300000;

# 10. Mostrar el apellido, salario y nombre del departamento de los empleados que tengan el 
# mismo oficio que ‘GIL’.
SELECT apellido, oficio, DNOMBRE 
FROM emple 
JOIN depart 
USING(dept_no)
WHERE oficio=(
    SELECT oficio 
    FROM emple 
    WHERE apellido='GIL');

# 11. Mostrar el apellido, salario y nombre del departamento de los empleados 
# que tengan el mismo oficio que ‘GIL’ y que no tengan comisión.
SELECT apellido, oficio, DNOMBRE 
FROM emple 
JOIN depart 
USING(dept_no)
WHERE oficio=(
    SELECT oficio 
    FROM emple 
    WHERE apellido='GIL')
    AND comision=0;

# 12. Mostrar los datos de los empleados que trabajan en el departamento de contabilidad, 
# ordenados por apellidos.
SELECT *
FROM emple
INNER JOIN depart
USING(dept_no)
    WHERE dnombre='CONTABILIDAD'
    ORDER BY apellido;

# 13. Apellido de los empleados que trabajan en Sevilla y cuyo oficio sea analista o empleado.
SELECT apellido, oficio
FROM emple
INNER JOIN depart
USING(dept_no)
    WHERE loc='SEVILLA'
    AND (oficio='ANALISTA' OR oficio='EMPLEADO');

# 14. Calcula el salario medio de todos los empleados.
SELECT AVG(salario)
FROM emple;

# 15. ¿Cuál es el máximo salario de los empleados del departamento 10?
SELECT salario
FROM emple
WHERE dept_no=10
ORDER BY salario DESC LIMIT 1;

# 16. Calcula el salario mínimo de los empleados del departamento 'VENTAS'.
SELECT salario
FROM emple
INNER JOIN depart
USING(dept_no)
    WHERE dnombre='VENTAS'
ORDER BY salario ASC LIMIT 1;

# 17. Calcula el promedio del salario de los empleados del departamento de 'CONTABILIDAD'.
SELECT AVG(salario)
FROM emple
INNER JOIN depart
USING(dept_no)
WHERE dnombre='CONTABILIDAD';

# 18. Mostrar los datos de los empleados cuyo salario sea mayor que la media de todos los salarios.
SELECT *
FROM emple
INNER JOIN depart
USING(dept_no)
WHERE salario>(
    SELECT AVG(salario) 
    FROM emple);

# 19. ¿Cuántos empleados hay en el departamento número 10?
SELECT COUNT(dept_no)
FROM emple
WHERE dept_no=10;

# 20. ¿Cuántos empleados hay en el departamento de 'VENTAS'?
SELECT COUNT(dept_no)
FROM emple
INNER JOIN depart
USING(dept_no)
WHERE dnombre='VENTAS';

# 21. Calcula el número de empleados que hay que no tienen comisión.
SELECT COUNT(dept_no)
FROM emple
WHERE comision IS NULL;

# 22. Seleccionar el apellido del empleado que tiene máximo salario.
SELECT apellido
FROM emple
ORDER BY salario DESC LIMIT 1;

# 23. Mostrar los apellidos del empleado que tiene el salario más bajo.
SELECT apellido
FROM emple
ORDER BY salario ASC LIMIT 1;

# 24. Mostrar los datos del empleado que tiene el salario más alto en el departamento de 'VENTAS'.
SELECT *
FROM emple
INNER JOIN depart
USING(dept_no)
WHERE dnombre='VENTAS'
ORDER BY salario DESC LIMIT 1;

# 25. A partir de la tabla EMPLE visualizar cuántos apellidos de los empleados empiezan 
# por la letra ‘A’.
SELECT COUNT(apellido)
FROM emple
WHERE apellido LIKE 'A%';

# 26. Dada la tabla EMPLE, obtener el sueldo medio, el número de comisiones no nulas, 
# el máximo sueldo y el sueldo mínimo de los empleados del departamento 30.
SELECT AVG(salario) AS 'SUELDO MEDIO',
    (SELECT COUNT(comision) 
        FROM emple 
        WHERE comision IS NOT NULL 
        AND dept_no=30) AS 'NUM COMISIONES',
    (SELECT salario 
        FROM emple 
        WHERE dept_no=30 
        ORDER BY salario DESC LIMIT 1) AS 'MAX SUELDO',
    (SELECT salario 
        FROM emple 
        WHERE dept_no=30 
        ORDER BY salario ASC LIMIT 1) AS 'MIN SUELDO'
FROM emple
WHERE dept_no=30;