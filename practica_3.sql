# PRACTICA 3 DE BASES DE DATOS - PARCIAL 1

# 1. Visualizar el número de empleados de cada departamento. Utilizar GROUP BY para agrupar por departamento. 
SELECT dnombre AS "Departamentos", COUNT(emp_no) AS "# empleados x dep"
FROM emple 
JOIN depart 
USING(dept_no) 
GROUP BY dnombre;

# 2. Visualizar los departamentos con más de 5 empleados. Utilizar GROUP BY para agrupar por departamento 
# y HAVING para establecer la condición sobre los grupos. 
SELECT dnombre AS "Dep con mas de 5 emp" 
FROM emple 
JOIN depart 
USING(dept_no) 
GROUP BY dept_no 
HAVING COUNT(dept_no)>5;

# 3. Hallar la media de los salarios de cada departamento (utilizar la función avg y GROUP BY). 
SELECT dnombre AS "Departamento", AVG(salario) AS "Media salario" 
FROM emple 
JOIN depart 
USING(dept_no) 
GROUP BY dept_no;

# 4. Visualizar el nombre de los empleados vendedores del departamento ʻVENTASʼ 
# (Nombre del departamento=ʼVENTASʼ, oﬁcio=ʼVENDEDORʼ). 
SELECT apellido
FROM emple 
JOIN depart 
USING(dept_no)
WHERE dnombre="Ventas" 
    AND oficio ="Vendedor";

# 5. Visualizar el número de vendedores del departamento ʻVENTASʼ 
# (utilizarla función COUNT sobre la consulta anterior). 
SELECT dnombre AS "DEPARTAMENTO", COUNT(*) AS "# empleados"
FROM emple 
JOIN depart 
USING(dept_no)
WHERE dnombre ='Ventas' 
    AND oficio='Vendedor';

# 6. Visualizar los oﬁcios de los empleados del departamento ʻVENTASʼ. 
SELECT DISTINCT oficio 
FROM emple 
JOIN depart 
USING(dept_no) 
WHERE dnombre='Ventas';

# 7. A partir de la tabla EMPLE, visualizar el número de empleados de cada departamento cuyo 
# oﬁcio sea ʻEMPLEADO ʼ (utilizar GROUP BY para agrupar por departamento. 
# En la cláusula WHERE habrá que indicar que el oﬁcio es ʻEMPLEADOʼ). 
SELECT dept_no, COUNT(*)
FROM emple WHERE oficio='Empleado' 
GROUP BY dept_no;
# 8. Visualizar el departamento con más empleados.
SELECT dnombre AS "Departamento",COUNT(*) AS "Numero de empleados"
FROM emple
JOIN depart
USING(dept_no)
GROUP BY dnombre
HAVING COUNT(dept_no) = (
	SELECT MAX(nemple)
	FROM (
		SELECT COUNT(*) AS nemple
		FROM emple
		JOIN depart
		USING(dept_no)
		GROUP BY dept_no
	) AS cuenta
);

# 9. Mostrar los departamentos cuya suma de salarios sea mayor que la media de salarios de todos los empleados. 
SELECT dnombre "Departamento", SUM(salario) AS "Suma de salarios > a la media total"
FROM emple
JOIN depart
USING(dept_no)
GROUP BY dept_no
HAVING SUM(salario) > (
	SELECT AVG(salario) 
    FROM emple
);

# 10. Para cada oﬁcio obtener la suma de salarios. 
SELECT oficio "Oficio", SUM(salario) AS "Suma de salarios"
FROM emple
GROUP BY oficio;

# 11. Visualizar la suma de salarios de cada oﬁcio del departamento ʻVENTASʼ.
SELECT oficio "Oficio", SUM(salario) AS "Suma de salarios dept Ventas"
FROM emple
GROUP BY oficio, dept_no = "Ventas";

# 12. Visualizar el número de departamento que tenga más empleados cuyo oﬁcio sea empleado. 
SELECT 
	dept_no AS "Num Departamento", 
	dnombre AS "Departamento", 
	COUNT(oficio) AS "Num empleados (oficio empleado)"
FROM emple
JOIN depart
USING(dept_no)
WHERE oficio="Empleado"
GROUP BY dept_no
HAVING COUNT(oficio) = (
	SELECT MAX(nemple)
	FROM (
		SELECT COUNT(*) AS nemple
		FROM emple
        WHERE oficio = "Empleado"
        GROUP BY dept_no
	) AS cuenta
);

# 13. Mostrar el número de oﬁcios distintos de cada departamento.
SELECT 
	dept_no AS "Num departamento", 
    dnombre AS "Departamento", 
    COUNT(DISTINCT oficio) AS "Num oficios distintos" 
FROM emple 
JOIN depart 
USING(dept_no) 
GROUP BY dept_no;

# 14. Mostrar los departamentos que tengan más de dos personas trabajando en la misma profesión.
SELECT 
	dept_no AS "Num Departamento", 
	dnombre AS "Departamento",
    oficio, COUNT(oficio)
FROM emple
JOIN depart
USING(dept_no)
GROUP BY dept_no, oficio
HAVING COUNT(oficio) > 2;

# 15. Dada la tabla HERRAMIENTAS, visualizar por cada estantería la suma de las unidades. 
SELECT estanteria AS "Estanteria", SUM(unidades) AS "Suma de unidades" 
FROM herramientas 
GROUP BY estanteria
ORDER BY estanteria ASC;

# 16. Visualizar la estantería con más unidades de la tabla HERRAMIENTAS. 
# Estantería -1
SELECT estanteria AS "Estanteria mayor", SUM(unidades) AS "Unidades" 
FROM herramientas
GROUP BY estanteria
HAVING SUM(unidades) = (
	SELECT MAX(nunidades)
	FROM (
		SELECT SUM(unidades) AS nunidades
		FROM herramientas
		GROUP BY estanteria
	) AS cuenta
);

# Tablas PERSONAS, MEDICOS, HOSPITALES. 

# 17. Mostrar el número de médicos que pertenecen a cada hospital, ordenado por número descendente de hospital. 
SELECT 
	cod_hospital AS "Codigo de hospital", 
    nombre AS "Nombre de Hospital", 
    COUNT(apellidos) AS "Numero de medicos"
FROM medicos
JOIN hospitales
USING(cod_hospital) 
GROUP BY cod_hospital,nombre 
ORDER BY cod_hospital DESC;
# 18. Realizar una consulta en la que se muestre por cada hospital el nombre de las especialidades que tiene. 
SELECT nombre AS "Hospital", especialidad AS "Especialidades" 
FROM hospitales 
JOIN medicos 
USING(cod_hospital)
GROUP BY nombre, especialidad
ORDER BY nombre;

# 19. Realizar una consulta en la que aparezca por cada hospital 
# y en cada especialidad el número de médicos (tendrás que partir de la consulta anterior y utilizar GROUP BY). 
SELECT * FROM (
	SELECT 
		cod_hospital AS Hospital, 
		nombre AS "Nombre", 
		COUNT(apellidos) AS "Numero de medicos" 
	FROM hospitales 
    JOIN medicos 
    USING(cod_hospital) 
    GROUP BY cod_hospital,nombre
) AS a
LEFT JOIN(
	SELECT 
		cod_hospital AS Hospital, 
		especialidad AS "Especialidad", 
		COUNT(apellidos)  AS "Numero de medicos" 
    FROM medicos 
    GROUP BY cod_hospital,especialidad
) AS b
ON(a.Hospital = b.Hospital);
# 20. Obtener por cada hospital el número de empleados. 
SELECT 
	cod_hospital AS "Codigo Hospital", 
	nombre AS "Nombre", 
	COUNT(apellidos) AS "Numero de empleados"
FROM medicos 
JOIN hospitales 
USING(cod_hospital) 
GROUP BY cod_hospital, nombre;
# 21. Obtener por cada especialidad el número de trabajadores. 
SELECT 
	especialidad AS "Especialidad", 
	COUNT(apellidos) AS "Numero de empleados"
FROM medicos 
JOIN hospitales 
USING(cod_hospital) 
GROUP BY especialidad;

# 22. Visualizar la especialidad que tenga más médicos. 
SELECT especialidad AS "Especialidad > medicos", COUNT(especialidad) AS "Cantidad" 
FROM medicos
GROUP BY especialidad
HAVING COUNT(especialidad) = (
	SELECT MAX(nespecialidad)
	FROM (
		SELECT COUNT(especialidad) AS nespecialidad
		FROM medicos
		GROUP BY especialidad
	) AS cuenta
);

# 23. ¿Cuál es el nombre del hospital que tiene mayor número de plazas? 
SELECT cod_hospital AS "Codigo de hospital", nombre AS "Hospital > plazas", num_plazas AS "Cantidad"
FROM hospitales
WHERE num_plazas = (
	SELECT MAX(num_plazas) 
	FROM hospitales
);

# 24. Visualizar las diferentes estanterías de la tabla HERRAMIENTAS ordenados descendentemente por estantería.
SELECT DISTINCT estanteria AS "Estanteria" 
FROM herramientas 
ORDER BY estanteria DESC;

# 25. Averiguar cuántas unidades tiene cada estantería. 
SELECT estanteria AS "Estanteria", SUM(unidades) AS "Suma de unidades" 
FROM herramientas 
GROUP BY estanteria
ORDER BY estanteria ASC;

# 26. Visualizar las estanterías que tengan más de 15 unidades 
SELECT estanteria AS "Estanteria", SUM(unidades) AS "Suma de unidades" 
FROM herramientas 
GROUP BY estanteria
HAVING SUM(unidades) > 15;

# 27. ¿Cuál es la estantería que tiene más unidades? 
SELECT estanteria AS "Estanteria", SUM(unidades) AS "Max unidades" 
FROM herramientas
GROUP BY estanteria
HAVING SUM(unidades) = (
	SELECT MAX(nunidades)
	FROM (
		SELECT SUM(unidades) AS nunidades
		FROM herramientas
		GROUP BY estanteria
	) AS cuenta
);

# 28. A partir de las tablas EMPLE y DEPART mostrar los datos del departamento que no tiene ningún empleado.
SELECT *
FROM depart
WHERE dept_no NOT IN
( 
	SELECT dept_no
	FROM emple
	JOIN depart
	USING(dept_no)
	GROUP BY dept_no
);
# 29. Mostrar el número de empleados de cada departamento. 
# En la salida se debe mostrar también los departamentos que no tienen ningún empleado. 
SELECT 
	dept_no AS "Num Departamento", 
	dnombre AS "Departamento", 
	COUNT(emp_no) AS "Cantidad de empleados"
FROM emple 
RIGHT JOIN depart 
USING(dept_no) 
GROUP BY dept_no, dnombre;

# 30. Obtener la suma de salarios de cada departamento, mostrando las columnas 
# DEPT_NO, SUMA DE SALARIOS y DNOMBRE. En el resultado también se deben mostrar los departamentos 
# que no tienen asignados empleados. 
SELECT 
	dept_no AS "Numero de departamento",
	SUM(salario) AS "Salario total",
	dnombre "Departamento"
FROM emple
RIGHT JOIN depart
USING(dept_no)
GROUP BY dept_no;

# 31. Utilizar la función IFNULL en la consulta anterior para que en el caso de que un departamento 
# no tenga empleados, aparezca como suma de salarios el valor 0. 
SELECT 
	dept_no AS "Numero de departamento",
	SUM(IFNULL(salario, 0)) AS "Salario total",
	dnombre "Departamento"
FROM emple
RIGHT JOIN depart
USING(dept_no)
GROUP BY dept_no;

# 32. Obtener el número de médicos que pertenecen a cada hospital, mostrando las columnas 
# COD_HOSPITAL, NOMBRE y NÚMERO DE MÉDICOS. En el resultado deben aparecer también los datos de los 
# hospitales que no tienen médicos. 
SELECT 
	cod_hospital AS "Codigo Hospital", 
	nombre AS "Nombre Hospital", 
	COUNT(apellidos) AS "Cantidad de Medicos"
FROM medicos
RIGHT JOIN hospitales
USING(cod_hospital)
GROUP BY cod_hospital,nombre;