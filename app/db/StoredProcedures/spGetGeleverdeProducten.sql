/******************************************************
-- Doel: Opvragen van de geleverde producten van een specifieke leverancier
-- Versie: 01
-- Datum: 26-09-2024
-- Auteur: Arjan de Ruijter
******************************************************/

-- Selecteer de juiste database voor je stored procedure
USE `jamin_a`;

-- Verwijder de oude stored procedure
DROP PROCEDURE IF EXISTS spGetGeleverdeProducten;

-- Verander even tijdelijk de opdrachtprompt naar //
DELIMITER //

CREATE PROCEDURE spGetGeleverdeProducten(IN leverancierId INT)
BEGIN
    SELECT 
        p.Id,
        p.Naam,
        p.Barcode,
        m.VerpakkingsEenheid,
        m.AantalAanwezig,
        MAX(pl.DatumLevering) AS DatumLaatsteLevering
    FROM 
        Product p
    JOIN 
        ProductPerLeverancier pl ON p.Id = pl.ProductId
    JOIN 
        Magazijn m ON p.Id = m.ProductId
    WHERE 
        pl.LeverancierId = leverancierId
    GROUP BY 
        p.Id, p.Naam, p.Barcode, m.VerpakkingsEenheid, m.AantalAanwezig
    ORDER BY 
        m.AantalAanwezig DESC;
END //
DELIMITER ;

COMMIT;