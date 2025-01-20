-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Gegenereerd op: 27 sep 2024 om 07:44
-- Serverversie: 9.0.1
-- PHP-versie: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Database: jamin_a
DROP DATABASE IF EXISTS jamin_a;
CREATE DATABASE IF NOT EXISTS jamin_a DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE jamin_a;


-- Tabelstructuur voor tabel `Product`
DROP TABLE IF EXISTS Product;
CREATE TABLE IF NOT EXISTS Product (
  `Id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` VARCHAR(255) NOT NULL,
  `Barcode` VARCHAR(13) NOT NULL,
  `Verpakkingseenheid` VARCHAR(100) NOT NULL,
  `IsActief` BIT NOT NULL DEFAULT 1,
  `Opmerkingen` VARCHAR(255) DEFAULT NULL,
  `DatumAangemaakt` DATETIME(6) NOT NULL,
  `DatumGewijzigd` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Gegevens worden geëxporteerd voor tabel `Product`
INSERT INTO `Product` (`Naam`, `Barcode`, `Verpakkingseenheid`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
('Mintnopjes', '8719587231278', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Schoolkrijt', '8719587326713', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Honingdrop', '8719587327836', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Zure Beren', '8719587321441', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),  
('Cola Flesjes', '8719587321237', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Turtles', '8719587322245', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Witte Muizen', '8719587328256', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Reuzen Slangen', '8719587325641', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Zoute Rijen', '8719587322739', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Drop Munten', '8719587322345', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Kruis Drop', '8719587322265', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Zoute Ruitjes', '8719587323256', 'Stuk', 1, NULL, SYSDATE(6), SYSDATE(6));  

-- Tabelstructuur voor tabel `Allergeen`
DROP TABLE IF EXISTS Allergeen;
CREATE TABLE IF NOT EXISTS Allergeen (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Naam` VARCHAR(50) NOT NULL,
  `Omschrijving` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Gegevens worden geëxporteerd voor tabel `Allergeen`
INSERT INTO `Allergeen` (`Id`, `Naam`, `Omschrijving`) VALUES
(1, 'Gluten', 'Dit product bevat gluten'),
(2, 'Gelatine', 'Dit product bevat gelatine'),
(3, 'AZO-Kleurstof', 'Dit product bevat AZO-kleurstoffen'),
(4, 'Lactose', 'Dit product bevat lactose'),
(5, 'Soja', 'Dit product bevat soja');

-- Tabelstructuur voor tabel `ProductPerAllergeen`
DROP TABLE IF EXISTS ProductPerAllergeen;
CREATE TABLE IF NOT EXISTS ProductPerAllergeen (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `ProductId` INT NOT NULL,
  `AllergeenId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  FOREIGN KEY (`AllergeenId`) REFERENCES `Allergeen`(`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Gegevens worden geëxporteerd voor tabel `ProductPerAllergeen`
INSERT INTO `ProductPerAllergeen` (`Id`, `ProductId`, `AllergeenId`) VALUES
(1, 1, 2),
(2, 1, 1),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 9, 2),
(7, 9, 5),
(8, 10, 2),
(9, 12, 4),
(10, 13, 1),
(11, 13, 4),
(12, 13, 5);

-- Tabelstructuur voor tabel `Magazijn`
DROP TABLE IF EXISTS Magazijn;
CREATE TABLE IF NOT EXISTS Magazijn (
  `Id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` MEDIUMINT UNSIGNED NOT NULL,
  `VerpakkingsEenheid` DECIMAL(4,1) NOT NULL,
  `AantalAanwezig` SMALLINT UNSIGNED NOT NULL,
  `IsActief` BIT NOT NULL DEFAULT 1,
  `Opmerkingen` VARCHAR(255) DEFAULT NULL,
  `DatumAangemaakt` DATETIME(6) NOT NULL,
  `DatumGewijzigd` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id`),
  FOREIGN KEY (`ProductId`) REFERENCES `Product`(`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Gegevens worden geëxporteerd voor tabel `Magazijn`
INSERT INTO `Magazijn` (`ProductId`, `VerpakkingsEenheid`, `AantalAanwezig`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 5, 453, 1, NULL, SYSDATE(6), SYSDATE(6)),
(2, 2.5, 400, 1, NULL, SYSDATE(6), SYSDATE(6)),
(3, 5, 1, 1, NULL, SYSDATE(6), SYSDATE(6)),
(4, 1, 800, 1, NULL, SYSDATE(6), SYSDATE(6)),
(5, 3, 234, 1, NULL, SYSDATE(6), SYSDATE(6)),
(6, 2, 345, 1, NULL, SYSDATE(6), SYSDATE(6)),
(7, 1, 795, 1, NULL, SYSDATE(6), SYSDATE(6)),
(8, 10, 233, 1, NULL, SYSDATE(6), SYSDATE(6)),
(9, 2.5, 123, 1, NULL, SYSDATE(6), SYSDATE(6)),
(10, 3, 0, 1, NULL, SYSDATE(6), SYSDATE(6)), -- Winegums
(11, 2, 367, 1, NULL, SYSDATE(6), SYSDATE(6)),
(12, 1, 467, 1, NULL, SYSDATE(6), SYSDATE(6)),
(13, 5, 20, 1, NULL, SYSDATE(6), SYSDATE(6));

-- Tabelstructuur voor tabel `Leverancier`
DROP TABLE IF EXISTS Leverancier;
CREATE TABLE IF NOT EXISTS Leverancier (
  `Id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` VARCHAR(60) NOT NULL,
  `Contactpersoon` VARCHAR(60) NOT NULL,
  `Leveranciernummer` VARCHAR(11) NOT NULL,
  `Mobiel` VARCHAR(11) NOT NULL,
  `IsActief` BIT NOT NULL DEFAULT 1,
  `Opmerkingen` VARCHAR(255) DEFAULT NULL,
  `DatumAangemaakt` DATETIME(6) NOT NULL,
  `DatumGewijzigd` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Gegevens worden geëxporteerd voor tabel `Leverancier`
INSERT INTO `Leverancier` (`Naam`, `Contactpersoon`, `Leveranciernummer`, `Mobiel`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
('Venco', 'Bert van Linge', 'L1029384719', '06-28493827', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398734', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', 1, NULL, SYSDATE(6), SYSDATE(6)),
('Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', 1, NULL, SYSDATE(6), SYSDATE(6)),
('De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', 1, NULL, SYSDATE(6), SYSDATE(6));

-- Tabelstructuur voor tabel `ProductPerLeverancier`
DROP TABLE IF EXISTS ProductPerLeverancier;
CREATE TABLE IF NOT EXISTS ProductPerLeverancier (
  `Id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `LeverancierId` SMALLINT UNSIGNED NOT NULL,
  `ProductId` MEDIUMINT UNSIGNED NOT NULL,
  `DatumLevering` DATE NOT NULL,
  `Aantal` INT UNSIGNED NOT NULL,
  `DatumEerstVolgendeLevering` DATE NOT NULL,
  `IsActief` BIT NOT NULL DEFAULT 1,
  `Opmerkingen` VARCHAR(255) DEFAULT NULL,
  `DatumAangemaakt` DATETIME(6) NOT NULL,
  `DatumGewijzigd` DATETIME(6) NOT NULL,
  PRIMARY KEY (`Id`),
  FOREIGN KEY (`LeverancierId`) REFERENCES `Leverancier`(`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`ProductId`) REFERENCES `Product`(`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Gegevens worden geëxporteerd voor tabel `ProductPerLeverancier`
INSERT INTO `ProductPerLeverancier` (`LeverancierId`, `ProductId`, `DatumLevering`, `Aantal`, `DatumEerstVolgendeLevering`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, '2024-10-09', 23, '2024-10-16', 1, NULL, SYSDATE(6), SYSDATE(6)),
(1, 1, '2024-10-18', 21, '2024-10-25', 1, NULL, SYSDATE(6), SYSDATE(6)),
(1, 2, '2024-10-09', 12, '2024-10-16', 1, NULL, SYSDATE(6), SYSDATE(6)),
(1, 3, '2024-10-10', 11, '2024-10-17', 1, NULL, SYSDATE(6), SYSDATE(6)),
(2, 4, '2024-10-14', 16, '2024-10-21', 1, NULL, SYSDATE(6), SYSDATE(6)),
(2, 4, '2024-10-21', 23, '2024-10-28', 1, NULL, SYSDATE(6), SYSDATE(6)),
(2, 5, '2024-10-14', 45, '2024-10-21', 1, NULL, SYSDATE(6), SYSDATE(6)),
(2, 6, '2024-10-14', 30, '2024-10-21', 1, NULL, SYSDATE(6), SYSDATE(6)),
(3, 7, '2024-10-12', 12, '2024-10-19', 1, NULL, SYSDATE(6), SYSDATE(6)),
(3, 7, '2024-10-19', 23, '2024-10-26', 1, NULL, SYSDATE(6), SYSDATE(6)),
(3, 8, '2024-10-10', 12, '2024-10-17', 1, NULL, SYSDATE(6), SYSDATE(6)),
(3, 9, '2024-10-11', 1, '2024-10-18', 1, NULL, SYSDATE(6), SYSDATE(6)),
(4, 10, '2024-10-16', 24, '2024-10-30', 1, NULL, SYSDATE(6), SYSDATE(6)),
(5, 11, '2024-10-10', 47, '2024-10-17', 1, NULL, SYSDATE(6), SYSDATE(6)),
(5, 11, '2024-10-19', 60, '2024-10-26', 1, NULL, SYSDATE(6), SYSDATE(6)),
(5, 12, '2024-10-11', 45, NULL, 1, NULL, SYSDATE(6), SYSDATE(6)),
(5, 13, '2024-10-12', 23, NULL, 1, NULL, SYSDATE(6), SYSDATE(6));

-- Stored Procedure voor het ophalen van alle producten uit de Magazijn-tabel
DROP PROCEDURE IF EXISTS spReadMagazijnProduct;

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
        Product p ON m.ProductId = p.Id
    ORDER BY p.Barcode ASC;
END //
DELIMITER ;

-- Stored Procedure voor het ophalen van alle leveranciers en het aantal verschillende producten dat zij leveren
DROP PROCEDURE IF EXISTS spGetAllLeveranciers;

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
DROP PROCEDURE IF EXISTS spGetGeleverdeProducten;

-- Verander even tijdelijk de opdrachtprompt naar //
DELIMITER //

CREATE PROCEDURE spGetGeleverdeProducten(IN leverancierId INT)
BEGIN
    SELECT 
        p.Id,
        p.Naam,
        p.Barcode,
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
        p.Id, p.Naam, p.Barcode, m.AantalAanwezig
    ORDER BY 
        m.AantalAanwezig DESC;
END //
DELIMITER ;

COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;