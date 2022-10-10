DROP TABLE IF EXISTS tabla;

CREATE TABLE tabla(
	operaciones VARCHAR(50)
);

DELIMITER $$
DROP PROCEDURE IF EXISTS multiplicacion $$
CREATE PROCEDURE multiplicacion()
BEGIN
	DECLARE ciclo_multiplicando INT;
	DECLARE ciclo_multiplicador INT;
    
    SET ciclo_multiplicando = @limite_tabla;
    SET ciclo_multiplicador = @limite_tabla;
	
    SET @v_multiplicando = 1;
	SET @v_multiplicador = 1;
    
	ciclo_multiplicando: LOOP
		IF ciclo_multiplicando < 1 THEN
			LEAVE ciclo_multiplicando;
		END IF;        
		IF @v_multiplicando <= @limite_tabla THEN
			ciclo_multiplicador: LOOP
				IF ciclo_multiplicador < 1 THEN
					LEAVE ciclo_multiplicador;
				END IF;
				IF @v_multiplicador <= @limite_tabla THEN
					SET @producto = @v_multiplicando*@v_multiplicador;
					SET @resultado = CONCAT(@v_multiplicando,' x ',@v_multiplicador,' = ', @producto);
					SET @v_multiplicador = @v_multiplicador + 1;
					INSERT INTO tabla(operaciones) VALUES (@resultado);
					COMMIT;
				SET ciclo_multiplicador = ciclo_multiplicador - 1;
				END IF;
			
            ITERATE ciclo_multiplicador;   
			END LOOP;
            SET ciclo_multiplicador = @limite_tabla;
            SET @v_multiplicador = 1;
            SET @v_multiplicando = @v_multiplicando + 1;
            SET ciclo_multiplicando = ciclo_multiplicando - 1;
		END IF;
    ITERATE ciclo_multiplicando;   
	END LOOP;
	END $$
DELIMITER ;

SET @limite_tabla = 10;

CALL multiplicacion();

SELECT * FROM tabla;