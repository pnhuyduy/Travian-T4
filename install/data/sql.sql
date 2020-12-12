-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 21, 2011 at 02:49 AM
-- Server version: 5.5.8
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- --------------------------------------------------------


--
-- Table structure for table `cchat`
--

CREATE TABLE IF NOT EXISTS `cchat` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `uid` smallint(5) unsigned NOT NULL,
  `To` smallint(5) unsigned NOT NULL,
  `alliance` tinyint(3) unsigned NOT NULL,
  `msg` text NOT NULL,
  `viewed` tinyint(4) NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `cchat`
--

-- --------------------------------------------------------
--
-- Table structure for table `%PREFIX%a2b`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%a2b` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ckey` char(12) NOT NULL,
  `time_check` int(10) unsigned NOT NULL DEFAULT '0',
  `to_vid` int(10) unsigned NOT NULL,
  `u1` int(10) unsigned NOT NULL,
  `u2` int(10) unsigned NOT NULL,
  `u3` int(10) unsigned NOT NULL,
  `u4` int(10) unsigned NOT NULL,
  `u5` int(10) unsigned NOT NULL,
  `u6` int(10) unsigned NOT NULL,
  `u7` int(10) unsigned NOT NULL,
  `u8` int(10) unsigned NOT NULL,
  `u9` int(10) unsigned NOT NULL,
  `u10` int(10) unsigned NOT NULL,
  `u11` int(10) unsigned NOT NULL,
  `type` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ckey` (`ckey`),
  KEY `time_check` (`time_check`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%a2b`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%links`
--

CREATE TABLE `%PREFIX%links` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` SMALLINT UNSIGNED NOT NULL ,
  `name` CHAR(50) NOT NULL ,
  `url` CHAR(150) NOT NULL ,
  `pos` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- Dumping data for table `%PREFIX%links`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%abdata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%abdata` (
  `vref` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `a1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `a2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `a3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `a4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `a5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `a6` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `a7` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `a8` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `a9` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `a10` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b6` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b7` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b8` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b9` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b10` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%abdata`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%activate`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%activate` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` char(45) NOT NULL,
  `password` char(45) NOT NULL,
  `email` text NOT NULL,
  `tribe` tinyint unsigned NOT NULL,
  `access` tinyint unsigned NOT NULL DEFAULT '1',
  `act` char(45) NOT NULL,
  `timestamp` int unsigned NOT NULL DEFAULT '0',
  `location` text NOT NULL,
  `act2` char(10) NOT NULL,
  `ancestor` char(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- Dumping data for table `%PREFIX%activate`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%active`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%active` (
  `username` CHAR(45) NOT NULL,
  `timestamp` int unsigned NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `%PREFIX%active`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%farmlist`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%farmlist` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `wref` SMALLINT unsigned NOT NULL,
  `owner` SMALLINT unsigned NOT NULL,
  `name` CHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- Dumping data for table `%prefix%farmlist`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%route`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%route` (
  `id` SMALLint unsigned NOT NULL AUTO_INCREMENT,
  `uid` SMALLint unsigned NOT NULL,
  `wid` SMALLint unsigned NOT NULL,
  `from` SMALLint unsigned NOT NULL,
  `wood` int unsigned NOT NULL,
  `clay` int unsigned NOT NULL,
  `iron` int unsigned NOT NULL,
  `crop` int unsigned NOT NULL,
  `start` tinyint unsigned NOT NULL,
  `deliveries` tinyint unsigned NOT NULL,
  `merchant` mediumint unsigned NOT NULL,
  `timestamp` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `wid` (`wid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%refrence`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%refrence` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `player_id` SMALLINT NOT NULL,
  `player_name` char(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%refrence`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%raidlist`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%raidlist` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `lid` SMALLINT NOT NULL,
  `towref` SMALLINT unsigned NOT NULL,
  `x` SMALLint NOT NULL,
  `y` SMALLint NOT NULL,
  `distance` char(5) NOT NULL DEFAULT '0',
  `t1` int unsigned NOT NULL,
  `t2` int unsigned NOT NULL,
  `t3` int unsigned NOT NULL,
  `t4` int unsigned NOT NULL,
  `t5` int unsigned NOT NULL,
  `t6` int unsigned NOT NULL,
  `t7` int unsigned NOT NULL,
  `t8` int unsigned NOT NULL,
  `t9` int unsigned NOT NULL,
  `t10` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lid` (`lid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%raidlist`
--


-- --------------------------------------------------------


--
-- Table structure for table `%PREFIX%allimedal`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%allimedal` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `allyid` SMALLINT NOT NULL,
  `categorie` SMALLINT NOT NULL,
  `plaats` SMALLINT NOT NULL,
  `week` SMALLINT NOT NULL,
  `points` bigint NOT NULL,
  `img` char(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------


--
-- Table structure for table `%PREFIX%artefacts`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%artefacts` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `vref` SMALLINT unsigned NOT NULL,
  `owner` SMALLINT unsigned NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `size` tinyint unsigned NOT NULL,
  `conquered` int unsigned NOT NULL,
  `lastupdate` int unsigned NOT NULL,
  `status` tinyint unsigned NOT NULL,
  `name` char(30) NOT NULL,
  `desc` char(20) NOT NULL,
  `effecttype` int NOT NULL,
  `effect` double NOT NULL,
  `aoe` int NOT NULL,
  `img` char(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Table structure for table `%PREFIX%artefacts`
--
-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%alidata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%alidata` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(25) NOT NULL,
  `tag` char(10) NOT NULL,
  `leader` smallint(5) unsigned NOT NULL,
  `coor` int(10) unsigned NOT NULL,
  `advisor` int(10) unsigned NOT NULL,
  `recruiter` int(10) unsigned NOT NULL,
  `notice` char(255) NOT NULL,
  `desc` char(255) NOT NULL,
  `max` tinyint(3) unsigned NOT NULL,
  `ap` bigint(20) unsigned NOT NULL DEFAULT '0',
  `dp` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Rc` bigint(20) NOT NULL DEFAULT '0',
  `RR` bigint(20) NOT NULL DEFAULT '0',
  `Aap` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Adp` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clp` bigint(20) NOT NULL DEFAULT '0',
  `oldrank` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `tag` (`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%alidata`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%ali_invite`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%ali_invite` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `uid` SMALLINT unsigned NOT NULL,
  `alliance` SMALLINT unsigned NOT NULL,
  `sender` SMALLINT NOT NULL,
  `timestamp` int NOT NULL,
  `accept` TINYINT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%ali_invite`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%ali_log`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%ali_log` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `aid` SMALLINT NOT NULL,
  `comment` char(200) NOT NULL,
  `date` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%ali_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%ali_permission`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%ali_permission` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `uid` smallint(5) unsigned NOT NULL,
  `alliance` smallint(5) unsigned NOT NULL,
  `rank` char(20) NOT NULL,
  `opt1` int(10) unsigned NOT NULL DEFAULT '0',
  `opt2` int(10) unsigned NOT NULL DEFAULT '0',
  `opt3` int(10) unsigned NOT NULL DEFAULT '0',
  `opt4` int(10) unsigned NOT NULL DEFAULT '0',
  `opt5` int(10) unsigned NOT NULL DEFAULT '0',
  `opt6` int(10) unsigned NOT NULL DEFAULT '0',
  `opt7` int(10) unsigned NOT NULL DEFAULT '0',
  `opt8` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `alliance` (`alliance`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%ali_permission`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%attacks`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%attacks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `vref` SMALLINT unsigned NOT NULL,
  `t1` int unsigned NOT NULL,
  `t2` int unsigned NOT NULL,
  `t3` int unsigned NOT NULL,
  `t4` int unsigned NOT NULL,
  `t5` int unsigned NOT NULL,
  `t6` int unsigned NOT NULL,
  `t7` int unsigned NOT NULL,
  `t8` int unsigned NOT NULL,
  `t9` int unsigned NOT NULL,
  `t10` int unsigned NOT NULL,
  `t11` int unsigned NOT NULL,
  `attack_type` tinyint NOT NULL,
  `ctar1` TINYINT unsigned NOT NULL, 
  `ctar2` TINYINT unsigned NOT NULL,
  `spy` TINYINT unsigned NOT NULL, 
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%attacks`
--

-- --------------------------------------------------------

--
-- Table structure for table `%prefix%auction`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%auction` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` smallint(5) unsigned NOT NULL,
  `owner` smallint(5) unsigned NOT NULL,
  `btype` tinyint(3) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `num` smallint(5) unsigned NOT NULL,
  `uid` smallint(5) unsigned NOT NULL,
  `bids` tinyint(4) NOT NULL,
  `silver` smallint(6) NOT NULL,
  `maxsilver` smallint(6) NOT NULL,
  `time` int(10) unsigned NOT NULL,
  `finish` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `finish` (`finish`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- Dumping data for table `%prefix%auction`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%autoauction`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%autoauction` (
  `id` tinyint NOT NULL,
  `number` tinyint NOT NULL,
  `time` int NOT NULL,
  `lasttime` int NOT NULL,
  `active` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `%PREFIX%autoauction`
--

INSERT INTO `%PREFIX%autoauction` (`id`, `number`, `time`, `lasttime`, `active`) VALUES
(1, 0, 0, 0, 0),
(2, 0, 0, 0, 0),
(3, 0, 0, 0, 0),
(4, 0, 0, 0, 0),
(5, 0, 0, 0, 0),
(6, 0, 0, 0, 0),
(7, 100, 1, 0, 1),
(8, 127, 1, 0, 1),
(9, 100, 1, 0, 1),
(10, 0, 0, 0, 0),
(11, 90, 1, 0, 1),
(12, 0, 0, 0, 0),
(13, 0, 0, 0, 0),
(14, 0, 0, 0, 0),
(15, 0, 0, 0, 0);


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%bdata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%bdata` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `wid` smallint(5) unsigned NOT NULL,
  `field` tinyint(3) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `loopcon` tinyint(3) unsigned NOT NULL,
  `timestamp` int(10) unsigned NOT NULL,
  `master` tinyint(3) unsigned NOT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wid` (`wid`),
  KEY `field` (`field`),
  KEY `master` (`master`),
  KEY `timestamp` (`timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%bdata`
--

-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%chat`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%chat` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `name` char(30) NOT NULL,
  `alli` char(30) NOT NULL,
  `date` char(30) NOT NULL,
  `msg` char(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%chat`
--

-- --------------------------------------------------------

--
-- Table structure for table `%prefix%deleting`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%deleting` (
  `uid` SMALLINT unsigned NOT NULL,
  `timestamp` int unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `%prefix%deleting`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%demolition`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%demolition` (
  `vref` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `buildnumber` SMALLINT unsigned NOT NULL DEFAULT '0',
  `lvl` tinyint unsigned NOT NULL DEFAULT '0',
  `timetofinish` int NOT NULL,
  PRIMARY KEY (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%demolition`
--

-- --------------------------------------------------------

--
-- Table structure for table `%prefix%diplomacy`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%diplomacy` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `alli1` SMALLINT unsigned NOT NULL,
  `alli2` SMALLINT unsigned NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `accepted` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
--
-- Dumping data for table `%prefix%diplomacy`
--


-- --------------------------------------------------------


--
-- Table structure for table `%prefix%adventure`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%adventure` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `wref` smallint(6) NOT NULL,
  `uid` smallint(5) unsigned NOT NULL,
  `dif` tinyint(4) NOT NULL,
  `time` int(10) unsigned NOT NULL,
  `end` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wref` (`wref`),
  KEY `uid` (`uid`),
  KEY `end` (`end`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
--
-- Dumping data for table `%prefix%adventure`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%enforcement`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%enforcement` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `hero` tinyint unsigned NOT NULL DEFAULT '0',
  `u1` int unsigned NOT NULL DEFAULT '0',
  `u2` int unsigned NOT NULL DEFAULT '0',
  `u3` int unsigned NOT NULL DEFAULT '0',
  `u4` int unsigned NOT NULL DEFAULT '0',
  `u5` int unsigned NOT NULL DEFAULT '0',
  `u6` int unsigned NOT NULL DEFAULT '0',
  `u7` int unsigned NOT NULL DEFAULT '0',
  `u8` int unsigned NOT NULL DEFAULT '0',
  `u9` int unsigned NOT NULL DEFAULT '0',
  `u10` int unsigned NOT NULL DEFAULT '0',
  `u11` int unsigned NOT NULL DEFAULT '0',
  `u12` int unsigned NOT NULL DEFAULT '0',
  `u13` int unsigned NOT NULL DEFAULT '0',
  `u14` int unsigned NOT NULL DEFAULT '0',
  `u15` int unsigned NOT NULL DEFAULT '0',
  `u16` int unsigned NOT NULL DEFAULT '0',
  `u17` int unsigned NOT NULL DEFAULT '0',
  `u18` int unsigned NOT NULL DEFAULT '0',
  `u19` int unsigned NOT NULL DEFAULT '0',
  `u20` int unsigned NOT NULL DEFAULT '0',
  `u21` int unsigned NOT NULL DEFAULT '0',
  `u22` int unsigned NOT NULL DEFAULT '0',
  `u23` int unsigned NOT NULL DEFAULT '0',
  `u24` int unsigned NOT NULL DEFAULT '0',
  `u25` int unsigned NOT NULL DEFAULT '0',
  `u26` int unsigned NOT NULL DEFAULT '0',
  `u27` int unsigned NOT NULL DEFAULT '0',
  `u28` int unsigned NOT NULL DEFAULT '0',
  `u29` int unsigned NOT NULL DEFAULT '0',
  `u30` int unsigned NOT NULL DEFAULT '0',
  `u31` int unsigned NOT NULL DEFAULT '0',
  `u32` int unsigned NOT NULL DEFAULT '0',
  `u33` int unsigned NOT NULL DEFAULT '0',
  `u34` int unsigned NOT NULL DEFAULT '0',
  `u35` int unsigned NOT NULL DEFAULT '0',
  `u36` int unsigned NOT NULL DEFAULT '0',
  `u37` int unsigned NOT NULL DEFAULT '0',
  `u38` int unsigned NOT NULL DEFAULT '0',
  `u39` int unsigned NOT NULL DEFAULT '0',
  `u40` int unsigned NOT NULL DEFAULT '0',
  `u41` int unsigned NOT NULL DEFAULT '0',
  `u42` int unsigned NOT NULL DEFAULT '0',
  `u43` int unsigned NOT NULL DEFAULT '0',
  `u44` int unsigned NOT NULL DEFAULT '0',
  `u45` int unsigned NOT NULL DEFAULT '0',
  `u46` int unsigned NOT NULL DEFAULT '0',
  `u47` int unsigned NOT NULL DEFAULT '0',
  `u48` int unsigned NOT NULL DEFAULT '0',
  `u49` int unsigned NOT NULL DEFAULT '0',
  `u50` int unsigned NOT NULL DEFAULT '0',
  `from` SMALLINT unsigned NOT NULL DEFAULT '0',
  `vref` SMALLINT unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `from` (`from`),
  KEY `vref` (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%enforcement`
--

-- --------------------------------------------------------

--
-- Table structure for table `%prefix%trapped`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%trapped` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `hero` tinyint unsigned NOT NULL DEFAULT '0',
  `u1` int unsigned NOT NULL DEFAULT '0',
  `u2` int unsigned NOT NULL DEFAULT '0',
  `u3` int unsigned NOT NULL DEFAULT '0',
  `u4` int unsigned NOT NULL DEFAULT '0',
  `u5` int unsigned NOT NULL DEFAULT '0',
  `u6` int unsigned NOT NULL DEFAULT '0',
  `u7` int unsigned NOT NULL DEFAULT '0',
  `u8` int unsigned NOT NULL DEFAULT '0',
  `u9` int unsigned NOT NULL DEFAULT '0',
  `u10` int unsigned NOT NULL DEFAULT '0',
  `u11` int unsigned NOT NULL DEFAULT '0',
  `u12` int unsigned NOT NULL DEFAULT '0',
  `u13` int unsigned NOT NULL DEFAULT '0',
  `u14` int unsigned NOT NULL DEFAULT '0',
  `u15` int unsigned NOT NULL DEFAULT '0',
  `u16` int unsigned NOT NULL DEFAULT '0',
  `u17` int unsigned NOT NULL DEFAULT '0',
  `u18` int unsigned NOT NULL DEFAULT '0',
  `u19` int unsigned NOT NULL DEFAULT '0',
  `u20` int unsigned NOT NULL DEFAULT '0',
  `u21` int unsigned NOT NULL DEFAULT '0',
  `u22` int unsigned NOT NULL DEFAULT '0',
  `u23` int unsigned NOT NULL DEFAULT '0',
  `u24` int unsigned NOT NULL DEFAULT '0',
  `u25` int unsigned NOT NULL DEFAULT '0',
  `u26` int unsigned NOT NULL DEFAULT '0',
  `u27` int unsigned NOT NULL DEFAULT '0',
  `u28` int unsigned NOT NULL DEFAULT '0',
  `u29` int unsigned NOT NULL DEFAULT '0',
  `u30` int unsigned NOT NULL DEFAULT '0',
  `u31` int unsigned NOT NULL DEFAULT '0',
  `u32` int unsigned NOT NULL DEFAULT '0',
  `u33` int unsigned NOT NULL DEFAULT '0',
  `u34` int unsigned NOT NULL DEFAULT '0',
  `u35` int unsigned NOT NULL DEFAULT '0',
  `u36` int unsigned NOT NULL DEFAULT '0',
  `u37` int unsigned NOT NULL DEFAULT '0',
  `u38` int unsigned NOT NULL DEFAULT '0',
  `u39` int unsigned NOT NULL DEFAULT '0',
  `u40` int unsigned NOT NULL DEFAULT '0',
  `u41` int unsigned NOT NULL DEFAULT '0',
  `u42` int unsigned NOT NULL DEFAULT '0',
  `u43` int unsigned NOT NULL DEFAULT '0',
  `u44` int unsigned NOT NULL DEFAULT '0',
  `u45` int unsigned NOT NULL DEFAULT '0',
  `u46` int unsigned NOT NULL DEFAULT '0',
  `u47` int unsigned NOT NULL DEFAULT '0',
  `u48` int unsigned NOT NULL DEFAULT '0',
  `u49` int unsigned NOT NULL DEFAULT '0',
  `u50` int unsigned NOT NULL DEFAULT '0',
  `from` SMALLINT unsigned NOT NULL DEFAULT '0',
  `vref` SMALLINT unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `from` (`from`),
  KEY `vref` (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%trapped`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%fdata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%fdata` (
  `vref` SMALLINT unsigned NOT NULL,
  `f1` tinyint unsigned NOT NULL DEFAULT '0',
  `f1t` tinyint unsigned NOT NULL DEFAULT '0',
  `f2` tinyint unsigned NOT NULL DEFAULT '0',
  `f2t` tinyint unsigned NOT NULL DEFAULT '0',
  `f3` tinyint unsigned NOT NULL DEFAULT '0',
  `f3t` tinyint unsigned NOT NULL DEFAULT '0',
  `f4` tinyint unsigned NOT NULL DEFAULT '0',
  `f4t` tinyint unsigned NOT NULL DEFAULT '0',
  `f5` tinyint unsigned NOT NULL DEFAULT '0',
  `f5t` tinyint unsigned NOT NULL DEFAULT '0',
  `f6` tinyint unsigned NOT NULL DEFAULT '0',
  `f6t` tinyint unsigned NOT NULL DEFAULT '0',
  `f7` tinyint unsigned NOT NULL DEFAULT '0',
  `f7t` tinyint unsigned NOT NULL DEFAULT '0',
  `f8` tinyint unsigned NOT NULL DEFAULT '0',
  `f8t` tinyint unsigned NOT NULL DEFAULT '0',
  `f9` tinyint unsigned NOT NULL DEFAULT '0',
  `f9t` tinyint unsigned NOT NULL DEFAULT '0',
  `f10` tinyint unsigned NOT NULL DEFAULT '0',
  `f10t` tinyint unsigned NOT NULL DEFAULT '0',
  `f11` tinyint unsigned NOT NULL DEFAULT '0',
  `f11t` tinyint unsigned NOT NULL DEFAULT '0',
  `f12` tinyint unsigned NOT NULL DEFAULT '0',
  `f12t` tinyint unsigned NOT NULL DEFAULT '0',
  `f13` tinyint unsigned NOT NULL DEFAULT '0',
  `f13t` tinyint unsigned NOT NULL DEFAULT '0',
  `f14` tinyint unsigned NOT NULL DEFAULT '0',
  `f14t` tinyint unsigned NOT NULL DEFAULT '0',
  `f15` tinyint unsigned NOT NULL DEFAULT '0',
  `f15t` tinyint unsigned NOT NULL DEFAULT '0',
  `f16` tinyint unsigned NOT NULL DEFAULT '0',
  `f16t` tinyint unsigned NOT NULL DEFAULT '0',
  `f17` tinyint unsigned NOT NULL DEFAULT '0',
  `f17t` tinyint unsigned NOT NULL DEFAULT '0',
  `f18` tinyint unsigned NOT NULL DEFAULT '0',
  `f18t` tinyint unsigned NOT NULL DEFAULT '0',
  `f19` tinyint unsigned NOT NULL DEFAULT '0',
  `f19t` tinyint unsigned NOT NULL DEFAULT '0',
  `f20` tinyint unsigned NOT NULL DEFAULT '0',
  `f20t` tinyint unsigned NOT NULL DEFAULT '0',
  `f21` tinyint unsigned NOT NULL DEFAULT '0',
  `f21t` tinyint unsigned NOT NULL DEFAULT '0',
  `f22` tinyint unsigned NOT NULL DEFAULT '0',
  `f22t` tinyint unsigned NOT NULL DEFAULT '0',
  `f23` tinyint unsigned NOT NULL DEFAULT '0',
  `f23t` tinyint unsigned NOT NULL DEFAULT '0',
  `f24` tinyint unsigned NOT NULL DEFAULT '0',
  `f24t` tinyint unsigned NOT NULL DEFAULT '0',
  `f25` tinyint unsigned NOT NULL DEFAULT '0',
  `f25t` tinyint unsigned NOT NULL DEFAULT '0',
  `f26` tinyint unsigned NOT NULL DEFAULT '0',
  `f26t` tinyint unsigned NOT NULL DEFAULT '0',
  `f27` tinyint unsigned NOT NULL DEFAULT '0',
  `f27t` tinyint unsigned NOT NULL DEFAULT '0',
  `f28` tinyint unsigned NOT NULL DEFAULT '0',
  `f28t` tinyint unsigned NOT NULL DEFAULT '0',
  `f29` tinyint unsigned NOT NULL DEFAULT '0',
  `f29t` tinyint unsigned NOT NULL DEFAULT '0',
  `f30` tinyint unsigned NOT NULL DEFAULT '0',
  `f30t` tinyint unsigned NOT NULL DEFAULT '0',
  `f31` tinyint unsigned NOT NULL DEFAULT '0',
  `f31t` tinyint unsigned NOT NULL DEFAULT '0',
  `f32` tinyint unsigned NOT NULL DEFAULT '0',
  `f32t` tinyint unsigned NOT NULL DEFAULT '0',
  `f33` tinyint unsigned NOT NULL DEFAULT '0',
  `f33t` tinyint unsigned NOT NULL DEFAULT '0',
  `f34` tinyint unsigned NOT NULL DEFAULT '0',
  `f34t` tinyint unsigned NOT NULL DEFAULT '0',
  `f35` tinyint unsigned NOT NULL DEFAULT '0',
  `f35t` tinyint unsigned NOT NULL DEFAULT '0',
  `f36` tinyint unsigned NOT NULL DEFAULT '0',
  `f36t` tinyint unsigned NOT NULL DEFAULT '0',
  `f37` tinyint unsigned NOT NULL DEFAULT '0',
  `f37t` tinyint unsigned NOT NULL DEFAULT '0',
  `f38` tinyint unsigned NOT NULL DEFAULT '0',
  `f38t` tinyint unsigned NOT NULL DEFAULT '0',
  `f39` tinyint unsigned NOT NULL DEFAULT '0',
  `f39t` tinyint unsigned NOT NULL DEFAULT '0',
  `f40` tinyint unsigned NOT NULL DEFAULT '0',
  `f40t` tinyint unsigned NOT NULL DEFAULT '0',
  `f99` tinyint unsigned NOT NULL DEFAULT '0',
  `f99t` tinyint unsigned NOT NULL DEFAULT '0',
  `wwname` char(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`vref`),
  KEY `vref` (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `%prefix%fdata`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%forum_cat`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%forum_cat` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `owner` SMALLINT NOT NULL,
  `alliance` SMALLINT NOT NULL,
  `forum_name` char(20) NOT NULL,
  `forum_des` char(45) NOT NULL,
  `forum_area` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%forum_cat`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%forum_edit`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%forum_edit` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `alliance` SMALLINT NOT NULL,
  `result` char(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%forum_edit`
--

-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%forum_poll`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%forum_poll` (
  `id` int(11) NOT NULL,
  `name` char(255) NOT NULL,
  `p1` MEDIUMINT NOT NULL,
  `p2` MEDIUMINT NOT NULL,
  `p3` MEDIUMINT NOT NULL,
  `p4` MEDIUMINT NOT NULL,
  `p1_name` char(255) NOT NULL,
  `p2_name` char(255) NOT NULL,
  `p3_name` char(255) NOT NULL,
  `p4_name` char(255) NOT NULL,
  `voters` varchar(400) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `%PREFIX%forum_poll`
--

-- --------------------------------------------------------

--
-- Table structure for table `%prefix%forum_post`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%forum_post` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `post` longtext NOT NULL,
  `topic` char(50) NOT NULL,
  `owner` SMALLINT NOT NULL,
  `date` int NOT NULL,
  `alliance0` int(11) unsigned NOT NULL,
  `player0` int(11) unsigned NOT NULL,
  `coor0` int(11) unsigned NOT NULL,
  `report0` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%forum_post`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%forum_topic`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%forum_topic` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `title` char(50) NOT NULL,
  `post` longtext NOT NULL,
  `date` int NOT NULL,
  `post_date` int NOT NULL,
  `cat` SMALLINT NOT NULL,
  `owner` SMALLINT NOT NULL,
  `alliance` SMALLINT NOT NULL,
  `ends` char(20) NOT NULL,
  `close` char(20) NOT NULL,
  `stick` char(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%forum_topic`
--

-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%fpost_rules`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%fpost_rules` (
  `id` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `players_id` int(11) COLLATE utf8_persian_ci NOT NULL,
  `players_name` char(45) COLLATE utf8_persian_ci NOT NULL,
  `ally_id` int(11) COLLATE utf8_persian_ci NOT NULL,
  `ally_tag` char(45) COLLATE utf8_persian_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=FIXED;

--
-- Dumping data for table `%PREFIX%fpost_rules`
--

-- --------------------------------------------------------

--
-- Table structure for table `%prefix%gold_fin_log`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%gold_fin_log` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `wid` SMALLINT unsigned NOT NULL,
  `log` char(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%gold_fin_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%hero`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%hero` (
  `heroid` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `uid` SMALLINT unsigned NOT NULL,
  `wref` SMALLINT unsigned NOT NULL,
  `level` tinyint unsigned NOT NULL,
  `adv` SMALLINT unsigned NOT NULL,
  `sucsadv` SMALLINT unsigned NOT NULL,
  `speed` tinyint unsigned NOT NULL,
  `itemspeed` tinyint unsigned NOT NULL,
  `points` SMALLINT unsigned NOT NULL,
  `experience` int NOT NULL,
  `dead` tinyint NOT NULL,
  `health` double(10,7) unsigned NOT NULL DEFAULT '100',
  `power` tinyint unsigned NOT NULL,
  `fsperpoint` tinyint unsigned NOT NULL,
  `itemfs` SMALLINT unsigned NOT NULL,
  `offBonus` tinyint unsigned NOT NULL,
  `defBonus` tinyint unsigned NOT NULL,
  `product` tinyint unsigned NOT NULL,
  `r0` tinyint unsigned NOT NULL,
  `r1` tinyint unsigned NOT NULL,
  `r2` tinyint unsigned NOT NULL,
  `r3` tinyint unsigned NOT NULL,
  `r4` tinyint unsigned NOT NULL,
  `rc` tinyint unsigned NOT NULL,
  `autoregen` tinyint NOT NULL,
  `itemautoregen` tinyint NOT NULL,
  `extraexpgain` tinyint NOT NULL,
  `itemextraexpgain` tinyint NOT NULL,
  `cpproduction` tinyint NOT NULL,
  `itemcpproduction` tinyint NOT NULL,
  `infantrytrain` tinyint NOT NULL,
  `iteminfantrytrain` tinyint NOT NULL,
  `cavalrytrain` tinyint NOT NULL,
  `itemcavalrytrain` tinyint NOT NULL,
  `rob` tinyint NOT NULL,
  `itemrob` tinyint NOT NULL,
  `extraresist` tinyint NOT NULL,
  `itemextraresist` tinyint NOT NULL,
  `vsnatars` tinyint NOT NULL,
  `itemvsnatars` tinyint NOT NULL,
  `accountmspeed` tinyint NOT NULL,
  `itemaccountmspeed` tinyint NOT NULL,
  `allymspeed` tinyint NOT NULL,
  `itemallymspeed` tinyint NOT NULL,
  `longwaymspeed` tinyint NOT NULL,
  `itemlongwaymspeed` tinyint NOT NULL,
  `returnmspeed` tinyint NOT NULL,
  `itemreturnmspeed` tinyint NOT NULL,
  `lastupdate` int unsigned NOT NULL,
  `lastadv` int unsigned NOT NULL DEFAULT '0',
  `hash` char(45) NOT NULL,
  `hide` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`heroid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- Dumping data for table `%PREFIX%hero`
--
-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%heroface`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%heroface` (
  `uid` SMALLINT unsigned NOT NULL,
  `gender` tinyint NOT NULL,
  `beard` tinyint NOT NULL,
  `ear` tinyint NOT NULL,
  `eye` tinyint NOT NULL,
  `eyebrow` tinyint NOT NULL,
  `face` tinyint NOT NULL,
  `hair` tinyint NOT NULL,
  `mouth` tinyint NOT NULL,
  `nose` tinyint NOT NULL,
  `color` tinyint NOT NULL,
  `foot` tinyint unsigned NOT NULL,
  `helmet` SMALLINT unsigned NOT NULL,
  `body` SMALLINT unsigned NOT NULL,
  `shoes` SMALLINT unsigned NOT NULL,
  `horse` SMALLINT unsigned NOT NULL,
  `leftHand` SMALLINT NOT NULL,
  `rightHand` SMALLINT NOT NULL,
  `bag` SMALLINT NOT NULL,
  `num` SMALLINT NOT NULL,
  `hash` char(45) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `%PREFIX%heroface`
--

INSERT INTO `%PREFIX%heroface` (`uid`, `beard`, `ear`, `eye`, `eyebrow`, `face`, `hair`, `mouth`, `nose`, `color`, `foot`, `helmet`, `horse`, `leftHand`, `rightHand`, `bag`, `num`) VALUES
(4, 1, 2, 3, 2, 4, 3, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0),
(1, 1, 2, 3, 2, 4, 3, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0),
(2, 1, 2, 3, 2, 4, 3, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0);


-- --------------------------------------------------------
--
-- Table structure for table `%PREFIX%heroitems`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%heroitems` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `uid` SMALLINT unsigned NOT NULL,
  `btype` tinyint unsigned NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `num` SMALLINT NOT NULL,
  `proc` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `btype` (`btype`),
  KEY `type` (`type`),
  KEY `proc` (`proc`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%heroitems`
--

-- --------------------------------------------------------

--
-- Table structure for table `%prefix%market`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%market` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `vref` SMALLINT unsigned NOT NULL,
  `gtype` tinyint unsigned NOT NULL,
  `gamt` int unsigned NOT NULL,
  `wtype` tinyint unsigned NOT NULL,
  `wamt` int unsigned NOT NULL,
  `accept` tinyint unsigned NOT NULL,
  `maxtime` int unsigned NOT NULL,
  `alliance` int unsigned NOT NULL,
  `merchant` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vref` (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%market`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%mdata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%mdata` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `target` SMALLINT unsigned NOT NULL,
  `owner` SMALLINT unsigned NOT NULL,
  `topic` char(45) COLLATE utf8_persian_ci NOT NULL,
  `message` varchar(1000) COLLATE utf8_persian_ci NOT NULL,
  `viewed` tinyint unsigned NOT NULL,
  `archived` tinyint unsigned NOT NULL,
  `send` tinyint unsigned NOT NULL,
  `time` int unsigned NOT NULL DEFAULT '0',
  `deltarget` tinyint unsigned NOT NULL,
  `delowner` tinyint unsigned NOT NULL,
  `alliance` SMALLINT unsigned NOT NULL,
  `player` SMALLINT unsigned NOT NULL,
  `coor` SMALLINT unsigned NOT NULL,
  `report` SMALLINT unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`time`),
  KEY `target` (`target`),
  KEY `owner` (`owner`),
  KEY `send` (`send`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%mdata`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%medal`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%medal` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `userid` SMALLINT unsigned NOT NULL,
  `categorie` tinyint unsigned NOT NULL,
  `plaats` tinyint unsigned NOT NULL,
  `week` tinyint unsigned NOT NULL,
  `points` bigint NOT NULL,
  `img` char(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%medal`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%movement`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%movement` (
  `moveid` MEDIUMINT unsigned NOT NULL AUTO_INCREMENT,
  `sort_type` tinyint unsigned NOT NULL DEFAULT '0',
  `from` SMALLINT unsigned NOT NULL DEFAULT '0',
  `to` SMALLINT unsigned NOT NULL DEFAULT '0',
  `ref` MEDIUMINT unsigned NOT NULL DEFAULT '0',
  `data` varchar(400) NOT NULL,
  `starttime` int unsigned NOT NULL DEFAULT '0',
  `endtime` int unsigned NOT NULL DEFAULT '0',
  `proc` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`moveid`),
  KEY `proc` (`proc`),
  KEY `endtime` (`endtime`),
  KEY `sort_type` (`sort_type`),
  KEY `from` (`from`),
  KEY `to` (`to`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%movement`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%ndata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%ndata` (
  `id` MEDIUMINT unsigned NOT NULL AUTO_INCREMENT,
  `uid` SMALLINT unsigned NOT NULL,
  `toWref` SMALLINT unsigned NOT NULL,
  `ally` SMALLINT unsigned NOT NULL,
  `topic` varchar(600) NOT NULL,
  `ntype` tinyint unsigned NOT NULL,
  `data` varchar(600) NOT NULL,
  `time` int unsigned NOT NULL,
  `viewed` tinyint unsigned NOT NULL,
  `archive` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`time`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%ndata`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%newproc`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%newproc` (
  `uid` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `npw` char(45) NOT NULL,
  `nemail` char(45) NOT NULL,
  `act` char(10) NOT NULL,
  `time` int unsigned NOT NULL,
  `proc` tinyint unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%newproc`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%odata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%odata` (
  `wref` SMALLINT unsigned NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `conqured` MEDIUMINT unsigned NOT NULL,
  `wood` float(12,2) NOT NULL,
  `iron` float(12,2) NOT NULL,
  `clay` float(12,2) NOT NULL,
  `woodp` float(12,2) NOT NULL,
  `ironp` float(12,2) NOT NULL,
  `clayp` float(12,2) NOT NULL,
  `maxstore` MEDIUMINT unsigned NOT NULL,
  `crop` float(12,2) NOT NULL,
  `cropp` float(12,2) NOT NULL,
  `maxcrop` MEDIUMINT unsigned NOT NULL,
  `lasttrain` int unsigned NOT NULL,
  `lastfarmed` int unsigned NOT NULL,
  `lastupdated` int unsigned NOT NULL,
  `loyalty` tinyint NOT NULL DEFAULT '100',
  `owner` SMALLINT unsigned NOT NULL DEFAULT '2',
  `name` char(45) NOT NULL DEFAULT 'Unoccupied Oasis',
  PRIMARY KEY (`wref`),
  KEY `conqured` (`conqured`),
  KEY `loyalty` (`loyalty`),
  KEY `owner` (`owner`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `%prefix%odata`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%online`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%online` (
  `name` char(45) NOT NULL,
  `time` int NOT NULL,
  `sitter` int unsigned NOT NULL,
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `%prefix%online`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%research`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%research` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `vref` int unsigned NOT NULL,
  `tech` char(3) NOT NULL,
  `timestamp` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vref` (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%research`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%stats`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%stats` (
  `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
  `owner` SMALLINT NOT NULL,
  `troops` int NOT NULL,
  `troops_reinf` int NOT NULL,
  `resources` int NOT NULL,
  `pop` SMALLINT NOT NULL,
  `rank` SMALLINT NOT NULL,
  `time` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index` (`id`,`owner`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `%PREFIX%stats`
--

-- --------------------------------------------------------

--
-- Table structure for table `%prefix%send`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%send` (
  `id` MEDIUMINT unsigned NOT NULL AUTO_INCREMENT,
  `wood` int unsigned NOT NULL,
  `clay` int unsigned NOT NULL,
  `iron` int unsigned NOT NULL,
  `crop` int unsigned NOT NULL,
  `merchant` tinyint unsigned NOT NULL,
  `send` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%send`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%tdata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%tdata` (
  `vref` SMALLINT unsigned NOT NULL,
  `t2` tinyint unsigned NOT NULL DEFAULT '0',
  `t3` tinyint unsigned NOT NULL DEFAULT '0',
  `t4` tinyint unsigned NOT NULL DEFAULT '0',
  `t5` tinyint unsigned NOT NULL DEFAULT '0',
  `t6` tinyint unsigned NOT NULL DEFAULT '0',
  `t7` tinyint unsigned NOT NULL DEFAULT '0',
  `t8` tinyint unsigned NOT NULL DEFAULT '0',
  `t9` tinyint unsigned NOT NULL DEFAULT '0',
  `t12` tinyint unsigned NOT NULL DEFAULT '0',
  `t13` tinyint unsigned NOT NULL DEFAULT '0',
  `t14` tinyint unsigned NOT NULL DEFAULT '0',
  `t15` tinyint unsigned NOT NULL DEFAULT '0',
  `t16` tinyint unsigned NOT NULL DEFAULT '0',
  `t17` tinyint unsigned NOT NULL DEFAULT '0',
  `t18` tinyint unsigned NOT NULL DEFAULT '0',
  `t19` tinyint unsigned NOT NULL DEFAULT '0',
  `t22` tinyint unsigned NOT NULL DEFAULT '0',
  `t23` tinyint unsigned NOT NULL DEFAULT '0',
  `t24` tinyint unsigned NOT NULL DEFAULT '0',
  `t25` tinyint unsigned NOT NULL DEFAULT '0',
  `t26` tinyint unsigned NOT NULL DEFAULT '0',
  `t27` tinyint unsigned NOT NULL DEFAULT '0',
  `t28` tinyint unsigned NOT NULL DEFAULT '0',
  `t29` tinyint unsigned NOT NULL DEFAULT '0',
  `t32` tinyint unsigned NOT NULL DEFAULT '0',
  `t33` tinyint unsigned NOT NULL DEFAULT '0',
  `t34` tinyint unsigned NOT NULL DEFAULT '0',
  `t35` tinyint unsigned NOT NULL DEFAULT '0',
  `t36` tinyint unsigned NOT NULL DEFAULT '0',
  `t37` tinyint unsigned NOT NULL DEFAULT '0',
  `t38` tinyint unsigned NOT NULL DEFAULT '0',
  `t39` tinyint unsigned NOT NULL DEFAULT '0',
  `t42` tinyint unsigned NOT NULL DEFAULT '0',
  `t43` tinyint unsigned NOT NULL DEFAULT '0',
  `t44` tinyint unsigned NOT NULL DEFAULT '0',
  `t45` tinyint unsigned NOT NULL DEFAULT '0',
  `t46` tinyint unsigned NOT NULL DEFAULT '0',
  `t47` tinyint unsigned NOT NULL DEFAULT '0',
  `t48` tinyint unsigned NOT NULL DEFAULT '0',
  `t49` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `%prefix%tdata`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%training`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%training` (
  `id` MEDIUMINT unsigned NOT NULL AUTO_INCREMENT,
  `vref` SMALLINT unsigned NOT NULL,
  `unit` tinyint unsigned NOT NULL,
  `amt` int unsigned NOT NULL,
  `pop` tinyint unsigned NOT NULL,
  `timestamp` int unsigned NOT NULL,
  `eachtime` SMALLINT unsigned NOT NULL,
  `commence` int unsigned NOT NULL,
  `endat` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `unit` (`unit`),
  KEY `endat` (`endat`),
  KEY `amt` (`amt`),
  KEY `vref` (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%training`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%units`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%units` (
  `vref` SMALLINT unsigned NOT NULL,
  `hero` tinyint unsigned NOT NULL DEFAULT '0',
  `u1` int unsigned NOT NULL DEFAULT '0',
  `u2` int unsigned NOT NULL DEFAULT '0',
  `u3` int unsigned NOT NULL DEFAULT '0',
  `u4` int unsigned NOT NULL DEFAULT '0',
  `u5` int unsigned NOT NULL DEFAULT '0',
  `u6` int unsigned NOT NULL DEFAULT '0',
  `u7` int unsigned NOT NULL DEFAULT '0',
  `u8` int unsigned NOT NULL DEFAULT '0',
  `u9` int unsigned NOT NULL DEFAULT '0',
  `u10` int unsigned NOT NULL DEFAULT '0',
  `u11` int unsigned NOT NULL DEFAULT '0',
  `u12` int unsigned NOT NULL DEFAULT '0',
  `u13` int unsigned NOT NULL DEFAULT '0',
  `u14` int unsigned NOT NULL DEFAULT '0',
  `u15` int unsigned NOT NULL DEFAULT '0',
  `u16` int unsigned NOT NULL DEFAULT '0',
  `u17` int unsigned NOT NULL DEFAULT '0',
  `u18` int unsigned NOT NULL DEFAULT '0',
  `u19` int unsigned NOT NULL DEFAULT '0',
  `u20` int unsigned NOT NULL DEFAULT '0',
  `u21` int unsigned NOT NULL DEFAULT '0',
  `u22` int unsigned NOT NULL DEFAULT '0',
  `u23` int unsigned NOT NULL DEFAULT '0',
  `u24` int unsigned NOT NULL DEFAULT '0',
  `u25` int unsigned NOT NULL DEFAULT '0',
  `u26` int unsigned NOT NULL DEFAULT '0',
  `u27` int unsigned NOT NULL DEFAULT '0',
  `u28` int unsigned NOT NULL DEFAULT '0',
  `u29` int unsigned NOT NULL DEFAULT '0',
  `u30` int unsigned NOT NULL DEFAULT '0',
  `u31` int unsigned NOT NULL DEFAULT '0',
  `u32` int unsigned NOT NULL DEFAULT '0',
  `u33` int unsigned NOT NULL DEFAULT '0',
  `u34` int unsigned NOT NULL DEFAULT '0',
  `u35` int unsigned NOT NULL DEFAULT '0',
  `u36` int unsigned NOT NULL DEFAULT '0',
  `u37` int unsigned NOT NULL DEFAULT '0',
  `u38` int unsigned NOT NULL DEFAULT '0',
  `u39` int unsigned NOT NULL DEFAULT '0',
  `u40` int unsigned NOT NULL DEFAULT '0',
  `u41` int unsigned NOT NULL DEFAULT '0',
  `u42` int unsigned NOT NULL DEFAULT '0',
  `u43` int unsigned NOT NULL DEFAULT '0',
  `u44` int unsigned NOT NULL DEFAULT '0',
  `u45` int unsigned NOT NULL DEFAULT '0',
  `u46` int unsigned NOT NULL DEFAULT '0',
  `u47` int unsigned NOT NULL DEFAULT '0',
  `u48` int unsigned NOT NULL DEFAULT '0',
  `u49` int unsigned NOT NULL DEFAULT '0',
  `u50` int unsigned NOT NULL DEFAULT '0',
  `u199` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`vref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `%prefix%units`
--


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%users`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%users` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `username` char(45) NOT NULL,
  `password` char(45) NOT NULL,
  `email` char(45) NOT NULL,
  `tribe` tinyint unsigned NOT NULL,
  `access` tinyint unsigned NOT NULL DEFAULT '1',
  `gold` SMALLINT NOT NULL DEFAULT '0',
  `boughtgold` SMALLINT NOT NULL DEFAULT '0',
  `giftgold` SMALLINT NOT NULL DEFAULT '0',
  `transferedgold` SMALLINT NOT NULL DEFAULT '0',
  `Addgold` SMALLINT NOT NULL DEFAULT '0',
  `usedgold` SMALLINT NOT NULL DEFAULT '0',
  `silver` SMALLINT NOT NULL DEFAULT '0',
  `Addsilver` SMALLINT NOT NULL DEFAULT '0',
  `giftsilver` SMALLINT NOT NULL DEFAULT '0',
  `usedsilver` SMALLINT NOT NULL DEFAULT '0',
  `ausilver` SMALLINT NOT NULL DEFAULT '0',
  `bidsilver` SMALLINT NOT NULL DEFAULT '0',
  `gender` tinyint unsigned NOT NULL DEFAULT '0',
  `birthday` date NOT NULL DEFAULT '0000-00-00',
  `location` char(40) NOT NULL DEFAULT '',
  `desc1` char(255) NOT NULL,
  `desc2` char(255) NOT NULL,
  `plus` int unsigned NOT NULL DEFAULT '0',
  `goldclub` int unsigned NOT NULL DEFAULT '0',
  `b1` int unsigned NOT NULL DEFAULT '0',
  `b2` int unsigned NOT NULL DEFAULT '0',
  `b3` int unsigned NOT NULL DEFAULT '0',
  `b4` int unsigned NOT NULL DEFAULT '0',
  `b5` int unsigned NOT NULL DEFAULT '0',
  `att` int unsigned NOT NULL DEFAULT '0',
  `def` int unsigned NOT NULL DEFAULT '0',
  `sit1` int unsigned NOT NULL DEFAULT '0',
  `sit2` int unsigned NOT NULL DEFAULT '0',
  `alliance` int unsigned NOT NULL DEFAULT '0',
  `sessid` char(166) NOT NULL,
  `act` char(10) NOT NULL,
  `timestamp` int unsigned NOT NULL DEFAULT '0',
  `ap` int unsigned NOT NULL DEFAULT '0',
  `apall` int unsigned NOT NULL DEFAULT '0',
  `dp` int unsigned NOT NULL DEFAULT '0',
  `dpall` int unsigned NOT NULL DEFAULT '0',
  `protect` int unsigned NOT NULL,
  `quest` TINYINT NOT NULL,
  `fquest` char(20) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0',
  `quest_battle` char(30) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0',
  `quest_economy` char(20) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0',
  `quest_world` char(30) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0',
  `gpack` char(60) NOT NULL DEFAULT 'gpack/travian_4.4-TomBox/',
  `cp` int unsigned NOT NULL DEFAULT '1',
  `lastupdate` int unsigned NOT NULL,
  `RR` BIGINT NOT NULL DEFAULT '0',
  `Rc` BIGINT NOT NULL DEFAULT '0',
  `ok` tinyint unsigned NOT NULL DEFAULT '0',
  `clp` bigint NOT NULL DEFAULT '0',
  `oldrank` bigint unsigned NOT NULL DEFAULT '0',
  `activateat` int unsigned NOT NULL,
  `lang` char(2) NOT NULL DEFAULT 'en',
  `ancestor` char(30) NOT NULL,
  `ancestorgold` int NOT NULL DEFAULT '0',
  `reg2` tinyint NOT NULL DEFAULT '0',
  `ignore_msg` char(100) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
  `ip` char(15) NOT NULL,
  `chat_config` tinyint NOT NULL DEFAULT '1',
  `timezone` tinyint NOT NULL DEFAULT '23',
  PRIMARY KEY (`id`),
  KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `%prefix%users`
--

INSERT INTO `%PREFIX%users` (`id`, `username`, `password`, `email`, `tribe`, `access`, `gold`, `gender`, `birthday`, `location`, `desc1`, `desc2`, `plus`, `b1`, `b2`, `b3`, `b4`, `sit1`, `sit2`, `alliance`, `sessid`, `act`, `timestamp`, `ap`, `apall`, `dp`, `dpall`, `protect`, `quest`, `fquest`, `gpack`, `cp`, `lastupdate`, `RR`, `Rc`, `ok`) VALUES
(4, 'Multihunter', '', 'multihunter@travian.sx', 4, 9, 0, 0, '0000-00-00', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 25, 35, 'gpack/travian_default/', 1, 0, 0, 0, 0),
(1, 'Support', '', 'support@travian.sx', 1, 8, 0, 0, '0000-00-00', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 25, 35, 'gpack/travian_default/', 1, 0, 0, 0, 0),
(3, 'Nature', '', 'support@travian.sx', 4, 8, 0, 0, '0000-00-00', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 25, 35, 'gpack/travian_default/', 1, 0, 0, 0, 0);


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%users_setting`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%users_setting` (
  `id` SMALLINT NOT NULL,
  `sitter1_set_1` tinyint NOT NULL,
  `sitter1_set_2` tinyint NOT NULL,
  `sitter1_set_3` tinyint NOT NULL,
  `sitter1_set_4` tinyint NOT NULL,
  `sitter1_set_5` tinyint NOT NULL,
  `sitter1_set_6` tinyint NOT NULL,
  `sitter2_set_1` tinyint NOT NULL,
  `sitter2_set_2` tinyint NOT NULL,
  `sitter2_set_3` tinyint NOT NULL,
  `sitter2_set_4` tinyint NOT NULL,
  `sitter2_set_5` tinyint NOT NULL,
  `sitter2_set_6` tinyint NOT NULL,
  `nopicn` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=COMPRESSED;

--
-- Dumping data for table `%PREFIX%users_setting`
--

-- ---------------------------------------------------

--
-- Table structure for table `%PREFIX%invite`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%emailinvite` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `uid` SMALLINT unsigned NOT NULL,
  `invemail` char(45) NOT NULL,
  `time` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%PREFIX%invite`
--
-- --------------------------------------------------------

--
-- Table structure for table `%prefix%vdata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%vdata` (
  `wref` int unsigned NOT NULL,
  `owner` int unsigned NOT NULL,
  `name` char(45) NOT NULL,
  `capital` tinyint unsigned NOT NULL,
  `pop` SMALLINT unsigned NOT NULL,
  `cp` SMALLINT unsigned NOT NULL,
  `evasion` tinyint NOT NULL,
  `celebration` int NOT NULL DEFAULT '0',
  `type` int NOT NULL DEFAULT '0',
  `wood` float(12,2) NOT NULL,
  `clay` float(12,2) NOT NULL,
  `iron` float(12,2) NOT NULL,
  `woodp` float(12,2) NOT NULL,
  `clayp` float(12,2) NOT NULL,
  `ironp` float(12,2) NOT NULL,
  `maxstore` int unsigned NOT NULL,
  `extra_maxstore` int unsigned NOT NULL,
  `crop` float(12,2) NOT NULL,
  `cropp` float(12,2) NOT NULL,
  `maxcrop` int unsigned NOT NULL,
  `extra_maxcrop` int unsigned NOT NULL,
  `upkeep` float(10) unsigned NOT NULL,
  `lastupdate` int unsigned NOT NULL,
  `loyalty` tinyint NOT NULL DEFAULT '100',
  `exp1` SMALLINT NOT NULL,
  `exp2` SMALLINT NOT NULL,
  `exp3` SMALLINT NOT NULL,
  `created` int NOT NULL,
  `natar` tinyint unsigned NOT NULL,
  `starv` int unsigned NOT NULL,
  `expandedfrom` SMALLINT unsigned NOT NULL,
  PRIMARY KEY (`wref`),
  KEY `pop` (`pop`),
  KEY `capital` (`capital`),
  KEY `owner` (`owner`),
  KEY `woodp` (`woodp`),
  KEY `clayp` (`clayp`),
  KEY `ironp` (`ironp`),
  KEY `cropp` (`cropp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `%prefix%vdata`
--


-- --------------------------------------------------------

--
-- Table structure for table `%prefix%wdata`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%wdata` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `fieldtype` tinyint unsigned NOT NULL,
  `oasistype` tinyint unsigned NOT NULL,
  `x` SMALLINT NOT NULL,
  `y` SMALLINT NOT NULL,
  `occupied` tinyint NOT NULL,
  `image` char(12) NOT NULL,
  `pos` mediumint(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `x` (`x`),
  KEY `y` (`y`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `%prefix%wdata`
--

-- --------------------------------------------------------

--
-- Table structure for table `%prefix%natarsprogress`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%natarsprogress` (
  `lastexpandat` int NOT NULL,
  `lastpopupedvillage` int NOT NULL,
  `lastpopupat` int NOT NULL,
  `artefactreleased` tinyint NOT NULL,
  `artefactreleasedat` int NOT NULL,
  `wwbpreleased` tinyint NOT NULL,
  `wwbpreleasedat` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `%PREFIX%natarsprogress` (`lastexpandat`, `lastpopupedvillage`, `lastpopupat`, `artefactreleased`, `artefactreleasedat`, `wwbpreleased`, `wwbpreleasedat`) VALUES
(0, 0, 0, 0, 0, 0, 0);


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%map_marks`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%map_marks` (
  `id` SMALLINT unsigned NOT NULL AUTO_INCREMENT,
  `uid` SMALLINT NOT NULL,
  `x` smallint NOT NULL,
  `y` smallint NOT NULL,
  `index` tinyint NOT NULL,
  `text` char(30) COLLATE utf8_persian_ci NOT NULL,
  `kid` int NOT NULL,
  `plus` int NOT NULL,
  `type` char(10) COLLATE utf8_persian_ci NOT NULL,
  `dataId` SMALLINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Table structure for table `%PREFIX%msg_reports`
--

CREATE TABLE IF NOT EXISTS `%PREFIX%msg_reports` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` SMALLINT unsigned NOT NULL,
  `reported_by` char(15) COLLATE utf8_persian_ci NOT NULL,
  `viewed` tinyint NOT NULL DEFAULT '0',
  `delet` tinyint NOT NULL DEFAULT '0',
  `reason` char(100) COLLATE utf8_persian_ci NOT NULL,
  `time` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `playerId` int NOT NULL,
  `amunt` double NOT NULL,
  `gold` int NOT NULL,
  `time` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `orderid` char(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `x_world` (
  `id` int NOT NULL DEFAULT '0',
  `x` SMALLINT DEFAULT NULL,
  `y` SMALLINT DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `y` (`y`),
  KEY `x` (`x`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;