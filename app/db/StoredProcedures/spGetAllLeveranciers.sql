/******************************************************
-- Doel: Opvragen van alle leveranciers en het aantal verschillende producten dat zij leveren
-- Versie: 01
-- Datum: 26-09-2024
-- Auteur: Fatih Kuzu
******************************************************/

-- Selecteer de juiste database voor je stored procedure
USE `jamin_a`;

-- Verwijder de oude stored procedure
DROP PROCEDURE IF EXISTS spGetAllLeveranciers;

-- Verander even tijdelijk de opdrachtprompt naar //
DELIMITER //

CREATE PROCEDURE spGetAllLeveranciers()
BEGIN
   SELECT id, Naam, Contactpersoon, Leveranciernummer, Mobiel
    FROM leveranciers;
END //
DELIMITER ;

COMMIT;