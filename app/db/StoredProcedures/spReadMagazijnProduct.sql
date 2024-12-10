/******************************************************
-- Doel: Ophalen van alle records uit de tabel Magazijn
*******************************************************
-- Versie:  01
-- Datum:   13-11-2024
-- Auteur:  Daniël van Grol
******************************************************/

-- Selecteer de juiste database voor je stored procedure
USE `jamin_a`;

-- Verwijder de oude stored procedure
DROP PROCEDURE IF EXISTS spReadMagazijnProduct;

-- Verander even tijdelijk de opdrachtprompt naar //
DELIMITER //

CREATE PROCEDURE spReadMagazijnProduct()
BEGIN
    SELECT 
        p.Barcode,
        p.Naam,
        p.Verpakkingseenheid,
        m.AantalAanwezig,
        p.Id AS ProductId
    FROM 
        Magazijn m
    JOIN 
        Product p ON m.ProductId = p.Id;
END //
DELIMITER ;