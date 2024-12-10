/******************************************************
-- Doel: Opvragen van alle leveranciers en het aantal verschillende producten dat zij leveren
-- Versie: 01
-- Datum: 26-09-2024
-- Auteur: Daniel van Grol
******************************************************/

-- Selecteer de juiste database voor je stored procedure
USE `jamin_a`;

-- Verwijder de oude stored procedure
DROP PROCEDURE IF EXISTS spGetAllLeveranciers;

-- Verander even tijdelijk de opdrachtprompt naar //
DELIMITER //

CREATE PROCEDURE spGetAllLeveranciers()
BEGIN
    SELECT 
        l.Id,
        l.Naam,
        l.Contactpersoon,
        l.Leveranciernummer,
        l.Mobiel,
        COUNT(DISTINCT ppa.ProductId) AS AantalProducten
    FROM 
        Leverancier l
    LEFT JOIN 
        ProductPerLeverancier ppa ON l.Id = ppa.LeverancierId
    GROUP BY 
        l.Id, l.Naam, l.Contactpersoon, l.Leveranciernummer, l.Mobiel
    ORDER BY 
        AantalProducten DESC;
END //
DELIMITER ;

COMMIT;