-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Gegenereerd op: 28 feb 2025 om 20:08
-- Serverversie: 9.0.1
-- PHP-versie: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jamin_a`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `spGetAllLeveranciers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetAllLeveranciers` ()   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spGetGeleverdeProducten`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetGeleverdeProducten` (IN `leverancierId` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spReadMagazijnProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadMagazijnProduct` ()   BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `allergeen`
--

DROP TABLE IF EXISTS `allergeen`;
CREATE TABLE IF NOT EXISTS `allergeen` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Naam` varchar(50) NOT NULL,
  `Omschrijving` varchar(255) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `allergeen`
--

INSERT INTO `allergeen` (`Id`, `Naam`, `Omschrijving`) VALUES
(1, 'Gluten', 'Dit product bevat gluten'),
(2, 'Gelatine', 'Dit product bevat gelatine'),
(3, 'AZO-Kleurstof', 'Dit product bevat AZO-kleurstoffen'),
(4, 'Lactose', 'Dit product bevat lactose'),
(5, 'Soja', 'Dit product bevat soja');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `Id` int NOT NULL,
  `Straat` varchar(255) DEFAULT NULL,
  `Huisnummer` int DEFAULT NULL,
  `Postcode` varchar(10) DEFAULT NULL,
  `Stad` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `contact`
--

INSERT INTO `contact` (`Id`, `Straat`, `Huisnummer`, `Postcode`, `Stad`) VALUES
(1, 'Den Van Gilslaan', 34, '1045CB', 'Hilvarenbee'),
(2, 'Den', 2, '1067R', 'Utre'),
(3, 'Fredo Raalteweg', 257, '1236OP', 'Nijmegen'),
(4, 'Bertrand Russellhof', 21, '2034AP', 'Den Haag'),
(5, 'Leon van Bonstraa', 21, '145XC', 'Lunteren'),
(6, 'Bea van Lingenlaan', 234, '2197FG', 'Sint Pancras');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` varchar(250) NOT NULL,
  `CapitalCity` varchar(250) NOT NULL,
  `Continent` varchar(250) NOT NULL,
  `Population` int UNSIGNED NOT NULL,
  `Zipcode` varchar(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `country`
--

INSERT INTO `country` (`Id`, `Name`, `CapitalCity`, `Continent`, `Population`, `Zipcode`) VALUES
(1, 'Nederland', 'Amsterdam', 'Europa', 18000000, '2309CB'),
(2, 'Argentini&euml;', 'Buenos Aires', 'Zuid-Amerika', 429496729, '2309CC'),
(4, 'Japan', 'Tokio', 'Azi&euml;', 125700000, '8761EE'),
(5, 'Zwitserlandd', 'Bern', 'Europa', 8703000, '2345RR'),
(6, 'Noorwegen', 'Oslo', 'Europa', 5550203, '2314UT'),
(11, 'Litouwen', 'Vilnius', 'Europa', 340000000, '9382YY'),
(15, 'Marokko', 'Rabat', 'Afrika', 37500000, '1243HH'),
(16, 'Nepal', 'Kathmandu', 'Azi&euml;', 30000000, '6534GG'),
(17, 'Chili', 'Santiago', 'Zuid-Amerika', 18276870, '8347AA'),
(18, 'Japan', 'Tokio', 'Azi&euml;', 125700000, '2342TT');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `leverancier`
--

DROP TABLE IF EXISTS `leverancier`;
CREATE TABLE IF NOT EXISTS `leverancier` (
  `Id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(60) NOT NULL,
  `Contactpersoon` varchar(60) NOT NULL,
  `Leveranciernummer` varchar(11) NOT NULL,
  `Mobiel` varchar(11) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `leverancier`
--

INSERT INTO `leverancier` (`Id`, `Naam`, `Contactpersoon`, `Leveranciernummer`, `Mobiel`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Venco', 'Bert van Linge', 'L1029384719', '06-28493825', b'1', NULL, '2024-12-05 16:18:16.078368', '2024-12-05 16:18:16.078370'),
(2, 'Astra Sweets', 'Jasper del Monte', 'L102928431', '06-3', b'1', NULL, '2024-12-05 16:18:16.078402', '2024-12-05 16:18:16.078402'),
(3, 'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', b'1', NULL, '2024-12-05 16:18:16.078418', '2024-12-05 16:18:16.078418'),
(4, 'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', b'1', NULL, '2024-12-05 16:18:16.078423', '2024-12-05 16:18:16.078423'),
(5, 'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291', b'1', NULL, '2024-12-05 16:18:16.078428', '2024-12-05 16:18:16.078428');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `magazijn`
--

DROP TABLE IF EXISTS `magazijn`;
CREATE TABLE IF NOT EXISTS `magazijn` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `VerpakkingsEenheid` decimal(4,1) NOT NULL,
  `AantalAanwezig` smallint UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `ProductId` (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `magazijn`
--

INSERT INTO `magazijn` (`Id`, `ProductId`, `VerpakkingsEenheid`, `AantalAanwezig`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 5.0, 65535, b'1', NULL, '2024-12-05 16:18:16.031808', '2030-02-22 00:00:00.000000'),
(2, 2, 2.5, 400, b'1', NULL, '2024-12-05 16:18:16.031851', '2024-12-05 16:18:16.031851'),
(3, 3, 5.0, 5001, b'1', NULL, '2024-12-05 16:18:16.031870', '2006-05-05 00:00:00.000000'),
(4, 4, 1.0, 1000, b'1', NULL, '2024-12-05 16:18:16.031878', '2013-02-13 00:00:00.000000'),
(5, 5, 3.0, 234, b'1', NULL, '2024-12-05 16:18:16.031885', '2024-12-05 16:18:16.031886'),
(6, 6, 2.0, 345, b'1', NULL, '2024-12-05 16:18:16.031892', '2024-12-05 16:18:16.031892'),
(7, 7, 1.0, 1350, b'1', NULL, '2024-12-05 16:18:16.031899', '2205-02-01 00:00:00.000000'),
(8, 8, 10.0, 233, b'1', NULL, '2024-12-05 16:18:16.031906', '2024-12-05 16:18:16.031906'),
(9, 9, 2.5, 123, b'1', NULL, '2024-12-05 16:18:16.031913', '2024-12-05 16:18:16.031913'),
(11, 11, 2.0, 582, b'1', NULL, '2024-12-05 16:18:16.031927', '2013-05-20 00:00:00.000000'),
(12, 12, 1.0, 967, b'1', NULL, '2024-12-05 16:18:16.031935', '2013-05-23 00:00:00.000000'),
(13, 13, 5.0, 20, b'1', NULL, '2024-12-05 16:18:16.031942', '2024-12-05 16:18:16.031942');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(255) NOT NULL,
  `Barcode` varchar(13) NOT NULL,
  `Verpakkingseenheid` varchar(100) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `product`
--

INSERT INTO `product` (`Id`, `Naam`, `Barcode`, `Verpakkingseenheid`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Mintnopjes', '8719587231278', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894188', '2024-12-05 16:18:15.894189'),
(2, 'Schoolkrijt', '8719587326713', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894223', '2024-12-05 16:18:15.894223'),
(3, 'Honingdrop', '8719587327836', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894237', '2024-12-05 16:18:15.894238'),
(4, 'Zure Beren', '8719587321441', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894242', '2024-12-05 16:18:15.894242'),
(5, 'Cola Flesjes', '8719587321237', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894245', '2024-12-05 16:18:15.894245'),
(6, 'Turtles', '8719587322245', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894249', '2024-12-05 16:18:15.894249'),
(7, 'Witte Muizen', '8719587328256', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894252', '2024-12-05 16:18:15.894252'),
(8, 'Reuzen Slangen', '8719587325641', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894255', '2024-12-05 16:18:15.894255'),
(9, 'Zoute Rijen', '8719587322739', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894259', '2024-12-05 16:18:15.894259'),
(11, 'Drop Munten', '8719587322345', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894266', '2024-12-05 16:18:15.894266'),
(12, 'Kruis Drop', '8719587322265', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894269', '2024-12-05 16:18:15.894269'),
(13, 'Zoute Ruitjes', '8719587323256', 'Stuk', b'1', NULL, '2024-12-05 16:18:15.894272', '2024-12-05 16:18:15.894272');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `productperallergeen`
--

DROP TABLE IF EXISTS `productperallergeen`;
CREATE TABLE IF NOT EXISTS `productperallergeen` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `ProductId` int NOT NULL,
  `AllergeenId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `AllergeenId` (`AllergeenId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `productperallergeen`
--

INSERT INTO `productperallergeen` (`Id`, `ProductId`, `AllergeenId`) VALUES
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

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `productperleverancier`
--

DROP TABLE IF EXISTS `productperleverancier`;
CREATE TABLE IF NOT EXISTS `productperleverancier` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `LeverancierId` smallint UNSIGNED NOT NULL,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `DatumLevering` date NOT NULL,
  `Aantal` int UNSIGNED NOT NULL,
  `DatumEerstVolgendeLevering` date NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `LeverancierId` (`LeverancierId`),
  KEY `ProductId` (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `productperleverancier`
--

INSERT INTO `productperleverancier` (`Id`, `LeverancierId`, `ProductId`, `DatumLevering`, `Aantal`, `DatumEerstVolgendeLevering`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 1, '2030-02-22', 23, '2024-10-16', b'1', NULL, '2024-12-05 16:18:16.151107', '2024-12-05 16:18:16.151108'),
(2, 1, 1, '2030-02-22', 21, '2024-10-25', b'1', NULL, '2024-12-05 16:18:16.151151', '2024-12-05 16:18:16.151151'),
(3, 1, 2, '2024-10-09', 12, '2024-10-16', b'1', NULL, '2024-12-05 16:18:16.151169', '2024-12-05 16:18:16.151169'),
(4, 1, 3, '2024-10-10', 11, '2024-10-17', b'1', NULL, '2024-12-05 16:18:16.151178', '2024-12-05 16:18:16.151179'),
(5, 2, 4, '2024-10-14', 16, '2024-10-21', b'1', NULL, '2024-12-05 16:18:16.151187', '2024-12-05 16:18:16.151187'),
(6, 2, 4, '2024-10-21', 23, '2024-10-28', b'1', NULL, '2024-12-05 16:18:16.151195', '2024-12-05 16:18:16.151195'),
(7, 2, 5, '2024-10-14', 45, '2024-10-21', b'1', NULL, '2024-12-05 16:18:16.151203', '2024-12-05 16:18:16.151203'),
(8, 2, 6, '2024-10-14', 30, '2024-10-21', b'1', NULL, '2024-12-05 16:18:16.151212', '2024-12-05 16:18:16.151212'),
(9, 3, 7, '2024-10-12', 12, '2024-10-19', b'1', NULL, '2024-12-05 16:18:16.151220', '2024-12-05 16:18:16.151220'),
(10, 3, 7, '2024-10-19', 23, '2024-10-26', b'1', NULL, '2024-12-05 16:18:16.151229', '2024-12-05 16:18:16.151229'),
(11, 3, 8, '2024-10-10', 12, '2024-10-17', b'1', NULL, '2024-12-05 16:18:16.151239', '2024-12-05 16:18:16.151239'),
(12, 3, 9, '2024-10-11', 1, '2024-10-18', b'1', NULL, '2024-12-05 16:18:16.151247', '2024-12-05 16:18:16.151247'),
(14, 5, 11, '2024-10-10', 47, '2024-10-17', b'1', NULL, '2024-12-05 16:18:16.151263', '2024-12-05 16:18:16.151263'),
(15, 5, 11, '2024-10-19', 60, '2024-10-26', b'1', NULL, '2024-12-05 16:18:16.151271', '2024-12-05 16:18:16.151271'),
(16, 5, 12, '2024-10-11', 45, '0000-00-00', b'1', NULL, '2024-12-05 16:18:16.151281', '2024-12-05 16:18:16.151281'),
(17, 5, 13, '2024-10-12', 23, '0000-00-00', b'1', NULL, '2024-12-05 16:18:16.151292', '2024-12-05 16:18:16.151292');

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `magazijn`
--
ALTER TABLE `magazijn`
  ADD CONSTRAINT `magazijn_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `productperallergeen`
--
ALTER TABLE `productperallergeen`
  ADD CONSTRAINT `productperallergeen_ibfk_1` FOREIGN KEY (`AllergeenId`) REFERENCES `allergeen` (`Id`);

--
-- Beperkingen voor tabel `productperleverancier`
--
ALTER TABLE `productperleverancier`
  ADD CONSTRAINT `productperleverancier_ibfk_1` FOREIGN KEY (`LeverancierId`) REFERENCES `leverancier` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `productperleverancier_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
