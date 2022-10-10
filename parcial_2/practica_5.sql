DELIMITER $$
DROP PROCEDURE IF EXISTS operaciones $$
CREATE PROCEDURE operaciones()
BEGIN
	SET @resultado = @valorA - @valorB;
    SET @resultado = @valorA * @valorB;
    SET @resultado = @valorA / @valorB;
    	
	IF @operador = "+" THEN
		SET @resultado = @valorA + @valorB;
        SET @t_resultado = CONCAT(@valorA,' + ',@valorB,' = ', @resultado);
    END IF;
    IF @operador = "-" THEN
		SET @resultado = @valorA - @valorB;
        SET @t_resultado = CONCAT(@valorA,' - ',@valorB,' = ', @resultado);
    END IF;
	IF @operador = "*" THEN
		SET @resultado = @valorA * @valorB;
        SET @t_resultado = CONCAT(@valorA,' * ',@valorB,' = ', @resultado);
    END IF;
	IF @operador = "/" THEN
		SET @resultado = @valorA / @valorB;
        SET @t_resultado = CONCAT(@valorA,' / ',@valorB,' = ', @resultado);
    END IF;
	
	END $$
DELIMITER ;

SET @valorA = 10;
SET @valorB = 20;
SET @operador = "/";

CALL operaciones();

SELECT @t_resultado;