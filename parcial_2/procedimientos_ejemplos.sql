DELIMITER $$
DROP PROCEDURE IF EXISTS ejemplo1 $$
CREATE PROCEDURE ejemplo1()
BEGIN
SELECT "Mi primer programa en MySQL" AS "Mensaje";
END$$
DELIMITER ;

call ejemplo1();


DELIMITER $$
DROP PROCEDURE IF EXISTS variables1 $$
CREATE PROCEDURE variables1()
BEGIN
DECLARE v_entera1,v_entera2,v_entera3 INT;
DECLARE v_entera4 INT DEFAULT -40000;
DECLARE v_entera5 INT UNSIGNED DEFAULT 360;
DECLARE v_real1 FLOAT DEFAULT 361.54;
DECLARE v_texto1 CHAR(5);
DECLARE v_texto2 VARCHAR(45);
DECLARE v_fecha1 DATE DEFAULT '2022-01-01';
DECLARE v_fecha2 DATE DEFAULT NOW();
SELECT v_entera4;
SELECT v_entera5;
SELECT v_real1;
SELECT v_fecha2;
SELECT "Mi primer programa en MySQL" AS "Mensaje";
END$$
DELIMITER ;

call variables1();

DELIMITER $$
DROP PROCEDURE IF EXISTS variables2 $$
CREATE PROCEDURE variables2()
BEGIN
    DECLARE v_caracter1 CHAR(1);
    DECLARE v_forma_pago ENUM ('Efectivo','Tarjeta','Transferencia');
    SET v_caracter1='SI'; # ---> Error por exceder el tamaño
    SET v_forma_pago = 1;
    SET v_forma_pago = 'Tarjeta';
end $$
DELIMITER ;

call variables2();

DELIMITER $$
DROP PROCEDURE IF EXISTS asignal $$
CREATE PROCEDURE asignal1()
BEGIN
	DECLARE v_entero1, v_entero2, v_entero3 INT;
    DECLARE v_entero4 INT DEFAULT -40000;
    DECLARE v_real2 FLOAT DEFAULT 1.5e14;
    DECLARE v_real3 NUMERIC(7,2) DEFAULT 4561.44;
    DECLARE v_caracter1 CHAR(1) DEFAULT 'Y';
    DECLARE v_fecha1 DATE DEFAULT '1966-11-03';
    DECLARE v_fecha2 DATE DEFAULT CURRENT_DATE;

    SET v_caracter1 = 'N';
    SET v_entero1 = v_entero4 + 10000;
    SET v_real2 = v_entero4 + v_real3;
    SET v_fecha1 = '2006/05/29', v_fecha2 = v_fecha2 + 1;
	
    SELECT v_caracter1;
    SELECT v_entero1;
    SELECT v_real2;
    SELECT v_fecha1;
    SELECT v_fecha2;
END $$
DELIMITER ;

CALL asignal1();
