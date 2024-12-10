/******************************************************
-- Doel: Updaten van een record in de tabel Country op
         basis van het Id
*******************************************************
-- Versie: 01
-- Datum: 26-09-2024
-- Auteur: Arjan de Ruijter
******************************************************/

-- Selecteer de juiste database voor je stored procedure
use `jamin_a`;

-- Verwijder de oude stored procedure
DROP PROCEDURE IF EXISTS spUpdateCountryById;

-- Verander even tijdelijk de opdrachtprompt naar //
DELIMITER //

CREATE PROCEDURE spUpdateCountryById(
    IN Id           INT UNSIGNED,
    IN Name         VARCHAR(250),
    IN CapitalCity  VARCHAR(250),
    IN Continent    VARCHAR(250),
    IN Population   INT UNSIGNED,
    IN Zipcode      VARCHAR(6)
)
BEGIN
    UPDATE  Country AS  COUN
    SET     COUN.Name = Name,
            COUN.CapitalCity = CapitalCity,
            COUN.Continent = Continent,
            COUN.Population = Population,
            COUN.Zipcode = Zipcode
    WHERE   COUN.Id = Id;
END //
DELIMITER ;

/************* debug code stored procedure **************

CALL spUpdateCountryById(2, 'Nederland', 'Amsterdam', 'Europa', 18000000, '2309CB');

********************************************************/



