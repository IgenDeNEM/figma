-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost
-- Létrehozás ideje: 2024. Dec 29. 01:29
-- Kiszolgáló verziója: 11.5.2-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `strawmta`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `accounts`
--

CREATE TABLE `accounts` (
  `accountId` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(128) NOT NULL,
  `suspended` int(1) NOT NULL DEFAULT 0,
  `serial` varchar(32) NOT NULL,
  `email` varchar(128) NOT NULL,
  `maxCharacters` int(11) NOT NULL DEFAULT 1,
  `adminLevel` int(11) NOT NULL DEFAULT 0,
  `adminNick` varchar(32) NOT NULL DEFAULT 'Admin',
  `helperLevel` int(11) NOT NULL DEFAULT 0,
  `premiumPoints` int(11) NOT NULL DEFAULT 0,
  `osvenyPiro` int(11) NOT NULL DEFAULT 0,
  `osvenyPrioExperie` int(11) NOT NULL DEFAULT 0,
  `2fa` varchar(24) DEFAULT NULL,
  `2fastate` int(1) NOT NULL DEFAULT 0,
  `discordId` bigint(20) DEFAULT NULL,
  `discordAuth` varchar(24) DEFAULT NULL,
  `discordName` varchar(124) DEFAULT NULL,
  `adminJailType` int(1) DEFAULT NULL,
  `adminJailBy` varchar(16) DEFAULT NULL,
  `adminJailTime` int(16) DEFAULT NULL,
  `adminJailReason` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `accounts`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `adminstats`
--

CREATE TABLE `adminstats` (
  `characterIdentity` int(11) NOT NULL,
  `adminName` varchar(256) DEFAULT NULL,
  `dutyTime` int(11) NOT NULL DEFAULT 0,
  `reportStat` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `vehicleFixes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `playerFixes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `armorChange` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `healthChange` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `resettedVehicles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `adminJail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `playerKick` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `playerBan` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `playerUnjail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `adminstats`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `animals`
--

CREATE TABLE `animals` (
  `animalId` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `type` enum('Husky','Rottweiler','Doberman','Bull Terrier','Boxer','Francia Bulldog','Kecske','Diszno') NOT NULL,
  `name` varchar(32) NOT NULL,
  `health` float NOT NULL DEFAULT 100,
  `hunger` float NOT NULL DEFAULT 100,
  `love` float NOT NULL DEFAULT 100
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;

--
-- A tábla adatainak kiíratása `animals`
--



-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `armors`
--

CREATE TABLE `armors` (
  `armorId` int(11) NOT NULL,
  `health` int(11) NOT NULL DEFAULT 100,
  `characterId` int(11) NOT NULL,
  `model` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `armors`
--



-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `characters`
--

CREATE TABLE `characters` (
  `characterId` int(11) NOT NULL,
  `accountId` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `skin` int(11) NOT NULL,
  `permGroupSkin` varchar(16) NOT NULL DEFAULT 'N',
  `creationStage` int(11) NOT NULL DEFAULT 5,
  `canSkipCreation` int(1) NOT NULL DEFAULT 0,
  `x` double NOT NULL DEFAULT 1682.7392578125,
  `y` double NOT NULL DEFAULT -2328.7177734375,
  `z` double NOT NULL DEFAULT 13.546875,
  `r` double NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `dimension` int(11) NOT NULL DEFAULT 0,
  `money` int(11) NOT NULL DEFAULT 50000,
  `bankMoney` int(11) NOT NULL DEFAULT 0,
  `playedMinutes` int(11) NOT NULL DEFAULT 0,
  `inDeath` int(1) NOT NULL DEFAULT 0,
  `coins` int(11) NOT NULL DEFAULT 0,
  `boughtClothes` longtext NOT NULL DEFAULT '[[]]',
  `clothesPos` longtext NOT NULL DEFAULT '\'[[]]\'',
  `clothesLimit` int(11) NOT NULL DEFAULT 2,
  `health` int(11) NOT NULL DEFAULT 100,
  `armor` int(11) NOT NULL DEFAULT 0,
  `hunger` int(11) NOT NULL DEFAULT 100,
  `thirst` int(11) NOT NULL DEFAULT 100,
  `lastOnline` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `actionBarItems` longtext NOT NULL,
  `skills` longtext NOT NULL DEFAULT '[[]]',
  `weaponPos` longtext NOT NULL DEFAULT '[[]]',
  `armors` longtext NOT NULL DEFAULT '[[]]',
  `inDuty` text NOT NULL DEFAULT '""',
  `online` int(11) NOT NULL DEFAULT 0,
  `vehiclesSlot` int(11) NOT NULL DEFAULT 2,
  `interiorsSlot` int(11) NOT NULL DEFAULT 2,
  `facePaint` int(11) NOT NULL DEFAULT 0,
  `playerRecipes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`playerRecipes`)),
  `radioFreq` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[[0, 0]]' CHECK (json_valid(`radioFreq`)),
  `jail` int(1) NOT NULL DEFAULT 0,
  `jailTime` int(16) NOT NULL DEFAULT 0,
  `jailReason` varchar(124) DEFAULT NULL,
  `jailCell` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `characters`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `companies`
--

CREATE TABLE `companies` (
  `companyId` int(11) NOT NULL,
  `companyName` text NOT NULL,
  `taxNumber` text NOT NULL,
  `taxAmount` int(11) NOT NULL,
  `ownerCharacterId` int(11) NOT NULL,
  `activity` text NOT NULL,
  `postfix` text NOT NULL,
  `createdBy` text NOT NULL,
  `books` text NOT NULL,
  `prefix` text NOT NULL,
  `created` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `companies`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `coupons`
--

CREATE TABLE `coupons` (
  `dbID` int(11) NOT NULL,
  `couponName` text NOT NULL,
  `couponType` enum('pp','money','item') NOT NULL,
  `couponUsage` int(11) NOT NULL,
  `couponValue` int(11) NOT NULL,
  `couponUsed` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `couponItem` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `coupons`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `discordcodes`
--

CREATE TABLE `discordcodes` (
  `dbId` int(11) NOT NULL,
  `discordUID` longtext DEFAULT NULL,
  `serial` varchar(32) NOT NULL,
  `code` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `farms`
--

CREATE TABLE `farms` (
  `id` int(11) NOT NULL,
  `pos` int(11) NOT NULL DEFAULT 0,
  `rentedBy` int(11) NOT NULL DEFAULT 0,
  `tableText` varchar(255) NOT NULL,
  `exteriorId` varchar(255) NOT NULL,
  `renterName` varchar(255) NOT NULL,
  `locked` int(11) NOT NULL,
  `fork` int(11) NOT NULL,
  `hoe` int(11) NOT NULL,
  `loadpos` varchar(255) NOT NULL,
  `miniHoe` int(11) NOT NULL,
  `size` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `animalDatas` mediumtext NOT NULL DEFAULT '[[]]',
  `farmId` int(11) NOT NULL,
  `landDatas` mediumtext NOT NULL DEFAULT '[[]]',
  `permissions` varchar(255) NOT NULL DEFAULT '[[]]',
  `expire` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `garages`
--

CREATE TABLE `garages` (
  `dbID` int(11) NOT NULL,
  `interiorId` int(11) NOT NULL,
  `sizeX` int(11) NOT NULL DEFAULT 1,
  `sizeY` int(11) NOT NULL DEFAULT 1,
  `furnishing` int(1) NOT NULL DEFAULT 1,
  `kruton` int(1) NOT NULL DEFAULT 0,
  `workbench` int(1) NOT NULL DEFAULT 0,
  `door` int(11) NOT NULL DEFAULT 1,
  `toolbox` int(11) NOT NULL DEFAULT 1,
  `wall` int(11) NOT NULL DEFAULT 1,
  `ceiling` int(11) NOT NULL DEFAULT 1,
  `floor` int(11) NOT NULL DEFAULT 1,
  `lift1` int(11) NOT NULL DEFAULT 0,
  `lift2` int(11) NOT NULL DEFAULT 0,
  `lift3` int(11) NOT NULL DEFAULT 0,
  `lift4` int(11) NOT NULL DEFAULT 0,
  `lift5` int(11) NOT NULL DEFAULT 0,
  `lift1Z` float NOT NULL DEFAULT 0,
  `lift2Z` float NOT NULL DEFAULT 0,
  `lift3Z` float NOT NULL DEFAULT 0,
  `lift4Z` float NOT NULL DEFAULT 0,
  `lift5Z` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `garages`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `groupmembers`
--

CREATE TABLE `groupmembers` (
  `dbId` int(11) NOT NULL,
  `characterId` int(11) NOT NULL,
  `groupPrefix` varchar(32) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `isLeader` int(11) NOT NULL DEFAULT 0,
  `added` bigint(11) NOT NULL DEFAULT 0,
  `promoted` bigint(11) NOT NULL DEFAULT 0,
  `lastOnline` bigint(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `groupmembers`
--

INSERT INTO `groupmembers` (`dbId`, `characterId`, `groupPrefix`, `rank`, `isLeader`, `added`, `promoted`, `lastOnline`) VALUES
(1, 7, 'OV', 1, 1, 1722968340, 1722968340, 0),
(9, 8, 'LM', 1, 0, 1722981321, 1722981321, 0),
(10, 10, 'RING', 1, 0, 1723039453, 1723039453, 0),
(12, 5, 'RING', 1, 1, 1723061714, 1723061714, 0),
(13, 10, 'BMS', 1, 0, 1723298756, 1723298756, 0),
(15, 13, 'OV', 1, 0, 1723722035, 1723722035, 0),
(18, 16, 'NNI', 1, 1, 1728392697, 1728392697, 0),
(21, 14, 'PD', 1, 1, 1728415113, 1730051661, 0),
(24, 17, 'PD', 3, 1, 1728922495, 1731778067, 0),
(25, 17, 'SG', 11, 1, 1728930264, 1734168240, 0),
(26, 17, 'OV', 3, 1, 1729092331, 1729092334, 0),
(29, 18, 'PD', 1, 0, 1729429524, 1729429524, 0),
(30, 17, 'OMSZ', 1, 0, 1729682585, 1729682585, 0),
(34, 1, 'SG', 11, 0, 1729881183, 1734168237, 0),
(35, 20, 'RING', 1, 1, 1729887218, 1729887218, 0),
(41, 20, 'PD', 5, 1, 1729888862, 1729888924, 0),
(42, 1, 'PD', 1, 0, 1729890274, 1729890274, 0),
(43, 1, 'NAV', 1, 1, 1729894892, 1729894892, 0),
(45, 17, 'NDR', 1, 1, 1730667122, 1730667122, 0),
(47, 1, 'OMSZ', 1, 0, 1730757320, 1730757320, 0),
(48, 18, 'OV', 3, 1, 1730910237, 1731079965, 0),
(49, 14, 'SOD', 1, 1, 1732044721, 1732044721, 0),
(50, 14, 'TAXI', 1, 1, 1732213840, 1732213840, 0),
(52, 17, 'APMS', 1, 1, 1734114629, 1734114629, 0),
(54, 28, 'PD', 1, 1, 1734167847, 1734167847, 0),
(55, 28, 'OPSZ', 1, 1, 1734167850, 1734167850, 0),
(56, 28, 'SG', 10, 1, 1734168133, 1734168234, 0),
(57, 15, 'SG', 12, 1, 1734168262, 1734168264, 0),
(61, 15, 'PD', 1, 0, 1734267822, 1734267822, 0),
(62, 17, 'PF', 1, 0, 1734704562, 1734704562, 0),
(63, 17, 'BMS', 1, 1, 1734705380, 1734705380, 0),
(64, 18, 'BMS', 1, 0, 1734952654, 1734952654, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `groups`
--

CREATE TABLE `groups` (
  `dbId` int(11) NOT NULL,
  `groupPrefix` varchar(32) NOT NULL,
  `rankNames` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ "Rang 1", "Rang 2", "Rang 3" ] ]',
  `rankColors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ "green", "green", "green" ] ]',
  `rankSalaries` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ 0, 0, 0 ] ]' CHECK (json_valid(`rankSalaries`)),
  `rankPermissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`rankPermissions`)),
  `rankSkins` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`rankSkins`)),
  `rankItems` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`rankItems`)),
  `vehicleMembers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`vehicleMembers`)),
  `interiorMembers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`interiorMembers`)),
  `motd` text NOT NULL DEFAULT 'Leírás',
  `balance` bigint(11) NOT NULL DEFAULT 0,
  `aid` int(11) NOT NULL DEFAULT 0,
  `tax` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `groups`
--

INSERT INTO `groups` (`dbId`, `groupPrefix`, `rankNames`, `rankColors`, `rankSalaries`, `rankPermissions`, `rankSkins`, `rankItems`, `vehicleMembers`, `interiorMembers`, `motd`, `balance`, `aid`, `tax`) VALUES
(1, 'NNI', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 100000, 0, 0 ] ]', '[ [ { \"promoteDemote\": true, \"alnev\": true, \"goldrobMute\": true, \"rbs\": true, \"departmentRadio\": true, \"manageKeysVehicle\": true, \"medic\": true, \"manageKeysInterior\": true, \"borderControl\": true, \"packerTow\": true, \"graffitiClean\": true, \"hireFire\": true, \"mdcrevoke\": true, \"mdc\": true, \"editInteriors\": true, \"badge\": true, \"departmentBlip\": true, \"goldrobLock\": true, \"goldrobDestroy\": true, \"applyBag\": true, \"squad\": true, \"nion\": true, \"spike\": true, \"manageKeysGate\": true, \"manageGroupBalance\": true, \"goldrobRepairGarage\": true, \"editPed\": true, \"traffi\": true, \"gov\": true, \"jail\": true, \"megaphone\": true, \"lenyomoz\": true, \"interiorLock\": true, \"mdcdelwar\": true }, { \"jail\": false, \"promoteDemote\": false, \"alnev\": false, \"traffi\": false, \"goldrobMute\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"goldrobLock\": false, \"medic\": false, \"squad\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"departmentBlip\": false, \"mdcrevoke\": false, \"mdcdelwar\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"interiorLock\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"lenyomoz\": false, \"megaphone\": false, \"nion\": false, \"spike\": false, \"borderControl\": false }, { \"jail\": false, \"promoteDemote\": false, \"alnev\": false, \"traffi\": false, \"goldrobMute\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"goldrobLock\": false, \"medic\": false, \"squad\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"departmentBlip\": false, \"mdcrevoke\": false, \"mdcdelwar\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"interiorLock\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"lenyomoz\": false, \"megaphone\": false, \"nion\": false, \"spike\": false, \"borderControl\": false } ] ]', '[ [ [ true, true, true, true, true, true, true ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ { \"480\": true, \"292\": true, \"483\": true, \"486\": true, \"77\": true, \"93\": true, \"533\": true, \"493\": true, \"94\": true, \"155\": true, \"372\": true, \"612\": true, \"500\": true, \"314\": true, \"561\": true, \"507\": true, \"575\": true, \"83\": true, \"115\": true, \"520\": true, \"100\": true, \"528\": true, \"556\": true, \"534\": true, \"536\": true, \"86\": true, \"540\": true, \"118\": true, \"512\": true, \"505\": true, \"291\": true, \"119\": true, \"69\": true, \"88\": true, \"471\": true, \"537\": true, \"542\": true, \"562\": true, \"541\": true, \"613\": true, \"127\": true, \"592\": true, \"427\": true }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"427\": false, \"533\": false, \"537\": false, \"94\": false, \"541\": false, \"372\": false, \"612\": false, \"127\": false, \"314\": false, \"505\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"69\": false, \"561\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"542\": false, \"528\": false, \"512\": false, \"500\": false, \"613\": false, \"77\": false, \"88\": false, \"556\": false, \"291\": false, \"471\": false, \"562\": false, \"118\": false, \"93\": false, \"155\": false, \"119\": false, \"493\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"427\": false, \"533\": false, \"537\": false, \"94\": false, \"541\": false, \"372\": false, \"612\": false, \"127\": false, \"314\": false, \"505\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"69\": false, \"561\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"542\": false, \"528\": false, \"512\": false, \"500\": false, \"613\": false, \"77\": false, \"88\": false, \"556\": false, \"291\": false, \"471\": false, \"562\": false, \"118\": false, \"93\": false, \"155\": false, \"119\": false, \"493\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 1000000000, 0, 0),
(2, 'TEK', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"editPed\": false, \"mdcrevoke\": false, \"manageKeysInterior\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"manageGroupBalance\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"goldrobLock\": false, \"goldrobMute\": false, \"jail\": false }, { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"editPed\": false, \"mdcrevoke\": false, \"manageKeysInterior\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"manageGroupBalance\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"goldrobLock\": false, \"goldrobMute\": false, \"jail\": false }, { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"editPed\": false, \"mdcrevoke\": false, \"manageKeysInterior\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"manageGroupBalance\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"goldrobLock\": false, \"goldrobMute\": false, \"jail\": false } ] ]', '[ [ [ false, false, false, false, false ], [ false, false, false, false, false ], [ false, false, false, false, false ] ] ]', '[ [ { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"556\": false, \"512\": false, \"505\": false, \"119\": false, \"291\": false, \"88\": false, \"471\": false, \"69\": false, \"542\": false, \"562\": false, \"537\": false, \"541\": false, \"77\": false, \"127\": false, \"613\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"556\": false, \"512\": false, \"505\": false, \"119\": false, \"291\": false, \"88\": false, \"471\": false, \"69\": false, \"542\": false, \"562\": false, \"537\": false, \"541\": false, \"77\": false, \"127\": false, \"613\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"556\": false, \"512\": false, \"505\": false, \"119\": false, \"291\": false, \"88\": false, \"471\": false, \"69\": false, \"542\": false, \"562\": false, \"537\": false, \"541\": false, \"77\": false, \"127\": false, \"613\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(3, 'APMS', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false } ] ]', '[ [ [ false, false, false, false ], [ false, false, false, false ], [ false, false, false, false ] ] ]', '[ [ { \"127\": false, \"440\": false, \"287\": false }, { \"127\": false, \"440\": false, \"287\": false }, { \"127\": false, \"440\": false, \"287\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(4, 'NAV', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"alnev\": false, \"goldrobMute\": false, \"rbs\": false, \"departmentRadio\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"borderControl\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"mdcrevoke\": false, \"mdc\": false, \"editInteriors\": false, \"departmentBlip\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"squad\": false, \"spike\": false, \"editCompany\": false, \"editPed\": false, \"manageKeysGate\": false, \"manageGroupBalance\": false, \"goldrobRepairGarage\": false, \"manageCompanyTax\": false, \"traffi\": false, \"medic\": false, \"jail\": false, \"megaphone\": false, \"interiorLock\": false, \"createCompany\": false, \"mdcdelwar\": false }, { \"promoteDemote\": false, \"alnev\": false, \"goldrobMute\": false, \"rbs\": false, \"departmentRadio\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"borderControl\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"mdcrevoke\": false, \"mdc\": false, \"editInteriors\": false, \"departmentBlip\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"squad\": false, \"spike\": false, \"editCompany\": false, \"editPed\": false, \"manageKeysGate\": false, \"manageGroupBalance\": false, \"goldrobRepairGarage\": false, \"manageCompanyTax\": false, \"traffi\": false, \"medic\": false, \"jail\": false, \"megaphone\": false, \"interiorLock\": false, \"createCompany\": false, \"mdcdelwar\": false }, { \"promoteDemote\": false, \"alnev\": false, \"goldrobMute\": false, \"rbs\": false, \"departmentRadio\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"borderControl\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"mdcrevoke\": false, \"mdc\": false, \"editInteriors\": false, \"departmentBlip\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"squad\": false, \"spike\": false, \"editCompany\": false, \"editPed\": false, \"manageKeysGate\": false, \"manageGroupBalance\": false, \"goldrobRepairGarage\": false, \"manageCompanyTax\": false, \"traffi\": false, \"medic\": false, \"jail\": false, \"megaphone\": false, \"interiorLock\": false, \"createCompany\": false, \"mdcdelwar\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"77\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"556\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"512\": false, \"505\": false, \"291\": false, \"119\": false, \"69\": false, \"88\": false, \"471\": false, \"537\": false, \"542\": false, \"562\": false, \"541\": false, \"613\": false, \"592\": false, \"427\": false, \"127\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"77\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"556\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"512\": false, \"505\": false, \"291\": false, \"119\": false, \"69\": false, \"88\": false, \"471\": false, \"537\": false, \"542\": false, \"562\": false, \"541\": false, \"613\": false, \"592\": false, \"427\": false, \"127\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"77\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"556\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"512\": false, \"505\": false, \"291\": false, \"119\": false, \"69\": false, \"88\": false, \"471\": false, \"537\": false, \"542\": false, \"562\": false, \"541\": false, \"613\": false, \"592\": false, \"427\": false, \"127\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(5, 'ROB', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(6, 'OKF', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"departmentBlip\": false, \"hireFire\": false, \"rbs\": false, \"departmentRadio\": false, \"editInteriors\": false, \"medic\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"interiorLock\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"departmentBlip\": false, \"hireFire\": false, \"rbs\": false, \"departmentRadio\": false, \"editInteriors\": false, \"medic\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"interiorLock\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"departmentBlip\": false, \"hireFire\": false, \"rbs\": false, \"departmentRadio\": false, \"editInteriors\": false, \"medic\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"interiorLock\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ { \"127\": false, \"98\": false, \"427\": false, \"100\": false }, { \"127\": false, \"98\": false, \"427\": false, \"100\": false }, { \"127\": false, \"98\": false, \"427\": false, \"100\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(7, 'ARMY', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"editPed\": false, \"mdcrevoke\": false, \"manageKeysInterior\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"manageGroupBalance\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"goldrobLock\": false, \"goldrobMute\": false, \"jail\": false }, { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"editPed\": false, \"mdcrevoke\": false, \"manageKeysInterior\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"manageGroupBalance\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"goldrobLock\": false, \"goldrobMute\": false, \"jail\": false }, { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"editPed\": false, \"mdcrevoke\": false, \"manageKeysInterior\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"manageGroupBalance\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"goldrobLock\": false, \"goldrobMute\": false, \"jail\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"556\": false, \"512\": false, \"505\": false, \"119\": false, \"291\": false, \"88\": false, \"471\": false, \"69\": false, \"542\": false, \"562\": false, \"537\": false, \"541\": false, \"77\": false, \"613\": false, \"107\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"556\": false, \"512\": false, \"505\": false, \"119\": false, \"291\": false, \"88\": false, \"471\": false, \"69\": false, \"542\": false, \"562\": false, \"537\": false, \"541\": false, \"77\": false, \"613\": false, \"107\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"556\": false, \"512\": false, \"505\": false, \"119\": false, \"291\": false, \"88\": false, \"471\": false, \"69\": false, \"542\": false, \"562\": false, \"537\": false, \"541\": false, \"77\": false, \"613\": false, \"107\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(8, 'FIX', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false } ] ]', '[ [ [ false, false, false, false, false ], [ false, false, false, false, false ], [ false, false, false, false, false ] ] ]', '[ [ { \"127\": false, \"440\": false, \"287\": false }, { \"127\": false, \"440\": false, \"287\": false }, { \"127\": false, \"440\": false, \"287\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(9, 'TOW', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"hireFire\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"hireFire\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"hireFire\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false } ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ { \"127\": false }, { \"127\": false }, { \"127\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(10, 'CLUB', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"fishradio\": false, \"manageKeysGate\": false, \"clubradio\": false, \"manageKeysVehicle\": false, \"hireFire\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"pavilionradio\": false }, { \"promoteDemote\": false, \"fishradio\": false, \"manageKeysGate\": false, \"clubradio\": false, \"manageKeysVehicle\": false, \"hireFire\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"pavilionradio\": false }, { \"promoteDemote\": false, \"fishradio\": false, \"manageKeysGate\": false, \"clubradio\": false, \"manageKeysVehicle\": false, \"hireFire\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"pavilionradio\": false } ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(11, 'OPSZ', '[ [ \"OOC\\/Admin\", \"Inaktív\", \"Polgárőr\", \"Polgárőr-vezető\" ] ]', '[ [ \"blue\", \"red\", \"yellow\", \"orange-second\" ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"jail\": false, \"mdcrevoke\": false, \"goldrobMute\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"goldrobLock\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"manageGroupBalance\": false, \"manageKeysInterior\": false, \"editPed\": false }, { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"editPed\": false, \"mdcrevoke\": false, \"manageKeysInterior\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"manageGroupBalance\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"goldrobLock\": false, \"goldrobMute\": false, \"jail\": false }, { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"jail\": false, \"mdcrevoke\": false, \"goldrobMute\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"goldrobLock\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"manageGroupBalance\": false, \"manageKeysInterior\": false, \"editPed\": false }, { \"promoteDemote\": false, \"traffi\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"editPed\": false, \"mdcrevoke\": false, \"manageKeysInterior\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"manageGroupBalance\": false, \"editInteriors\": false, \"departmentBlip\": false, \"mdcdelwar\": false, \"megaphone\": false, \"goldrobLock\": false, \"goldrobMute\": false, \"jail\": false } ] ]', '[ [ [ ], [ ], [ ], [ ] ] ]', '[ [ { \"118\": false, \"119\": false, \"127\": false, \"532\": false, \"534\": false, \"314\": false, \"527\": false, \"574\": false, \"561\": false }, { \"118\": false, \"119\": false, \"127\": false, \"532\": false, \"534\": false, \"314\": false, \"527\": false, \"574\": false, \"561\": false }, { \"118\": false, \"119\": false, \"127\": false, \"532\": false, \"534\": false, \"314\": false, \"527\": false, \"574\": false, \"561\": false }, { \"118\": false, \"119\": false, \"127\": false, \"532\": false, \"534\": false, \"314\": false, \"527\": false, \"574\": false, \"561\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(12, 'TAXI', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"hireFire\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"promoteDemote\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"taximeter\": false }, { \"hireFire\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"promoteDemote\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"taximeter\": false }, { \"hireFire\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"promoteDemote\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"taximeter\": false } ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ { \"127\": false, \"316\": false, \"317\": false }, { \"127\": false, \"316\": false, \"317\": false }, { \"127\": false, \"316\": false, \"317\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0);
INSERT INTO `groups` (`dbId`, `groupPrefix`, `rankNames`, `rankColors`, `rankSalaries`, `rankPermissions`, `rankSkins`, `rankItems`, `vehicleMembers`, `interiorMembers`, `motd`, `balance`, `aid`, `tax`) VALUES
(13, 'SG', '[ [ \"Inaktív\", \"Minimum alatti\", \"Normál teljesítményű\", \"Normál feletti\", \"Adminsegéd\", \"Adminisztrátor\", \"FőAdmin\", \"SzuperAdmin\", \"Director\", \"Contributor\", \"Fejlesztő\", \"Tulajdonos\" ] ]', '[ [ \"red\", \"blue\", \"green\", \"yellow\", \"purple-second\", \"green\", \"yellow\", \"orange\", \"orange-second\", \"green\", \"blue\", \"red\" ] ]', '[ [ 0, 0, 0, 0, 35000, 70000, 100000, 0, 0, 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"graffiti\": false, \"borderControl\": false, \"packerTow\": false, \"department\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"traffi\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"craft:431\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"jail\": false, \"interiorLock\": false, \"mechanicCheckout\": false, \"casetteOpen\": false, \"megaphone\": false, \"departmentBlip\": false, \"atmRob\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"craft:85\": false, \"craft:444\": false, \"squad\": false, \"nion\": false, \"manageGroupBalance\": false, \"pavilionradio\": false, \"goldrobRepairGarage\": false, \"alnev\": false, \"craft:76\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"clubradio\": false, \"medic\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"createCompany\": false, \"craft:82\": false, \"manageCompanyTax\": false, \"editPed\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"graffiti\": false, \"borderControl\": false, \"packerTow\": false, \"department\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"traffi\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"craft:431\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"jail\": false, \"interiorLock\": false, \"mechanicCheckout\": false, \"casetteOpen\": false, \"megaphone\": false, \"departmentBlip\": false, \"atmRob\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"craft:85\": false, \"craft:444\": false, \"squad\": false, \"nion\": false, \"manageGroupBalance\": false, \"pavilionradio\": false, \"goldrobRepairGarage\": false, \"alnev\": false, \"craft:76\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"clubradio\": false, \"medic\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"createCompany\": false, \"craft:82\": false, \"manageCompanyTax\": false, \"editPed\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"graffiti\": false, \"borderControl\": false, \"packerTow\": false, \"department\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"traffi\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"craft:431\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"jail\": false, \"interiorLock\": false, \"mechanicCheckout\": false, \"casetteOpen\": false, \"megaphone\": false, \"departmentBlip\": false, \"atmRob\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"craft:85\": false, \"craft:444\": false, \"squad\": false, \"nion\": false, \"manageGroupBalance\": false, \"pavilionradio\": false, \"goldrobRepairGarage\": false, \"alnev\": false, \"craft:76\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"clubradio\": false, \"medic\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"createCompany\": false, \"craft:82\": false, \"manageCompanyTax\": false, \"editPed\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"graffiti\": false, \"borderControl\": false, \"packerTow\": false, \"department\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"traffi\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"craft:431\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"jail\": false, \"interiorLock\": false, \"mechanicCheckout\": false, \"casetteOpen\": false, \"megaphone\": false, \"departmentBlip\": false, \"atmRob\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"craft:85\": false, \"craft:444\": false, \"squad\": false, \"nion\": false, \"manageGroupBalance\": false, \"pavilionradio\": false, \"goldrobRepairGarage\": false, \"alnev\": false, \"craft:76\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"clubradio\": false, \"medic\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"createCompany\": false, \"craft:82\": false, \"manageCompanyTax\": false, \"editPed\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"casetteOpen\": false, \"borderControl\": false, \"packerTow\": false, \"department\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"traffi\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"craft:431\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"jail\": false, \"interiorLock\": false, \"mechanicCheckout\": false, \"departmentBlip\": false, \"megaphone\": false, \"atmRob\": false, \"craft:85\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"craft:444\": false, \"medic\": false, \"squad\": false, \"nion\": false, \"manageGroupBalance\": false, \"pavilionradio\": false, \"goldrobRepairGarage\": false, \"alnev\": false, \"craft:76\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"clubradio\": false, \"graffiti\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"createCompany\": false, \"craft:82\": false, \"manageCompanyTax\": false, \"editPed\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"casetteOpen\": false, \"craft:444\": false, \"packerTow\": false, \"craft:85\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"departmentBlip\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"alnev\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"editPed\": false, \"manageCompanyTax\": false, \"mechanicCheckout\": false, \"craft:82\": false, \"createCompany\": false, \"manageGroupBalance\": false, \"department\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"borderControl\": false, \"medic\": false, \"squad\": false, \"nion\": false, \"atmRob\": false, \"pavilionradio\": false, \"clubradio\": false, \"departmentRadio\": false, \"manageKeysGate\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"craft:76\": false, \"craft:431\": false, \"goldrobRepairGarage\": false, \"graffiti\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"megaphone\": false, \"traffi\": false, \"interiorLock\": false, \"jail\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"casetteOpen\": false, \"borderControl\": false, \"packerTow\": false, \"department\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"traffi\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"craft:431\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"jail\": false, \"interiorLock\": false, \"mechanicCheckout\": false, \"departmentBlip\": false, \"megaphone\": false, \"atmRob\": false, \"craft:85\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"craft:444\": false, \"medic\": false, \"squad\": false, \"nion\": false, \"manageGroupBalance\": false, \"pavilionradio\": false, \"goldrobRepairGarage\": false, \"alnev\": false, \"craft:76\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"clubradio\": false, \"graffiti\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"createCompany\": false, \"craft:82\": false, \"manageCompanyTax\": false, \"editPed\": false }, { \"promoteDemote\": false, \"goldrobMute\": true, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": true, \"medic\": false, \"borderControl\": false, \"packerTow\": false, \"department\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"departmentBlip\": false, \"goldrobLock\": true, \"goldrobDestroy\": true, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": true, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"alnev\": false, \"departmentRadio\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"jail\": true, \"interiorLock\": false, \"mechanicCheckout\": false, \"traffi\": false, \"megaphone\": false, \"atmRob\": true, \"craft:85\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"craft:444\": false, \"graffiti\": false, \"squad\": false, \"nion\": false, \"manageGroupBalance\": false, \"pavilionradio\": false, \"goldrobRepairGarage\": false, \"craft:431\": false, \"craft:76\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"manageKeysGate\": false, \"crateOpen\": false, \"clubradio\": false, \"casetteOpen\": true, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"createCompany\": false, \"craft:82\": false, \"manageCompanyTax\": false, \"editPed\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"medic\": false, \"borderControl\": false, \"packerTow\": false, \"craft:85\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"traffi\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"useD\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"craft:431\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"editPed\": false, \"craft:82\": false, \"mechanicCheckout\": false, \"manageCompanyTax\": false, \"createCompany\": false, \"manageGroupBalance\": false, \"department\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"graffiti\": false, \"departmentBlip\": false, \"squad\": false, \"nion\": false, \"atmRob\": false, \"pavilionradio\": false, \"clubradio\": false, \"departmentRadio\": false, \"manageKeysGate\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"craft:76\": false, \"alnev\": false, \"goldrobRepairGarage\": false, \"craft:444\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"megaphone\": false, \"casetteOpen\": false, \"interiorLock\": false, \"jail\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"graffiti\": false, \"borderControl\": false, \"packerTow\": false, \"department\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"traffi\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"craft:431\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"jail\": false, \"interiorLock\": false, \"mechanicCheckout\": false, \"casetteOpen\": false, \"megaphone\": false, \"departmentBlip\": false, \"atmRob\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"craft:85\": false, \"craft:444\": false, \"squad\": false, \"nion\": false, \"manageGroupBalance\": false, \"pavilionradio\": false, \"goldrobRepairGarage\": false, \"alnev\": false, \"craft:76\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"clubradio\": false, \"medic\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"createCompany\": false, \"craft:82\": false, \"manageCompanyTax\": false, \"editPed\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"casetteOpen\": false, \"craft:444\": false, \"packerTow\": false, \"craft:85\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"departmentBlip\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"alnev\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"editPed\": false, \"manageCompanyTax\": false, \"mechanicCheckout\": false, \"craft:82\": false, \"createCompany\": false, \"manageGroupBalance\": false, \"department\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"borderControl\": false, \"medic\": false, \"squad\": false, \"nion\": false, \"atmRob\": false, \"pavilionradio\": false, \"clubradio\": false, \"departmentRadio\": false, \"manageKeysGate\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"craft:76\": false, \"craft:431\": false, \"goldrobRepairGarage\": false, \"graffiti\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"megaphone\": false, \"traffi\": false, \"interiorLock\": false, \"jail\": false }, { \"promoteDemote\": false, \"goldrobMute\": false, \"rbs\": false, \"nixorder\": false, \"impoundBikes\": false, \"graffiti\": false, \"borderControl\": false, \"packerTow\": false, \"department\": false, \"hireFire\": false, \"craft:17\": false, \"editInteriors\": false, \"craft:65\": false, \"badge\": false, \"engineKey\": false, \"traffi\": false, \"goldrobLock\": false, \"goldrobDestroy\": false, \"mechanicCheckStock\": false, \"craft:79\": false, \"craft:561\": false, \"spike\": false, \"robGoldBank\": false, \"fishradio\": false, \"editCompany\": false, \"craft:233\": false, \"weaponHide\": false, \"mechanicStats\": false, \"mdcdelwar\": false, \"craft:445\": false, \"craft:431\": false, \"crateOpen\": false, \"manageKeysVehicle\": false, \"listCompanies\": false, \"manageKeysInterior\": false, \"craft:87\": false, \"graffitiClean\": false, \"mdcrevoke\": false, \"vehicleExam\": false, \"mdc\": false, \"packerImpound\": false, \"craft:16\": false, \"craft:70\": false, \"craft:84\": false, \"jail\": false, \"interiorLock\": false, \"mechanicCheckout\": false, \"casetteOpen\": false, \"megaphone\": false, \"departmentBlip\": false, \"atmRob\": false, \"applyBag\": false, \"manageInvoiceBooks\": false, \"craft:85\": false, \"craft:444\": false, \"squad\": false, \"nion\": false, \"manageGroupBalance\": false, \"pavilionradio\": false, \"goldrobRepairGarage\": false, \"alnev\": false, \"craft:76\": false, \"unimpoundPolice\": false, \"craft:18\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"clubradio\": false, \"medic\": false, \"taximeter\": false, \"gov\": false, \"lenyomoz\": false, \"createCompany\": false, \"craft:82\": false, \"manageCompanyTax\": false, \"editPed\": false } ] ]', '[ [ [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ] ] ]', '[ [ [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 35000000, 0, 0),
(14, 'NDR', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(15, 'OMSZ', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"departmentBlip\": false, \"manageKeysInterior\": false, \"rbs\": false, \"departmentRadio\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"medic\": false, \"megaphone\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"departmentBlip\": false, \"manageKeysInterior\": false, \"rbs\": false, \"departmentRadio\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"medic\": false, \"megaphone\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"departmentBlip\": false, \"manageKeysInterior\": false, \"rbs\": false, \"departmentRadio\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"medic\": false, \"megaphone\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ { \"127\": false, \"314\": false, \"100\": false, \"612\": false, \"592\": false }, { \"127\": false, \"314\": false, \"100\": false, \"612\": false, \"592\": false }, { \"127\": false, \"314\": false, \"100\": false, \"612\": false, \"592\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(16, 'OV', '[ [ \"Rang 1\", \"Rang 2\", \"Scripteri\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 400 ] ]', '[ [ { \"craft:84\": true, \"promoteDemote\": true, \"craft:431\": true, \"craft:18\": true, \"nion\": true, \"craft:70\": true, \"crateOpen\": true, \"craft:82\": true, \"applyBag\": true, \"manageKeysVehicle\": true, \"graffiti\": true, \"casetteOpen\": true, \"craft:79\": true, \"editPed\": true, \"manageGroupBalance\": true, \"robGoldBank\": true, \"craft:85\": true, \"hireFire\": true, \"craft:17\": true, \"craft:444\": true, \"craft:233\": true, \"manageKeysGate\": true, \"craft:561\": true, \"weaponHide\": true, \"craft:87\": true, \"editInteriors\": true, \"craft:76\": true, \"craft:16\": true, \"craft:445\": true, \"manageKeysInterior\": true, \"craft:65\": true, \"atmRob\": true }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"craft:79\": false, \"craft:70\": false, \"crateOpen\": false, \"editPed\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"atmRob\": false, \"casetteOpen\": false, \"manageKeysInterior\": false, \"nion\": false, \"manageGroupBalance\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"craft:444\": false, \"craft:233\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:87\": false, \"editInteriors\": false, \"manageKeysGate\": false, \"craft:16\": false, \"craft:445\": false, \"graffiti\": false, \"craft:65\": false, \"craft:82\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": true, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": true, \"craft:79\": false, \"craft:87\": false, \"atmRob\": true, \"robGoldBank\": true, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false } ] ]', '[ [ [ true, true, true, true, true, true, true ], [ false, false, false, false, false, false, false ], [ false, false, false, false, true, true, true ] ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 1010000, 0, 0),
(17, 'PD', '[ [ \"TULAJDONOS\", \"Rang 2\", \"Rang 5\", \"Rang 6\", \"Rang 7\", \"Rang 8\", \"Rang 9\" ] ]', '[ [ \"blue-second\", \"green\", \"green\", \"green\", \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": true, \"goldrobMute\": true, \"rbs\": true, \"departmentRadio\": true, \"manageKeysVehicle\": true, \"medic\": true, \"manageKeysInterior\": true, \"editPed\": true, \"packerTow\": true, \"graffitiClean\": true, \"hireFire\": true, \"mdcrevoke\": true, \"mdc\": true, \"packerImpound\": true, \"editInteriors\": true, \"badge\": true, \"departmentBlip\": true, \"goldrobLock\": true, \"goldrobDestroy\": true, \"applyBag\": true, \"squad\": true, \"spike\": true, \"unimpoundPolice\": true, \"manageKeysGate\": true, \"goldrobRepairGarage\": true, \"mdcdelwar\": true, \"manageGroupBalance\": true, \"gov\": true, \"interiorLock\": true, \"megaphone\": true, \"traffi\": true, \"borderControl\": true, \"jail\": true }, { \"promoteDemote\": false, \"goldrobMute\": false, \"traffi\": false, \"rbs\": false, \"goldrobLock\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"mdcrevoke\": false, \"medic\": false, \"squad\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"interiorLock\": false, \"unimpoundPolice\": false, \"jail\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"packerImpound\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"mdcdelwar\": false, \"megaphone\": false, \"departmentBlip\": false, \"spike\": false, \"borderControl\": false }, { \"promoteDemote\": false, \"editPed\": false, \"traffi\": false, \"unimpoundPolice\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageGroupBalance\": false, \"medic\": false, \"squad\": false, \"borderControl\": false, \"spike\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"departmentBlip\": false, \"mdcrevoke\": false, \"manageKeysInterior\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"packerImpound\": false, \"editInteriors\": false, \"interiorLock\": false, \"mdcdelwar\": false, \"megaphone\": false, \"goldrobLock\": false, \"goldrobMute\": false, \"jail\": false }, { \"promoteDemote\": false, \"borderControl\": false, \"traffi\": false, \"spike\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"departmentBlip\": false, \"medic\": false, \"squad\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"interiorLock\": false, \"mdcrevoke\": false, \"jail\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"packerImpound\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"mdcdelwar\": false, \"megaphone\": false, \"unimpoundPolice\": false, \"goldrobLock\": false, \"goldrobMute\": false }, { \"promoteDemote\": false, \"borderControl\": false, \"traffi\": false, \"spike\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"departmentBlip\": false, \"medic\": false, \"squad\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"interiorLock\": false, \"mdcrevoke\": false, \"jail\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"packerImpound\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"mdcdelwar\": false, \"megaphone\": false, \"unimpoundPolice\": false, \"goldrobLock\": false, \"goldrobMute\": false }, { \"promoteDemote\": false, \"borderControl\": false, \"traffi\": false, \"spike\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"departmentBlip\": false, \"medic\": false, \"squad\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"interiorLock\": false, \"mdcrevoke\": false, \"jail\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"packerImpound\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"mdcdelwar\": false, \"megaphone\": false, \"unimpoundPolice\": false, \"goldrobLock\": false, \"goldrobMute\": false }, { \"promoteDemote\": false, \"borderControl\": false, \"traffi\": false, \"spike\": false, \"rbs\": false, \"departmentRadio\": false, \"goldrobDestroy\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"departmentBlip\": false, \"medic\": false, \"squad\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false, \"graffitiClean\": false, \"hireFire\": false, \"interiorLock\": false, \"mdcrevoke\": false, \"jail\": false, \"manageKeysGate\": false, \"mdc\": false, \"goldrobRepairGarage\": false, \"packerImpound\": false, \"editInteriors\": false, \"manageKeysInterior\": false, \"mdcdelwar\": false, \"megaphone\": false, \"unimpoundPolice\": false, \"goldrobLock\": false, \"goldrobMute\": false } ] ]', '[ [ [ true, true, true, true, true, true, true ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ { \"480\": true, \"292\": true, \"483\": true, \"486\": true, \"592\": true, \"427\": true, \"533\": true, \"537\": true, \"94\": true, \"541\": true, \"372\": true, \"612\": true, \"127\": true, \"314\": true, \"505\": true, \"507\": true, \"575\": true, \"83\": true, \"115\": true, \"520\": true, \"100\": true, \"69\": true, \"561\": true, \"534\": true, \"536\": true, \"86\": true, \"540\": true, \"542\": true, \"528\": true, \"512\": true, \"500\": true, \"613\": true, \"77\": true, \"88\": true, \"556\": true, \"291\": true, \"471\": true, \"562\": true, \"118\": true, \"93\": true, \"155\": true, \"119\": true, \"493\": true }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"427\": false, \"533\": false, \"537\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"127\": false, \"314\": false, \"505\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"69\": false, \"561\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"542\": false, \"528\": false, \"541\": false, \"500\": false, \"613\": false, \"77\": false, \"88\": false, \"471\": false, \"291\": false, \"118\": false, \"562\": false, \"556\": false, \"93\": false, \"512\": false, \"119\": false, \"493\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"77\": false, \"93\": false, \"533\": false, \"493\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"500\": false, \"314\": false, \"561\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"528\": false, \"556\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"118\": false, \"512\": false, \"505\": false, \"291\": false, \"119\": false, \"69\": false, \"88\": false, \"471\": false, \"537\": false, \"542\": false, \"562\": false, \"541\": false, \"613\": false, \"592\": false, \"127\": false, \"427\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"427\": false, \"533\": false, \"537\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"127\": false, \"314\": false, \"505\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"69\": false, \"561\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"542\": false, \"528\": false, \"541\": false, \"500\": false, \"613\": false, \"77\": false, \"88\": false, \"471\": false, \"291\": false, \"118\": false, \"562\": false, \"556\": false, \"93\": false, \"512\": false, \"119\": false, \"493\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"427\": false, \"533\": false, \"537\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"127\": false, \"314\": false, \"505\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"69\": false, \"561\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"542\": false, \"528\": false, \"541\": false, \"500\": false, \"613\": false, \"77\": false, \"88\": false, \"471\": false, \"291\": false, \"118\": false, \"562\": false, \"556\": false, \"93\": false, \"512\": false, \"119\": false, \"493\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"427\": false, \"533\": false, \"537\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"127\": false, \"314\": false, \"505\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"69\": false, \"561\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"542\": false, \"528\": false, \"541\": false, \"500\": false, \"613\": false, \"77\": false, \"88\": false, \"471\": false, \"291\": false, \"118\": false, \"562\": false, \"556\": false, \"93\": false, \"512\": false, \"119\": false, \"493\": false }, { \"480\": false, \"292\": false, \"483\": false, \"486\": false, \"592\": false, \"427\": false, \"533\": false, \"537\": false, \"94\": false, \"155\": false, \"372\": false, \"612\": false, \"127\": false, \"314\": false, \"505\": false, \"507\": false, \"575\": false, \"83\": false, \"115\": false, \"520\": false, \"100\": false, \"69\": false, \"561\": false, \"534\": false, \"536\": false, \"86\": false, \"540\": false, \"542\": false, \"528\": false, \"541\": false, \"500\": false, \"613\": false, \"77\": false, \"88\": false, \"471\": false, \"291\": false, \"118\": false, \"562\": false, \"556\": false, \"93\": false, \"512\": false, \"119\": false, \"493\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'pej dej', 40000, 40000, 0),
(18, 'NSM', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(19, 'CNC', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(20, 'DV', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0);
INSERT INTO `groups` (`dbId`, `groupPrefix`, `rankNames`, `rankColors`, `rankSalaries`, `rankPermissions`, `rankSkins`, `rankItems`, `vehicleMembers`, `interiorMembers`, `motd`, `balance`, `aid`, `tax`) VALUES
(21, 'LM', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": false, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": false, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(22, 'SOD', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"editPed\": false, \"craft:233\": false, \"crateOpen\": true, \"manageGroupBalance\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"manageKeysGate\": false, \"casetteOpen\": false, \"craft:79\": false, \"craft:87\": false, \"atmRob\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"graffiti\": true, \"craft:17\": false, \"craft:76\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:65\": false, \"editInteriors\": false, \"craft:444\": false, \"craft:16\": false, \"craft:445\": false, \"craft:82\": false, \"craft:70\": false, \"nion\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"atmRob\": false, \"craft:65\": false, \"crateOpen\": false, \"manageKeysInterior\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"casetteOpen\": false, \"graffiti\": false, \"craft:82\": false, \"nion\": false, \"manageGroupBalance\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"craft:444\": false, \"craft:76\": false, \"craft:17\": false, \"manageKeysGate\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:87\": false, \"editInteriors\": false, \"craft:233\": false, \"craft:16\": false, \"craft:445\": false, \"editPed\": false, \"craft:70\": false, \"craft:79\": false }, { \"craft:84\": false, \"promoteDemote\": false, \"craft:431\": false, \"craft:18\": false, \"atmRob\": false, \"craft:65\": false, \"crateOpen\": false, \"manageKeysInterior\": false, \"applyBag\": false, \"manageKeysVehicle\": false, \"casetteOpen\": false, \"graffiti\": false, \"craft:82\": false, \"nion\": false, \"manageGroupBalance\": false, \"robGoldBank\": false, \"craft:85\": false, \"hireFire\": false, \"craft:444\": false, \"craft:76\": false, \"craft:17\": false, \"manageKeysGate\": false, \"craft:561\": false, \"weaponHide\": false, \"craft:87\": false, \"editInteriors\": false, \"craft:233\": false, \"craft:16\": false, \"craft:445\": false, \"editPed\": false, \"craft:70\": false, \"craft:79\": false } ] ]', '[ [ [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ], [ false, false, false, false, false, false, false ] ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(23, 'BMS', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false } ] ]', '[ [ [ false, false, false, false, false, false ], [ false, false, false, false, false, false ], [ false, false, false, false, false, false ] ] ]', '[ [ { \"127\": false, \"440\": false, \"287\": false }, { \"127\": false, \"440\": false, \"287\": false }, { \"127\": false, \"440\": false, \"287\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(24, 'PF', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"departmentBlip\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"impoundBikes\": false, \"packerImpound\": false, \"manageKeysVehicle\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"departmentBlip\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"impoundBikes\": false, \"packerImpound\": false, \"manageKeysVehicle\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"departmentBlip\": false, \"manageKeysGate\": false, \"departmentRadio\": false, \"impoundBikes\": false, \"packerImpound\": false, \"manageKeysVehicle\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false } ] ]', '[ [ [ false, false, false, false ], [ false, false, false, false ], [ false, false, false, false ] ] ]', '[ [ { \"314\": false, \"127\": false }, { \"314\": false, \"127\": false }, { \"314\": false, \"127\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0),
(25, 'RING', '[ [ \"Rang 1\", \"Rang 2\", \"Rang 3\" ] ]', '[ [ \"green\", \"green\", \"green\" ] ]', '[ [ 0, 0, 0 ] ]', '[ [ { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false }, { \"promoteDemote\": false, \"engineKey\": false, \"mechanicCheckout\": false, \"vehicleExam\": false, \"manageKeysGate\": false, \"manageKeysVehicle\": false, \"nixorder\": false, \"mechanicCheckStock\": false, \"mechanicStats\": false, \"editInteriors\": false, \"hireFire\": false, \"manageKeysInterior\": false, \"editPed\": false, \"manageGroupBalance\": false, \"packerTow\": false } ] ]', '[ [ [ ], [ ], [ ] ] ]', '[ [ { \"440\": false, \"287\": false, \"127\": false }, { \"440\": false, \"287\": false, \"127\": false }, { \"440\": false, \"287\": false, \"127\": false } ] ]', '[ [ ] ]', '[ [ ] ]', 'Leírás', 0, 0, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `interiors`
--

CREATE TABLE `interiors` (
  `interiorId` int(11) NOT NULL,
  `outside` longtext NOT NULL,
  `inside` longtext NOT NULL,
  `name` varchar(64) NOT NULL,
  `zone` varchar(64) NOT NULL DEFAULT 'N/A',
  `type` varchar(32) NOT NULL,
  `ownerType` enum('group','player') NOT NULL DEFAULT 'player',
  `owner` text NOT NULL DEFAULT '0',
  `editable` varchar(1) NOT NULL DEFAULT 'N',
  `locked` int(1) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL,
  `rentTime` int(11) NOT NULL DEFAULT 0,
  `dummy` varchar(1) NOT NULL DEFAULT 'Y',
  `gameInterior` int(11) NOT NULL,
  `entrance_rotation` int(11) NOT NULL DEFAULT 0,
  `exit_rotation` int(11) NOT NULL DEFAULT 0,
  `deleted` varchar(1) NOT NULL DEFAULT 'N',
  `policeLock` text NOT NULL,
  `policeLockBy` text NOT NULL,
  `policeLockGroup` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `interiors`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `interior_datas`
--

CREATE TABLE `interior_datas` (
  `interiorId` int(11) NOT NULL,
  `paidCash` int(11) NOT NULL DEFAULT 0,
  `interiorData` longtext NOT NULL DEFAULT '',
  `dynamicData` varchar(255) NOT NULL DEFAULT '',
  `unlockedPP` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;

--
-- A tábla adatainak kiíratása `interior_datas`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `invoices`
--

CREATE TABLE `invoices` (
  `dbId` int(11) NOT NULL,
  `bookId` text NOT NULL,
  `invoiceId` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `netPrice` int(11) NOT NULL,
  `postfix` text NOT NULL,
  `companyName` text NOT NULL,
  `vatNumber` text NOT NULL,
  `buyer` text NOT NULL,
  `product` text NOT NULL,
  `sellerSign` text NOT NULL,
  `buyerSign` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `items`
--

CREATE TABLE `items` (
  `dbID` int(11) NOT NULL,
  `slot` int(3) NOT NULL,
  `itemId` int(3) NOT NULL,
  `amount` int(11) NOT NULL,
  `data1` longblob DEFAULT NULL,
  `data2` varchar(255) DEFAULT NULL,
  `data3` varchar(255) DEFAULT NULL,
  `nameTag` varchar(64) DEFAULT NULL,
  `serial` int(11) NOT NULL,
  `ownerType` varchar(32) NOT NULL,
  `ownerId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `items`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `lifts`
--

CREATE TABLE `lifts` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `dimension` int(11) NOT NULL DEFAULT 0,
  `lifted` int(11) NOT NULL DEFAULT 0,
  `slot` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `mdc_records`
--

CREATE TABLE `mdc_records` (
  `dbID` int(11) NOT NULL,
  `recordType` varchar(255) DEFAULT NULL,
  `punishedName` varchar(255) DEFAULT NULL,
  `recordBy` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `recordTime` int(11) DEFAULT NULL,
  `recordPunishment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `mdc_records`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `mdc_vehwarrants`
--

CREATE TABLE `mdc_vehwarrants` (
  `warrantId` int(11) NOT NULL,
  `wantedPlate` text NOT NULL,
  `creationDate` int(11) NOT NULL,
  `officerName` text NOT NULL,
  `reason` text NOT NULL,
  `wantedVehicleId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `mdc_vehwarrants`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `mdc_warrants`
--

CREATE TABLE `mdc_warrants` (
  `warrantId` int(11) NOT NULL,
  `wantedCharacterId` int(11) NOT NULL,
  `wantedName` text NOT NULL,
  `creationDate` text NOT NULL,
  `officerName` text NOT NULL,
  `reason` text NOT NULL,
  `isActive` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `mdc_warrants`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `paintshopperms`
--

CREATE TABLE `paintshopperms` (
  `dbID` int(11) NOT NULL,
  `playerIdentity` int(11) NOT NULL,
  `workshopIdentity` int(11) NOT NULL,
  `openClose` int(1) NOT NULL DEFAULT 0,
  `useSkin` int(1) NOT NULL DEFAULT 0,
  `useSander` int(1) NOT NULL DEFAULT 0,
  `usePaintGun` int(1) NOT NULL DEFAULT 0,
  `useToggleDry` int(1) NOT NULL DEFAULT 0,
  `useNextState` int(1) NOT NULL DEFAULT 0,
  `useStartJob` int(1) NOT NULL DEFAULT 0,
  `useCancelJob` int(1) NOT NULL DEFAULT 0,
  `useMixer` int(1) NOT NULL DEFAULT 0,
  `doMixerMaintance` int(1) NOT NULL DEFAULT 0,
  `createOrder` int(1) NOT NULL DEFAULT 0,
  `transportOrder` int(1) NOT NULL DEFAULT 0,
  `startTransport` int(1) NOT NULL DEFAULT 0,
  `endTransport` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `paintshops`
--

CREATE TABLE `paintshops` (
  `dbID` int(12) NOT NULL,
  `paintshopIdentity` int(12) NOT NULL,
  `rentedBy` int(12) NOT NULL,
  `rentUntil` int(64) NOT NULL,
  `lockedState` int(1) NOT NULL,
  `policeLockDatas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `paintshopName` varchar(64) NOT NULL,
  `paintshopCertificate` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '\'\\\'{{0, 0}}\\\'\'',
  `rentMode` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `peds`
--

CREATE TABLE `peds` (
  `id` int(11) NOT NULL,
  `owner` enum('interior','group','char','server') NOT NULL,
  `ownerId` text NOT NULL DEFAULT '-1',
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `posR` float NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  `skin` int(11) NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT 'PED',
  `balance` bigint(20) NOT NULL DEFAULT 0,
  `selectedItems` longtext NOT NULL,
  `categories` longtext NOT NULL,
  `pedPrice` longtext NOT NULL,
  `pedStock` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `phoneads`
--

CREATE TABLE `phoneads` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `adText` varchar(255) NOT NULL,
  `images` int(11) NOT NULL DEFAULT 0,
  `endTime` int(124) DEFAULT NULL,
  `startTime` int(124) DEFAULT NULL,
  `number` varchar(25) NOT NULL,
  `owner` varchar(105) NOT NULL DEFAULT '"N/A"',
  `adTitle` varchar(55) NOT NULL,
  `price` int(11) NOT NULL,
  `subType` int(11) NOT NULL,
  `highlighted` varchar(255) NOT NULL DEFAULT '[[]]',
  `photo1` mediumblob DEFAULT NULL,
  `photo2` mediumblob DEFAULT NULL,
  `photo3` mediumblob DEFAULT NULL,
  `photo4` mediumblob DEFAULT NULL,
  `senderCharId` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `phonemessages`
--

CREATE TABLE `phonemessages` (
  `recievedPhone` varchar(25) NOT NULL,
  `senderPhone` varchar(25) NOT NULL,
  `messageData` longblob NOT NULL,
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `phonemessages`
--



-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `phone_datas`
--

CREATE TABLE `phone_datas` (
  `id` int(11) NOT NULL,
  `number` varchar(25) NOT NULL,
  `settings` text NOT NULL DEFAULT '[ [ ] ]',
  `contacts` text NOT NULL DEFAULT ' [ [ { "number": "911", "name": "* SEGÉLYHÍVÓ *", "color": 7, "icon": "ambulance", "default": true }, { "number": "1818", "name": "* SZOLGÁLTATÁSOK *", "color": 4, "icon": "deskbell", "default": true }, { "number": "3876100107", "name": "* SCKH BÍRSÁG *", "color": 7, "icon": "car", "default": true }, { "number": "131", "name": "* EGYENLEGINFÓ *", "color": 8, "icon": "dollar", "default": true }, { "number": "387579460801", "name": "* A Valutás *", "color": 8, "icon": "dollar", "default": true }, { "number": "1331", "name": "* NET-COM *", "color": 9, "icon": "phone", "default": true } ] ]\'\t',
  `lastSMS` text NOT NULL DEFAULT '[ [ ] ]',
  `bank` int(11) NOT NULL DEFAULT 0,
  `titlebardatas` varchar(300) NOT NULL DEFAULT '[ [ { "name": "soundon", "enabled": true }, { "name": "vibration", "enabled": true }, { "name": "location", "enabled": true }, { "name": "microphone", "enabled": true } ] ]',
  `recentCalls` text NOT NULL DEFAULT '[ [ ] ]',
  `ringtone` int(11) NOT NULL DEFAULT 1,
  `wallpaper` int(11) NOT NULL DEFAULT 1,
  `noti` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `phone_datas`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `phone_images`
--

CREATE TABLE `phone_images` (
  `id` int(11) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `date` int(11) NOT NULL DEFAULT current_timestamp(),
  `position` varchar(255) NOT NULL DEFAULT '[ [ ] ]',
  `type` int(11) NOT NULL DEFAULT 2,
  `rotation` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `player_stat`
--

CREATE TABLE `player_stat` (
  `dbID` int(11) NOT NULL,
  `players` int(11) NOT NULL DEFAULT 0,
  `date` datetime DEFAULT NULL,
  `time` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- A tábla adatainak kiíratása `player_stat`
--



-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `premium`
--

CREATE TABLE `premium` (
  `codeId` int(11) NOT NULL,
  `code` text DEFAULT NULL,
  `codeState` enum('Valid','Used','Expired') DEFAULT NULL,
  `activationTimestamp` text DEFAULT NULL,
  `expireTimestamp` text DEFAULT NULL,
  `discordUserId` text DEFAULT NULL,
  `duration` text DEFAULT NULL,
  `roleType` enum('Silver','Gold','Diamond','Emerald') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `priorities`
--

CREATE TABLE `priorities` (
  `dbID` int(11) NOT NULL,
  `prioType` int(11) NOT NULL,
  `expireTimestamp` bigint(11) NOT NULL,
  `serial` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `safes`
--

CREATE TABLE `safes` (
  `dbID` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `rotZ` float NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  `ownerGroup` varchar(20) NOT NULL DEFAULT '0',
  `safeType` varchar(25) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;

--
-- A tábla adatainak kiíratása `safes`
--



-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `serverdatas`
--

CREATE TABLE `serverdatas` (
  `dbID` int(11) NOT NULL,
  `players` int(11) NOT NULL,
  `password` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `serverdatas`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tickets`
--

CREATE TABLE `tickets` (
  `dbID` int(11) NOT NULL,
  `money` int(11) NOT NULL,
  `reason` text NOT NULL,
  `offenderId` int(11) NOT NULL,
  `offenderName` text NOT NULL,
  `ticketDate` bigint(150) NOT NULL,
  `ticketBy` text NOT NULL,
  `ticketPlace` text NOT NULL,
  `ticketGroup` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `tickets`
--


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trashes`
--

CREATE TABLE `trashes` (
  `databaseId` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `rotZ` float NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  `modelId` int(11) NOT NULL,
  `lamart` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `trashes`
--



-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `undoneprocesses_connect`
--

CREATE TABLE `undoneprocesses_connect` (
  `id` int(11) NOT NULL,
  `details` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `undoneprocesses_discord`
--

CREATE TABLE `undoneprocesses_discord` (
  `id` int(11) NOT NULL,
  `details` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `undoneprocesses_main`
--

CREATE TABLE `undoneprocesses_main` (
  `id` int(11) NOT NULL,
  `details` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `vehicles`
--

CREATE TABLE `vehicles` (
  `dbID` int(22) NOT NULL,
  `characterId` int(22) NOT NULL,
  `modelId` int(3) NOT NULL,
  `groupPrefix` text DEFAULT NULL,
  `health` int(11) NOT NULL DEFAULT 1000,
  `position` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0 ] ]' CHECK (json_valid(`position`)),
  `parkPosition` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0 ] ]' CHECK (json_valid(`parkPosition`)),
  `rotation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ 0, 0, 0 ] ]',
  `color` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255 ] ]',
  `engine` int(11) NOT NULL DEFAULT 0,
  `ignition` int(11) NOT NULL DEFAULT 0,
  `light` int(11) NOT NULL DEFAULT 0,
  `handbrake` int(11) NOT NULL DEFAULT 0,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `oil` int(11) NOT NULL DEFAULT 1000,
  `checkengine` int(11) NOT NULL DEFAULT 0,
  `distance` int(11) NOT NULL DEFAULT 0,
  `locked` int(11) NOT NULL DEFAULT 0,
  `pulling` int(11) NOT NULL DEFAULT 0,
  `inService` int(11) DEFAULT NULL,
  `impounded` int(11) NOT NULL DEFAULT 0,
  `ecuValues` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`ecuValues`)),
  `balanceValue` int(11) NOT NULL DEFAULT 0,
  `customEcuValues` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`customEcuValues`)),
  `averageMultipler` int(11) NOT NULL DEFAULT 0,
  `performanceTuning` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ { "tire": 0, "turbo": 0, "weightReduction": 0, "brakes": 0, "suspension": 0, "ecu": 0, "engine": 0, "transmission": 0 } ]',
  `customBackfire` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`customBackfire`)),
  `backfire` int(11) NOT NULL DEFAULT 0,
  `customTurbo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`customTurbo`)),
  `nitro` int(11) NOT NULL DEFAULT 0,
  `nitroLevel` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`nitroLevel`)),
  `traffipaxRadar` int(11) NOT NULL DEFAULT 0,
  `driveType` varchar(1024) NOT NULL DEFAULT 'handling',
  `customDriveType` int(11) NOT NULL DEFAULT 0,
  `customHorn` int(11) NOT NULL DEFAULT 0,
  `lsdDoor` int(11) NOT NULL DEFAULT 0,
  `variant` int(11) NOT NULL DEFAULT 0,
  `steeringLock` int(11) NOT NULL DEFAULT 0,
  `offroadSetting` int(11) NOT NULL DEFAULT 0,
  `abs` int(11) NOT NULL DEFAULT 0,
  `paintjob` int(11) NOT NULL DEFAULT 0,
  `currentTexture` int(11) NOT NULL DEFAULT 0,
  `currentWheelTexture` int(11) NOT NULL DEFAULT 0,
  `currentHeadlightTexture` int(11) NOT NULL DEFAULT 0,
  `headlightColor` text NOT NULL DEFAULT 'ffffff',
  `wheelWidthFront` int(11) NOT NULL DEFAULT 0,
  `wheelWidthRear` int(11) NOT NULL DEFAULT 0,
  `spinner` int(11) NOT NULL DEFAULT 0,
  `spinnerColor` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`spinnerColor`)),
  `opticalTunings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`opticalTunings`)),
  `neon` text DEFAULT NULL,
  `neonData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`neonData`)),
  `airride` int(11) DEFAULT NULL,
  `airrideDatas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ ] ]' CHECK (json_valid(`airrideDatas`)),
  `airrideMemory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]' CHECK (json_valid(`airrideMemory`)),
  `wheelStates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ 0, 0, 0, 0 ] ]' CHECK (json_valid(`wheelStates`)),
  `panelStates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0 ] ]' CHECK (json_valid(`panelStates`)),
  `plate` varchar(8) DEFAULT NULL,
  `customPlate` varchar(8) DEFAULT NULL,
  `protected` bigint(11) DEFAULT NULL,
  `fuelType` text DEFAULT NULL,
  `supercharger` int(11) NOT NULL DEFAULT 0,
  `automaticShifter` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `vehicles`
--



--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`accountId`);

--
-- A tábla indexei `animals`
--
ALTER TABLE `animals`
  ADD PRIMARY KEY (`animalId`);

--
-- A tábla indexei `armors`
--
ALTER TABLE `armors`
  ADD PRIMARY KEY (`armorId`);

--
-- A tábla indexei `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`characterId`);

--
-- A tábla indexei `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`companyId`);

--
-- A tábla indexei `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `discordcodes`
--
ALTER TABLE `discordcodes`
  ADD PRIMARY KEY (`dbId`);

--
-- A tábla indexei `farms`
--
ALTER TABLE `farms`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `garages`
--
ALTER TABLE `garages`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `groupmembers`
--
ALTER TABLE `groupmembers`
  ADD PRIMARY KEY (`dbId`);

--
-- A tábla indexei `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`dbId`);

--
-- A tábla indexei `interiors`
--
ALTER TABLE `interiors`
  ADD PRIMARY KEY (`interiorId`);

--
-- A tábla indexei `interior_datas`
--
ALTER TABLE `interior_datas`
  ADD PRIMARY KEY (`interiorId`);

--
-- A tábla indexei `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`dbId`);

--
-- A tábla indexei `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `lifts`
--
ALTER TABLE `lifts`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `mdc_records`
--
ALTER TABLE `mdc_records`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `mdc_vehwarrants`
--
ALTER TABLE `mdc_vehwarrants`
  ADD PRIMARY KEY (`warrantId`);

--
-- A tábla indexei `mdc_warrants`
--
ALTER TABLE `mdc_warrants`
  ADD PRIMARY KEY (`warrantId`);

--
-- A tábla indexei `paintshopperms`
--
ALTER TABLE `paintshopperms`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `paintshops`
--
ALTER TABLE `paintshops`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `peds`
--
ALTER TABLE `peds`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `phoneads`
--
ALTER TABLE `phoneads`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `player_stat`
--
ALTER TABLE `player_stat`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `premium`
--
ALTER TABLE `premium`
  ADD PRIMARY KEY (`codeId`);

--
-- A tábla indexei `safes`
--
ALTER TABLE `safes`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `serverdatas`
--
ALTER TABLE `serverdatas`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`dbID`);

--
-- A tábla indexei `trashes`
--
ALTER TABLE `trashes`
  ADD PRIMARY KEY (`databaseId`);

--
-- A tábla indexei `undoneprocesses_connect`
--
ALTER TABLE `undoneprocesses_connect`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `undoneprocesses_discord`
--
ALTER TABLE `undoneprocesses_discord`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `undoneprocesses_main`
--
ALTER TABLE `undoneprocesses_main`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`dbID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `accounts`
--
ALTER TABLE `accounts`
  MODIFY `accountId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT a táblához `animals`
--
ALTER TABLE `animals`
  MODIFY `animalId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `armors`
--
ALTER TABLE `armors`
  MODIFY `armorId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT a táblához `characters`
--
ALTER TABLE `characters`
  MODIFY `characterId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT a táblához `companies`
--
ALTER TABLE `companies`
  MODIFY `companyId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `coupons`
--
ALTER TABLE `coupons`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT a táblához `discordcodes`
--
ALTER TABLE `discordcodes`
  MODIFY `dbId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT a táblához `farms`
--
ALTER TABLE `farms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `garages`
--
ALTER TABLE `garages`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `groupmembers`
--
ALTER TABLE `groupmembers`
  MODIFY `dbId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT a táblához `groups`
--
ALTER TABLE `groups`
  MODIFY `dbId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT a táblához `interiors`
--
ALTER TABLE `interiors`
  MODIFY `interiorId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT a táblához `invoices`
--
ALTER TABLE `invoices`
  MODIFY `dbId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `items`
--
ALTER TABLE `items`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1972;

--
-- AUTO_INCREMENT a táblához `licenses`
--
ALTER TABLE `licenses`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT a táblához `lifts`
--
ALTER TABLE `lifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `mdc_records`
--
ALTER TABLE `mdc_records`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `mdc_vehwarrants`
--
ALTER TABLE `mdc_vehwarrants`
  MODIFY `warrantId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `mdc_warrants`
--
ALTER TABLE `mdc_warrants`
  MODIFY `warrantId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `paintshopperms`
--
ALTER TABLE `paintshopperms`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `paintshops`
--
ALTER TABLE `paintshops`
  MODIFY `dbID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT a táblához `peds`
--
ALTER TABLE `peds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `phoneads`
--
ALTER TABLE `phoneads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT a táblához `player_stat`
--
ALTER TABLE `player_stat`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7349;

--
-- AUTO_INCREMENT a táblához `premium`
--
ALTER TABLE `premium`
  MODIFY `codeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `safes`
--
ALTER TABLE `safes`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT a táblához `serverdatas`
--
ALTER TABLE `serverdatas`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `tickets`
--
ALTER TABLE `tickets`
  MODIFY `dbID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `trashes`
--
ALTER TABLE `trashes`
  MODIFY `databaseId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT a táblához `undoneprocesses_connect`
--
ALTER TABLE `undoneprocesses_connect`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `undoneprocesses_discord`
--
ALTER TABLE `undoneprocesses_discord`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `undoneprocesses_main`
--
ALTER TABLE `undoneprocesses_main`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `dbID` int(22) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
