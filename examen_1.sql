##################################################
# 		CONFIGURACION DE LA BASE DE DATOS		 #
##################################################

DROP DATABASE IF EXISTS banco;
CREATE DATABASE banco;
USE banco;

CREATE TABLE usr
(
    num_usr INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    rol VARCHAR(45) NOT NULL
);

CREATE TABLE extracciones
(
	num_transaccion INT PRIMARY KEY NOT NULL,
    num_usr INT NOT NULL,
    dinero FLOAT NOT NULL,
    estado BOOLEAN,
    fecha DATE
);

ALTER TABLE usr #SE ALTERA LA TABLA USR
ADD CONSTRAINT rel_usr_extra #RELACION TABLA USR Y EXTRACCIONES
FOREIGN KEY (num_usr) #LA LLAVE DE RELACION ENTRE LAS DOS TABLAS
REFERENCES extracciones(num_transaccion); #REFERENCIA A USR

INSERT INTO extracciones 
VALUES 
	(1,5,3559.20,TRUE,'2020-01-15'),
	(2,3,5663.50,TRUE,'2021-05-05'),
	(3,5,527.65,FALSE,'2018-03-11'),
	(4,3,9728.21,TRUE,'2019-12-12'),
	(5,1,462.06,FALSE,'2020-09-29'),
	(6,4,2860.41,FALSE,'2022-08-24'),
	(7,1,4029.38,TRUE,'2022-08-30'),
	(8,2,3521.96,FALSE,'2022-08-24'),
	(9,5,257.15,TRUE,'2021-10-01'),
	(10,3,6045.81,TRUE,'2020-11-25'),
	(11,4,9087.55,FALSE,'2018-12-10'),
	(12,2,2576.20,TRUE,'2020-01-30'),
	(13,4,7593.73,FALSE,'2022-06-21'),
	(14,3,9390.97,TRUE,'2019-07-15'),
	(15,2,9449.74,FALSE,'2018-08-26'),
	(16,4,6411.48,FALSE,'2018-09-30'),
	(17,4,4501.61,FALSE,'2020-04-06'),
	(18,3,4369.12,TRUE,'2018-08-29'),
	(19,1,577.07,TRUE,'2022-10-30'),
	(20,5,6638.85,TRUE,'2019-09-06');

INSERT INTO usr
VALUES
    (1,'JESUS JIMENEZ','ADMINISTRADOR'),
	(2,'ALEJANDRO HERNANDEZ','ADMINISTRADOR'),
	(3,'ARTURO PALACIO','GENERAL'),
	(4,'OSCAR SERRANO','GENERAL'),
	(5,'EMILIO ALBERTO','ADMINISTRADOR');
    
##################################################
# 	  RESOLUCION A LAS PREGUNTAS DEL EXAMEN		 #
##################################################

# IMPORTANTE: Mi interpretacion del problema es que si una 
# transaccion fallo (false), se tomara como un retorno de dinero, 
# en el cASo contrario es una extraccion (true).


# 1. Consulta para obtener el número de usuarios con el rol 
#    administrador y con el rol general.
SELECT 
    rol AS 'Rol', 
    COUNT(num_usr) AS 'Cantidad' 
FROM usr 
GROUP BY rol;

# 2. Consulta para obtener el total de dinero que se ha extraído.
SELECT 
    ROUND(SUM(dinero), 2) AS 'Total extraido'
FROM extracciones 
WHERE estado IS NOT FALSE;

# 3. Consulta para obtener los nombres de los usuarios, la suma de dinero 
#    que han extraído cada uno y la cantidad de extracciones que han hecho, 
#    ordenado por quien haya extraído más dinero.
SELECT 
    nombre AS 'Nombre de Usuario', 
    sum_dinero AS 'Suma extraccion', 
    COUNT_usr AS 'Cantidad extracciones'  
FROM (
    SELECT 
        nombre, 
        ROUND(SUM(dinero), 2) AS sum_dinero, 
        COUNT(num_usr) AS COUNT_usr
    FROM usr 
    JOIN extracciones 
    USING(num_usr) 
    WHERE dinero IS NOT FALSE 
    GROUP BY num_usr
) AS ordenar 
order by sum_dinero DESC;

# 4. Consulta para obtener los nombres de los usuarios y el promedio de dinero 
#    que han extraído cada uno, ordenado por el promedio de menor a mayor.
SELECT 
    nombre AS 'Nombre de Usuario', 
    prom_dinero AS 'Promedio extraccion'
FROM (
    SELECT 
        nombre, 
        ROUND(AVG(dinero), 2) AS prom_dinero 
    FROM usr JOIN extracciones 
    USING(num_usr) 
    WHERE dinero IS NOT FALSE 
    GROUP BY num_usr
) AS ordenar 
order by prom_dinero ASC;

# 5. Consulta para obtener la suma de dinero que se ha extraído por año, 
#    ordenado por año.
SELECT 
    año_fecha AS 'Año',
    sum_dinero AS 'Total extraccion'
FROM (
    SELECT 
        YEAR(fecha) AS año_fecha,
        ROUND(SUM(dinero), 2) AS sum_dinero
    FROM extracciones 
    WHERE dinero IS NOT FALSE 
    GROUP BY YEAR(fecha)
) AS ordenar 
order by año_fecha ASC;

# 6. Consulta para obtener la suma de dinero que se ha extraído por año y mes, 
#    ordenado por año y mes.
SELECT 
    sum_dinero AS 'Total extraccion',
    año_fecha AS 'Año',
    mes_fecha AS 'Mes'
FROM (
    SELECT 
        ROUND(SUM(dinero), 2) AS sum_dinero, 
        YEAR(fecha) AS año_fecha, 
        MONTH(fecha) AS mes_fecha 
    FROM extracciones 
    WHERE dinero IS NOT FALSE 
    GROUP BY mes_fecha, año_fecha
) AS ordenar 
order by año_fecha,mes_fecha ASC;

# 7. Consulta para obtener el nombre y la suma de dinero del usuario 
#    que haya extraído menos dinero.
SELECT 
    nombre AS 'Nombre', 
    ROUND(SUM(dinero), 2) AS 'Total extraccion'
FROM usr 
JOIN extracciones 
USING(num_usr) 
GROUP BY num_usr
HAVING SUM(dinero) = (
	SELECT MIN(min_COUNT)
	FROM (
		SELECT SUM(dinero) AS min_COUNT
		FROM usr
		JOIN extracciones 
        USING(num_usr) 
		GROUP BY num_usr
	) AS min_dinero
);

# 8. Consulta para obtener la cantidad de movimientos erróneos.
SELECT 
    t_estado AS 'Estado', 
    c_transaccion AS 'Cantidad' 
FROM(
    SELECT 
        IF(estado,'Exito','Error') AS t_estado, 
        COUNT(num_transaccion) AS c_transaccion
    FROM extracciones 
    GROUP BY t_estado
) AS mov_erroneos
WHERE t_estado='Error';

# 9. Consulta para obtener al nombre del usuario que haya realizado más movimientos erróneos.
SELECT 
    nombre AS 'Nombre', 
    COUNT(estado) AS 'Cantidad error'
FROM usr 
JOIN extracciones 
USING(num_usr) 
GROUP BY num_usr
HAVING COUNT(estado) = (
	SELECT MAX(max_COUNT)
	FROM (
		SELECT COUNT(estado) AS max_COUNT
		FROM usr
		JOIN extracciones 
        USING(num_usr) 
		GROUP BY num_usr
	) AS max_error
);

# 10. Consulta para obtener la cantidad de extracciones, agrupadAS por año y mes.

#
# Debido a como interprete el problema, yo considero una extraccion cuando es 
# exitoso el movimiento (True), por ende, ignorare los errores (false).
#
SELECT
    año_fecha AS 'Año',
    mes_fecha AS 'Mes',
    COUNT_estado AS 'Cantidad'
FROM (
    SELECT 
        YEAR(fecha) AS año_fecha, 
        MONTH(fecha) AS mes_fecha, 
        COUNT(estado) AS COUNT_estado
    FROM extracciones
    GROUP BY YEAR(fecha), MONTH(fecha)
) AS cuenta
WHERE COUNT_estado=TRUE;

# 11. Consulta para obtener la cantidad de retornos de dinero.
SELECT
    COUNT(estado) AS 'Cantidad Retornos'
FROM extracciones
WHERE estado IS NOT TRUE;

# 12. Consulta para obtener los nombres de los usuarios y la suma de dinero retornada por cada uno.
SELECT 
    nombre AS 'Nombre', 
    ROUND(SUM(dinero), 2) AS 'Total retornado' 
FROM usr 
JOIN extracciones 
USING(num_usr) 
WHERE estado IS NOT TRUE
GROUP BY nombre;