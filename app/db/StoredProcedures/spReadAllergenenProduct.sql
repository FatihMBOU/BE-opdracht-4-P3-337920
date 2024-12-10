/******************************************************
-- Doel: Ophalen van alle allergeneninformatie voor producten
*******************************************************
-- Versie:  01
-- Datum:   13-11-2024
-- Auteur:  Daniël vab Grol
******************************************************/

-- Selecteer de juiste database voor je stored procedure
USE `jamin_a`;

-- Verwijder de oude stored procedure
DROP PROCEDURE IF EXISTS spReadAllergenenProduct;

-- Verander even tijdelijk de opdrachtprompt naar //
DELIMITER //

CREATE PROCEDURE spReadAllergenenProduct()
BEGIN
    SELECT 
        p.Barcode,
        p.Naam AS ProductNaam,
        a.Naam AS AllergenenNaam,
        a.Omschrijving
    FROM 
        Product p
    JOIN 
        ProductPerAllergeen pa ON p.Id = pa.ProductId
    JOIN 
        Allergeen a ON pa.AllergeenId = a.Id
    ORDER BY 
        p.Naam ASC, a.Naam ASC;
END //
DELIMITER ;

COMMIT;