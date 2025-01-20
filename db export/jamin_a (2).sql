-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Gegenereerd op: 20 jan 2025 om 17:56
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
  `id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefoon` varchar(20) DEFAULT NULL,
  `straat` varchar(255) DEFAULT NULL,
  `huisnummer` varchar(10) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `stad` varchar(255) DEFAULT NULL,
  `bericht` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `contact`
--

INSERT INTO `contact` (`id`, `naam`, `email`, `telefoon`, `straat`, `huisnummer`, `postcode`, `stad`, `bericht`, `created_at`) VALUES
(1, '', '', NULL, 'Van Gilslaan', '34', '1045CB', 'Hilvarenbeek', NULL, '2025-01-20 17:34:23'),
(2, '', '', NULL, 'Den Dolderpad', '2', '1067RC', 'Utrecht', NULL, '2025-01-20 17:34:23'),
(3, '', '', NULL, 'Fredo Raalteweg', '257', '1236OP', 'Nijmegen', NULL, '2025-01-20 17:34:23'),
(4, '', '', NULL, 'Bertrand Russellhof', '21', '2034AP', 'Den Haag', NULL, '2025-01-20 17:34:23'),
(5, '', '', NULL, 'Leon van Bonstraat', '213', '145XC', 'Lunteren', NULL, '2025-01-20 17:34:23'),
(6, '', '', NULL, 'Bea van Lingenlaan', '234', '2197FG', 'Sint Pancras', NULL, '2025-01-20 17:34:23');

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
(1, 'Venco', 'Bert van Linge', 'L1029384719', '06-28493827', b'1', NULL, '2025-01-20 17:59:35.729590', '2025-01-20 17:59:35.729593'),
(2, 'Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398823', b'1', NULL, '2025-01-20 17:59:35.729635', '2025-01-20 17:59:35.729635'),
(3, 'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', b'1', NULL, '2025-01-20 17:59:35.729654', '2025-01-20 17:59:35.729655'),
(4, 'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', b'1', NULL, '2025-01-20 17:59:35.729661', '2025-01-20 17:59:35.729661'),
(5, 'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', b'1', NULL, '2025-01-20 17:59:35.729667', '2025-01-20 17:59:35.729667');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `product`
--

INSERT INTO `product` (`Id`, `Naam`, `Barcode`, `Verpakkingseenheid`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Mintnopjes', '8719587231278', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602016', '2025-01-20 16:58:52.602019'),
(2, 'Schoolkrijt', '8719587326713', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602066', '2025-01-20 16:58:52.602066'),
(3, 'Honingdrop', '8719587327836', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602082', '2025-01-20 16:58:52.602082'),
(4, 'Zure Beren', '8719587321441', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602088', '2025-01-20 16:58:52.602088'),
(5, 'Cola Flesjes', '8719587321237', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602092', '2025-01-20 16:58:52.602092'),
(6, 'Turtles', '8719587322245', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602097', '2025-01-20 16:58:52.602097'),
(7, 'Witte Muizen', '8719587328256', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602101', '2025-01-20 16:58:52.602102'),
(8, 'Reuzen Slangen', '8719587325641', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602106', '2025-01-20 16:58:52.602106'),
(9, 'Zoute Rijen', '8719587322739', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602111', '2025-01-20 16:58:52.602111'),
(10, 'Drop Munten', '8719587322345', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602115', '2025-01-20 16:58:52.602115'),
(11, 'Kruis Drop', '8719587322265', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602123', '2025-01-20 16:58:52.602124'),
(12, 'Zoute Ruitjes', '8719587323256', 'Stuk', b'1', NULL, '2025-01-20 16:58:52.602129', '2025-01-20 16:58:52.602129');

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
