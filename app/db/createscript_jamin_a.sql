-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Gegenereerd op: 05 feb 2025 om 10:41
-- Serverversie: 9.0.1
-- PHP-versie: 8.3.11

DROP DATABASE IF EXISTS `jamin_a`;
CREATE DATABASE `jamin_a`;
USE `jamin_a`;

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

CREATE PROCEDURE spGetAllAllergenen()
BEGIN
    SELECT 
        p.Id AS Id,
        p.Naam AS ProductNaam,
        a.Naam AS AllergeenNaam,
        a.Omschrijving AS AllergeenOmschrijving,
        m.AantalAanwezig
    FROM 
        product p
    INNER JOIN 
        productperallergeen pa ON p.Id = pa.ProductId
    INNER JOIN 
        allergeen a ON pa.AllergeenId = a.Id
    INNER JOIN 
        magazijn m ON p.Id = m.ProductId
    ORDER BY 
        p.Naam ASC;
END$$

CREATE PROCEDURE spGetAllContact(IN productId INT)
BEGIN
    SELECT 
        LEVE.Naam AS LeverancierNaam,
        LEVE.ContactPersoon AS ContactPersoon,
        CONT.Straat AS StraatNaam,
        CONT.Huisnummer AS HuisNummer,
        CONT.Postcode AS Postcode,
        CONT.Stad AS Stad
    FROM 
        product p
    INNER JOIN 
        productperleverancier ppl ON p.Id = ppl.ProductId
    INNER JOIN 
        leverancier LEVE ON ppl.LeverancierId = LEVE.Id
    INNER JOIN 
        contact CONT ON LEVE.ContactId = CONT.Id
    WHERE 
        p.Id = productId
    LIMIT 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `allergeen`
--

DROP TABLE IF EXISTS `allergeen`;
CREATE TABLE IF NOT EXISTS `allergeen` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(255) NOT NULL,
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
-- Tabelstructuur voor tabel `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `Id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Straat` varchar(100) NOT NULL,
  `Huisnummer` varchar(10) NOT NULL,
  `Postcode` varchar(6) NOT NULL,
  `Stad` varchar(50) NOT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL,
  `DatumGewijzigd` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `contact`
--

INSERT INTO `contact` (`Id`, `Straat`, `Huisnummer`, `Postcode`, `Stad`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Van Gilslaan', '34', '1045CB', 'Hilvarenbeek', '2025-01-20 18:53:57.213807', '2025-01-20 18:53:57.213831'),
(2, 'Den Dolderlaan', '2', '1067RC', 'Utrecht', '2025-01-20 18:53:57.214094', '2025-01-20 18:53:57.214096'),
(3, 'Fredo Raalteweg', '257', '1236OP', 'Nijmegen', '2025-01-20 18:53:57.214122', '2025-01-20 18:53:57.214122'),
(4, 'Bertrand Russellhof', '21', '2034AP', 'Den Haag', '2025-01-20 18:53:57.214132', '2025-01-20 18:53:57.214132'),
(5, 'Leon van Bonstraat', '213', '145XC', 'Lunter', '2025-01-20 18:53:57.214142', '2025-01-20 18:53:57.214142'),
(6, 'Bea van Lingenlaan', '234', '2197FG', 'Sint Pancras', '2025-01-20 18:53:57.214150', '2025-01-20 18:53:57.214150');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `country`
--

INSERT INTO `country` (`Id`, `Name`, `CapitalCity`, `Continent`, `Population`, `Zipcode`) VALUES
(2, 'Tanzania', 'Dodoma', 'Afrika', 63590000, '1234SD'),
(4, 'Japan', 'Tokio', 'Azi&euml;', 125700000, '2345BA'),
(5, 'Zwitserlandd', 'Bern', 'Europa', 8703000, '6712AS'),
(6, 'Noorwegen', 'Oslo', 'Europa', 5550203, '6782BA'),
(11, 'Litouwen', 'Vilnius', 'Europa', 340000000, '3456AZ'),
(15, 'Marokko', 'Rabat', 'Afrika', 37500000, '8132AS'),
(16, 'Nepal', 'Kathmandu', 'Azi&euml;', 30000000, '6789BA'),
(17, 'Chili', 'Santiago', 'Zuid-Amerika', 18276870, '3721AB');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `leverancier`
--

DROP TABLE IF EXISTS `leverancier`;
CREATE TABLE IF NOT EXISTS `leverancier` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(100) NOT NULL,
  `ContactPersoon` varchar(100) NOT NULL,
  `LeverancierNummer` varchar(20) NOT NULL,
  `Mobiel` varchar(15) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `ContactId` INT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `leverancier`
--

INSERT INTO `leverancier` (`Id`, `Naam`, `ContactPersoon`, `LeverancierNummer`, `Mobiel`, `IsActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`, `ContactId`) VALUES
(1, 'Venco', 'Bert van Linge', 'L1029384719', '06-28493827', b'1', NULL, '2024-11-13 19:30:05.345220', '2024-11-13 19:30:05.345220', 1),
(2, 'Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398734', b'1', NULL, '2024-11-13 19:30:05.345220', '2024-11-13 19:30:05.345220', 2),
(3, 'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', b'1', NULL, '2024-11-13 19:30:05.345220', '2024-11-13 19:30:05.345220', 3),
(4, 'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', b'1', NULL, '2024-11-13 19:30:05.345220', '2024-11-13 19:30:05.345220', 4),
(5, 'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', b'1', NULL, '2024-11-13 19:30:05.345220', '2024-11-13 19:30:05.345220', 5),
(6, 'Quality Street', 'Johan Nooij', 'L1029234586', '06-23458456', b'1', NULL, '2024-11-13 19:30:05.345220', '2024-11-13 19:30:05.345220', 6),
(7, 'Hom Ken Food', 'Hom Ken', 'L1029234599', '06-23458477', b'1', NULL, '2024-11-13 19:30:05.345220', '2024-11-13 19:30:05.345220', NULL);

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
  `Opmerking` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_Magazijn_ProductId_Product_Id` (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `magazijn`
--

INSERT INTO `magazijn` (`Id`, `ProductId`, `VerpakkingsEenheid`, `AantalAanwezig`, `IsActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 5.0, 453, b'1', NULL, '2024-11-13 19:30:05.239404', '2024-11-13 19:30:05.239405'),
(2, 2, 2.5, 400, b'1', NULL, '2024-11-13 19:30:05.239444', '2024-11-13 19:30:05.239444'),
(3, 3, 5.0, 1, b'1', NULL, '2024-11-13 19:30:05.239460', '2024-11-13 19:30:05.239460'),
(4, 4, 1.0, 800, b'1', NULL, '2024-11-13 19:30:05.239467', '2024-11-13 19:30:05.239468'),
(5, 5, 3.0, 234, b'1', NULL, '2024-11-13 19:30:05.239474', '2024-11-13 19:30:05.239474'),
(6, 6, 2.0, 345, b'1', NULL, '2024-11-13 19:30:05.239480', '2024-11-13 19:30:05.239480'),
(7, 7, 1.0, 795, b'1', NULL, '2024-11-13 19:30:05.239486', '2024-11-13 19:30:05.239486'),
(8, 8, 10.0, 233, b'1', NULL, '2024-11-13 19:30:05.239492', '2024-11-13 19:30:05.239493'),
(9, 9, 2.5, 123, b'1', NULL, '2024-11-13 19:30:05.239499', '2024-11-13 19:30:05.239499'),
(10, 10, 3.0, 0, b'1', NULL, '2024-11-13 19:30:05.239504', '2024-11-13 19:30:05.239504'),
(11, 11, 12.0, 367, b'1', NULL, '2024-11-13 19:30:05.239510', '2024-11-13 19:30:05.239510'),
(12, 12, 1.0, 467, b'1', NULL, '2024-11-13 19:30:05.239516', '2024-11-13 19:30:05.239516'),
(13, 13, 5.0, 20, b'1', NULL, '2024-11-13 19:30:05.239522', '2024-11-13 19:30:05.239522'),
(14, 14, 2.5, 150, b'1', NULL, '2024-11-13 19:30:05.239523', '2024-11-13 19:30:05.239523');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(255) NOT NULL,
  `Barcode` varchar(13) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `product`
--

INSERT INTO `product` (`Id`, `Naam`, `Barcode`, `IsActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Mintnopjes', '8719587231278', b'1', NULL, '2024-11-13 19:30:05.178726', '2024-11-13 19:30:05.178727'),
(2, 'Schoolkrijt', '8719587326713', b'1', NULL, '2024-11-13 19:30:05.178758', '2024-11-13 19:30:05.178759'),
(3, 'Honingdrop', '8719587327836', b'1', NULL, '2024-11-13 19:30:05.178771', '2024-11-13 19:30:05.178771'),
(4, 'Zure Beren', '8719587321441', b'1', NULL, '2024-11-13 19:30:05.178775', '2024-11-13 19:30:05.178775'),
(5, 'Cola Flesjes', '8719587321237', b'1', NULL, '2024-11-13 19:30:05.178782', '2024-11-13 19:30:05.178782'),
(6, 'Turtles', '8719587322245', b'1', NULL, '2024-11-13 19:30:05.178786', '2024-11-13 19:30:05.178786'),
(7, 'Witte Muizen', '8719587328256', b'1', NULL, '2024-11-13 19:30:05.178789', '2024-11-13 19:30:05.178789'),
(8, 'Reuzen Slangen', '8719587325641', b'1', NULL, '2024-11-13 19:30:05.178793', '2024-11-13 19:30:05.178793'),
(9, 'Zoute Rijen', '8719587322739', b'1', NULL, '2024-11-13 19:30:05.178797', '2024-11-13 19:30:05.178797'),
(10, 'Winegums', '8719587327527', b'1', NULL, '2024-11-13 19:30:05.178800', '2024-11-13 19:30:05.178800'),
(11, 'Drop Munten', '8719587322345', b'1', NULL, '2024-11-13 19:30:05.178803', '2024-11-13 19:30:05.178803'),
(12, 'Kruis Drop', '8719587322265', b'1', NULL, '2024-11-13 19:30:05.178807', '2024-11-13 19:30:05.178807'),
(13, 'Zoute Ruitjes', '8719587323256', b'1', NULL, '2024-11-13 19:30:05.178810', '2024-11-13 19:30:05.178811'),
(14, 'Drop ninja''s', '8719587323277', b'1', NULL, '2024-11-13 19:30:05.178812', '2024-11-13 19:30:05.178812');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `productperallergeen`
--

DROP TABLE IF EXISTS `productperallergeen`;
CREATE TABLE IF NOT EXISTS `productperallergeen` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `AllergeenId` mediumint UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_ProductPerAllergeen_ProductId` (`ProductId`),
  KEY `FK_ProductPerAllergeen_AllergeenId` (`AllergeenId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `productperallergeen`
--

INSERT INTO `productperallergeen` (`Id`, `ProductId`, `AllergeenId`, `IsActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 2, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(2, 1, 1, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(3, 1, 3, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(4, 3, 4, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(5, 6, 5, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(6, 9, 2, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(7, 9, 5, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(8, 10, 2, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(9, 12, 4, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(10, 13, 1, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(11, 13, 4, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(12, 13, 5, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308'),
(13, 14, 5, b'1', NULL, '2024-11-13 19:30:05.300308', '2024-11-13 19:30:05.300308');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `productperleverancier`
--

DROP TABLE IF EXISTS `productperleverancier`;
CREATE TABLE IF NOT EXISTS `productperleverancier` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `LeverancierId` mediumint UNSIGNED NOT NULL,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `DatumLevering` date NOT NULL,
  `Aantal` int NOT NULL,
  `DatumEerstVolgendeLevering` date NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_ProductPerLeverancier_ProductId` (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `productperleverancier`
--

INSERT INTO `productperleverancier` (`Id`, `LeverancierId`, `ProductId`, `DatumLevering`, `Aantal`, `DatumEerstVolgendeLevering`, `IsActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 1, '2024-10-09', 23, '2024-10-16', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(2, 1, 1, '2024-10-18', 21, '2024-10-25', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(3, 1, 2, '2024-10-09', 12, '2024-10-16', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(4, 1, 3, '2024-10-10', 11, '2024-10-17', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(5, 2, 4, '2024-10-14', 16, '2024-10-21', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(6, 2, 4, '2024-10-21', 23, '2024-10-28', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(7, 2, 5, '2024-10-14', 45, '2024-10-21', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(8, 3, 6, '2024-10-10', 30, '2024-10-17', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(9, 3, 7, '2024-10-12', 12, '2024-10-19', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(10, 3, 7, '2024-10-19', 18, '2024-10-26', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(11, 3, 8, '2024-10-10', 12, '2024-10-17', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(12, 3, 9, '2024-10-11', 1, '2024-10-18', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(13, 4, 10, '2024-10-16', 0, '2024-04-30', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(14, 5, 11, '2024-10-10', 47, '2024-10-17', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(15, 5, 11, '2024-10-19', 60, '2024-10-26', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(16, 5, 12, '2024-10-11', 45, '0000-00-00', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(17, 5, 13, '2024-10-12', 23, '0000-00-00', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839'),
(18, 1, 14, '2024-10-12', 25, '2024-10-19', b'1', NULL, '2024-11-13 19:30:05.403839', '2024-11-13 19:30:05.403839');

-- Wijzig de leverancier voor product 14
UPDATE productperleverancier 
SET LeverancierId = 7
WHERE ProductId = 14;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `reuzenrad`
--

DROP TABLE IF EXISTS `reuzenrad`;
CREATE TABLE IF NOT EXISTS `reuzenrad` (
  `Id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(100) NOT NULL,
  `Hoogte` smallint NOT NULL,
  `Land` varchar(100) NOT NULL,
  `Kosten` int NOT NULL,
  `AantalPassagiers` int NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `reuzenrad`
--

INSERT INTO `reuzenrad` (`Id`, `Naam`, `Hoogte`, `Land`, `Kosten`, `AantalPassagiers`) VALUES
(6, 'Ain Dubai', 250, 'Verenigde Arabische Emiraten', 270, 1750),
(7, 'High Roller', 168, 'Verenigde Staten', 203, 1120),
(8, 'Singapore Flyer', 165, 'Singapore', 240, 784),
(9, 'Star of Nanchang', 160, 'China', 57, 480),
(10, 'London Eye', 135, 'Engeland', 65, 320);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('FYhkVZ3RCdJGRTha40OPSo4DEOTV4pvjYZTF9hIx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRTFkaDU0SFh3UjV4bFdVbjJ2UHJvbVlzYlF2NHdjS0RzMkl5VEFUciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hbGxlcmdlbmVuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1738752098);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `zangeres`
--

DROP TABLE IF EXISTS `zangeres`;
CREATE TABLE IF NOT EXISTS `zangeres` (
  `Id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(100) NOT NULL,
  `NettoWaarde` smallint NOT NULL,
  `Land` varchar(100) NOT NULL,
  `Mobiel` varchar(20) NOT NULL,
  `Leeftijd` tinyint NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `zangeres`
--

INSERT INTO `zangeres` (`Id`, `Naam`, `NettoWaarde`, `Land`, `Mobiel`, `Leeftijd`) VALUES
(1, 'Rihanna', 1400, 'Barbados', '+1246240001862400', 36),
(2, 'Madonna', 575, 'Verenigde Staten', '+1 3425 185876', 65),
(3, 'Taylor', 570, 'Verenigde Staten', '+1 5876 236512', 34),
(4, 'Beyoncé', 420, 'Verenigde Staten', '+1 6794908465', 42),
(5, 'Jennifer Lopez', 400, 'Verenigde Staten', '+1 3131 857345', 54);

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `magazijn`
--
ALTER TABLE `magazijn`
  ADD CONSTRAINT `FK_Magazijn_ProductId_Product_Id` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`);

--
-- Beperkingen voor tabel `productperallergeen`
--
ALTER TABLE `productperallergeen`
  ADD CONSTRAINT `FK_ProductPerAllergeen_AllergeenId` FOREIGN KEY (`AllergeenId`) REFERENCES `allergeen` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_ProductPerAllergeen_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `productperleverancier`
--
ALTER TABLE `productperleverancier`
  ADD CONSTRAINT `FK_ProductPerLeverancier_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;