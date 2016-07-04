-- MySQL dump 10.13  Distrib 5.5.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: nsr
-- ------------------------------------------------------
-- Server version	5.5.49-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `nsr`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `nsr` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `nsr`;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `family` varchar(50) DEFAULT NULL,
  `genus` varchar(50) DEFAULT NULL,
  `species` varchar(150) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `county_parish` varchar(50) DEFAULT NULL,
  `native_status_country` varchar(25) DEFAULT NULL,
  `native_status_state_province` varchar(25) DEFAULT NULL,
  `native_status_county_parish` varchar(25) DEFAULT NULL,
  `native_status` varchar(25) DEFAULT NULL,
  `native_status_reason` varchar(250) DEFAULT NULL,
  `native_status_sources` varchar(250) DEFAULT NULL,
  `isIntroduced` int(1) DEFAULT NULL,
  `isCultivatedNSR` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `family` (`family`),
  KEY `genus` (`genus`),
  KEY `species` (`species`),
  KEY `country` (`country`),
  KEY `state_province` (`state_province`),
  KEY `county_parish` (`county_parish`)
) ENGINE=InnoDB AUTO_INCREMENT=6661002 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cclist`
--

DROP TABLE IF EXISTS `cclist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cclist` (
  `country` varchar(50) NOT NULL,
  `state_province` varchar(100) DEFAULT NULL,
  `county_parish` varchar(100) DEFAULT NULL,
  KEY `country` (`country`),
  KEY `state_province` (`state_province`),
  KEY `county_parish` (`county_parish`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countryName`
--

DROP TABLE IF EXISTS `countryName`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countryName` (
  `countryNameID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `countryName` varchar(100) DEFAULT NULL,
  `countryID` int(11) unsigned NOT NULL,
  `isoCode` varchar(2) DEFAULT NULL,
  `countryCode3Char` varchar(3) DEFAULT NULL,
  `countryNameStd` varchar(100) DEFAULT NULL,
  `isNewWorld` int(1) DEFAULT '0',
  PRIMARY KEY (`countryNameID`),
  KEY `countryName` (`countryName`),
  KEY `countryID` (`countryID`),
  KEY `isoCode` (`isoCode`),
  KEY `countryCode3Char` (`countryCode3Char`),
  KEY `countryNameStd` (`countryNameStd`),
  KEY `isNewWorld` (`isNewWorld`)
) ENGINE=InnoDB AUTO_INCREMENT=801 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cultspp`
--

DROP TABLE IF EXISTS `cultspp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cultspp` (
  `cultspp_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` int(11) unsigned NOT NULL,
  `taxon_rank` varchar(25) NOT NULL,
  `taxon` varchar(150) NOT NULL,
  PRIMARY KEY (`cultspp_id`),
  KEY `taxon_rank` (`taxon_rank`),
  KEY `taxon` (`taxon`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cultspp_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `source` (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=493 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `distribution`
--

DROP TABLE IF EXISTS `distribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribution` (
  `distribution_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` int(11) unsigned NOT NULL,
  `taxon_rank` varchar(25) NOT NULL,
  `taxon` varchar(150) NOT NULL,
  `country` varchar(50) NOT NULL,
  `state_province` varchar(100) DEFAULT NULL,
  `county_parish` varchar(100) DEFAULT NULL,
  `native_status` varchar(25) DEFAULT NULL,
  `cult_status` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`distribution_id`),
  KEY `source_id` (`source_id`),
  KEY `taxon_rank` (`taxon_rank`),
  KEY `taxon` (`taxon`),
  KEY `country` (`country`),
  KEY `state_province` (`state_province`),
  KEY `county_parish` (`county_parish`),
  KEY `native_status` (`native_status`),
  KEY `cult_status` (`cult_status`),
  CONSTRAINT `distribution_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `source` (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1031665 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `observation`
--

DROP TABLE IF EXISTS `observation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `family` varchar(50) DEFAULT NULL,
  `genus` varchar(50) DEFAULT NULL,
  `species` varchar(150) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `county_parish` varchar(50) DEFAULT NULL,
  `native_status_country` varchar(25) DEFAULT NULL,
  `native_status_state_province` varchar(25) DEFAULT NULL,
  `native_status_county_parish` varchar(25) DEFAULT NULL,
  `native_status` varchar(25) DEFAULT NULL,
  `native_status_reason` varchar(250) DEFAULT NULL,
  `native_status_sources` varchar(250) DEFAULT NULL,
  `isIntroduced` int(1) DEFAULT NULL,
  `isCultivatedNSR` int(1) unsigned DEFAULT '0',
  `is_in_cache` int(11) unsigned DEFAULT '0',
  `user_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `family` (`family`),
  KEY `genus` (`genus`),
  KEY `species` (`species`),
  KEY `country` (`country`),
  KEY `state_province` (`state_province`),
  KEY `county_parish` (`county_parish`),
  KEY `is_in_cache` (`is_in_cache`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `observation_raw`
--

DROP TABLE IF EXISTS `observation_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observation_raw` (
  `family` varchar(50) DEFAULT NULL,
  `genus` varchar(50) DEFAULT NULL,
  `species` varchar(150) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `county_parish` varchar(50) DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `source`
--

DROP TABLE IF EXISTS `source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `source` (
  `source_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `source_name` varchar(50) NOT NULL,
  `source_name_full` varchar(250) NOT NULL,
  `source_url` varchar(500) DEFAULT NULL,
  `source_contact_name` varchar(50) DEFAULT NULL,
  `source_contact_email` varchar(250) DEFAULT NULL,
  `is_comprehensive` int(1) DEFAULT NULL,
  `regional_scope` varchar(50) DEFAULT 'country',
  `taxonomic_scope` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`source_id`),
  KEY `source_name` (`source_name`),
  KEY `is_comprehensive` (`is_comprehensive`),
  KEY `regional_scope` (`regional_scope`),
  KEY `taxonomic_scope` (`taxonomic_scope`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-11 10:56:26
