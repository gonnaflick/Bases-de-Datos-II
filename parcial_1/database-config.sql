CREATE DATABASE empresa;
USE empresa;

CREATE TABLE emple
(
    emp_no INT PRIMARY KEY NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    oficio VARCHAR(45) NOT NULL,
    dir INT,
    fecha_alt DATE,
    salario INT NOT NULL,
    comision INT,
    dept_no INT NOT NULL
);

CREATE TABLE depart
(
    dept_no INT PRIMARY KEY NOT NULL,
    dnombre VARCHAR(45) NOT NULL,
    loc VARCHAR(45) NOT NULL
);

ALTER TABLE emple #SE ALTERA LA TABLA EMPLEADOS
ADD CONSTRAINT rel_emp_dept #RELACION TABLA EMPLEADOS Y DEPARTAMENOS
FOREIGN KEY (dept_no) #LA LLAVE DE RELACION ENTRE LAS DOS TABLAS
REFERENCES depart(dept_no); #REFERENCIA

INSERT INTO depart
VALUES
    (10,'Contabilidad', 'Sevilla'),
    (20,'Investigacion','Madrid'),
    (30,'Ventas','Barcelona'),
    (40,'Produccion','Bilbao');

INSERT INTO emple 
VALUES 
    (7369,'SANCHEZ','EMPLEADO',7902,'1980-12-17',104000,NULL,20),
    (7499,'ARROYO','VENDEDOR',7398,'1980-02-20',208000,39000,30),
    (7521,'SALA','VENDEDOR',7698,'1981-02-22',162500,162500,30),
    (7566,'JIMENEZ','DIRECTOR',7839,'1981-03-02',386750,NULL,30),
    (7654,'MARTIN','VENDEDOR',7698,'1981-09-29',162500,182000,30),
    (7698,'NEGRO','DIRECTOR',7839,'1981-05-01',370500,NULL,30),
    (7788,'GIL','ANALISTA',7566,'1981-11-09',390000,NULL,20),
    (7839,'REY','PRESIDENTE',NULL,'1981-11-17',650000,NULL,10),
    (7844,'TOVAR','VENDEDOR',7698,'1981-09-08',195000,0,30),
    (7876,'ALONSO','EMPLEADO',7788,'1981-09-23',143000,NULL,20),
    (7900,'JIMENO','EMPLEADO',7698,'1981-12-03',1235000,NULL,30),
    (7902,'FERNANDEZ','ANALISTA',7566,'1981-12-03',390000,NULL,20),
    (7934,'MUNOZ','EMPLEADO',7782,'1981-01-23',169000,NULL,10),
    (7782,'CEREZO','DIRECTOR',7839,'1991-06-09',288500,NULL,10);

CREATE TABLE herramientas(
    descripcion VARCHAR(50) PRIMARY KEY,
    estanteria INTEGER,
    unidades INTEGER
);

INSERT INTO herramientas VALUES
    ('Alicates',1,10),
    ('Soldador',1,15),
    ('Guantes',2,7),
    ('Martillo',3,10),
    ('Sierra',4,5),
    ('Destornillador',3,7),
    ('Metro',5,15),
    ('Escofina',6,5),
    ('Lima',6,10),
    ('Cortador',4,5);

CREATE TABLE personas(
    cod_hospital INTEGER,
    dni INTEGER PRIMARY KEY,
    apellidos VARCHAR(50),
    funcion VARCHAR(30),
    salario INTEGER,
    localidad VARCHAR(30)
);

CREATE TABLE medicos(
    cod_hospital INTEGER,
    dni INTEGER primary key,
    apellidos    VARCHAR(50),
    especialidad VARCHAR(50)
);

CREATE TABLE hospitales(
    cod_hospital INTEGER,
    nombre VARCHAR(50),
    direccion VARCHAR(50),
    num_plazas INTEGER
);

INSERT INTO personas 
VALUES
    (1,12345678,'Garcia Hernandez, Eladio','CONSERJE',1200,'LORCA'),
    (1,87654321,'Fuentes Bermejo, Carlos','DIRECTOR',2000, 'MURCIA'),
    (2,55544433,'Gonzalez Marin, Alicia','CONSERJE',1200, 'MURCIA'),
    (1,66655544,'Castillo Montes, Pedro','MEDICO',1700,'MURCIA'),
    (2,22233322,'Tristan Garcia, Ana','MEDICO',1900,'MURCIA'),
    (3,55544411,'Ruiz HernÃ¡ndez, Caridad','MEDICO',1900,'LORCA'),
    (3,99988333,'Serrano Diaz, Alejandro','DIRECTOR',2400,'CARTAGENA'),
    (4,33222111,'Mesa del Castillo, Juan','MEDICO',2200,'LORCA'),
    (2,22233333,'Martinez Molina, Andres','MEDICO',1600,'CARTAGENA'),
    (4,55544412,'Jimenez Jimenez, Dolores','CONSERJE',1200,'MURCIA'),
    (4,22233311,'Martinez Molina, Gloria','MEDICO',1600,'MURCIA');

INSERT INTO medicos 
VALUES
    (1,66655544,'Castillo Montes, Pedro','PSIQUIATRA'),
    (2,22233322,'Tristan GarcÃa, Ana','CIRUJANO'),
    (4,33222111,'Mesa del Castillo, Juan','DERMATOLOGO'),
    (2,22233333,'Martinez Molina, Andres','CIRUJANO'),
    (4,22233311,'Martinez Molina, Gloria','PSIQUIATRA'); 

INSERT INTO hospitales 
VALUES
    (1,'Rafael Mendez','Gran Via, 7',250),
    (2,'Reina Sofia','Junterones, 5',225),
    (3,'Principe Asturias','Avenida Colon',150),
    (4,'Virgen de la Arrixaca','Avenida Juan Carlos I',250);
