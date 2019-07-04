/*
SQLyog Ultimate - MySQL GUI v8.2 
MySQL - 5.5.5-10.1.31-MariaDB : Database - idealninajemce
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `accessright` */

CREATE TABLE `accessright` (
  `id_user_admin` int(4) DEFAULT NULL,
  `id_village` int(4) DEFAULT NULL,
  `right_addressbook` tinyint(1) DEFAULT NULL,
  `right_search` tinyint(1) DEFAULT NULL,
  KEY `FK_right_user` (`id_user_admin`),
  KEY `FK_right_village` (`id_village`),
  CONSTRAINT `FK_right_user` FOREIGN KEY (`id_user_admin`) REFERENCES `user_admin` (`id_user_admin`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_right_village` FOREIGN KEY (`id_village`) REFERENCES `village` (`id_village`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

/*Data for the table `accessright` */

insert  into `accessright`(`id_user_admin`,`id_village`,`right_addressbook`,`right_search`) values (1,1,0,0),(1,2,1,1),(2,1,1,0),(2,2,0,1),(3,1,0,1),(3,2,0,0);

/*Table structure for table `user_admin` */

CREATE TABLE `user_admin` (
  `id_user_admin` int(4) NOT NULL AUTO_INCREMENT,
  `name_user_admin` char(64) COLLATE utf8_czech_ci DEFAULT NULL,
  PRIMARY KEY (`id_user_admin`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

/*Data for the table `user_admin` */

insert  into `user_admin`(`id_user_admin`,`name_user_admin`) values (1,'Adam'),(2,'Bob'),(3,'Cyril');

/*Table structure for table `village` */

CREATE TABLE `village` (
  `id_village` int(4) NOT NULL AUTO_INCREMENT,
  `name_village` char(64) COLLATE utf8_czech_ci DEFAULT NULL,
  PRIMARY KEY (`id_village`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

/*Data for the table `village` */

insert  into `village`(`id_village`,`name_village`) values (1,'Praha'),(2,'Brno');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
